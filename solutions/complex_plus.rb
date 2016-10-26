# This is the same as complex.rb, except #read_bit is modified.
require_relative '../manchester'

source = Manchester::ComplexPlus.new
# This will also work if the source is Manchester::Simple, ::Complicated or
# ::Complex.

payload = ''
payload_size = nil

# def read_bit(source)
#   pulses = 2.times.map{
#
#     # Add all numbers in the pulse together.
#     pulse = source.pulse_size.times.map{
#       # print '.'
#       source.read_signal
#     }.inject(:+)
#
#     # Check the total; we are essentially getting an average and rounding it
#     # up to 1 or down to 0, but without the division step.
#     if pulse > (source.pulse_size/2)
#       1
#     else
#       0
#     end
#   }
#
#   if pulses == [0,1]
#     0
#   else
#     1
#   end
# end
#
# def read_byte(source)
#   8.times.map{
#     read_bit(source).to_s
#   }.join
# end

TIMES_TO_READ_SOURCE = source.pulse_size/10
FUDGE = source.pulse_size*0.05 # fudge factor, how far timing can be off per frame/pulse

@current_signal_position = 0

@previous_signal = nil
@expect_next_frame = @current_signal_position
@expect_next_transition = @expect_next_frame + source.pulse_size

def signal_changed?(source)
  # Add all numbers in the pulse together.
  pulse = TIMES_TO_READ_SOURCE.times.map{
    # print '.'
    @current_signal_position += 1
    source.read_signal
  }.inject(:+)

  # Check the total; we are essentially getting an average and rounding it
  # up to 1 or down to 0, but without the division step.
  # puts pulse.inspect
  current_signal = (pulse > (TIMES_TO_READ_SOURCE/2)) ? 1 : 0

  changed = current_signal == @previous_signal
  @previous_signal = current_signal
  changed
end

while !payload_size || (payload.length < payload_size)

  current_byte_pulses = ''
  until current_byte_pulses.length > 15 do
    if signal_changed?(source)
      # did change occur at beginning of frame? check expect_next_frame with fudge
      if (@current_signal_position >= (@expect_next_frame - FUDGE)) && (@current_signal_position < (@expect_next_frame + FUDGE))
        # set expect_next_transition
        @expect_next_transition = @current_signal_position + source.pulse_size
        # set expect_next_frame
        @expect_next_frame = @current_signal_position + (source.pulse_size*2)

    # did change occur in middle of frame?  check expect_next_transition with fudge
    elsif (@current_signal_position >= (@expect_next_transition - FUDGE)) && (@current_signal_position < (@expect_next_transition + FUDGE))
        # record the bit
        current_byte_pulses << @previous_signal.to_s
        # set expect_next_frame
        @expect_next_frame = @current_signal_position + (source.pulse_size*2)
        # set expect_next_transition
        @expect_next_transition = @current_signal_position + source.pulse_size

        # print '-'
        print "#{@previous_signal}"
      else
        # print '.'
      end
    end
  end

  # puts "\n"

  if payload_size.nil?
    payload_size = current_byte_pulses.scan(/.{2}/).map{|frame| frame == '01' ? 0 : 1}.join.to_i(2)
    puts " Done reading #{payload_size} bytes."
  else
    decoded_byte = [current_byte_pulses.scan(/.{2}/).map{|frame| frame == '01' ? '0' : '1'}.join].pack('B*')
    puts " #{decoded_byte}"
    payload << decoded_byte
  end

end

puts "Decoded payload is #{payload.inspect}."
if source.payload_correct?(payload)
  puts "Payload is correct!"
else
  puts "Payload is not correct."
end
