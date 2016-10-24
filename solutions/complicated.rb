# This largely the same as simple.rb, except #read_bit is modified.
require_relative '../manchester'

source = Manchester::Complicated.new
# This will also work if the source is Manchester::Simple

payload = ''
payload_size = nil

def read_bit(source)
  pulses = 2.times.map{
    source.pulse_size.times.map{
      print '.'
      source.get_next_pulse
    }.uniq
  }.flatten

  if pulses == [0,1]
    0
  else
    1
  end
end

def read_byte(source)
  8.times.map{
    read_bit(source).to_s
  }.join
end

while !payload_size || (payload.length < payload_size)
  if !payload_size
    payload_size = read_byte(source).to_i(2)
    puts "Payload size is #{payload_size}"
  else
    character = [read_byte(source)].pack('B*')
    payload << character
    sleep(0.1) # for dramatic effect!
  end
end

puts "Done reading #{payload_size} bytes."
puts "Decoded payload is #{payload.inspect}."
if source.payload_correct?(payload)
  puts "Payload is correct!"
else
  puts "Payload is not correct."
end
