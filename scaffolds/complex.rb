# "Complex" challenge. Each "pulse" from the source is represented by a run
# of many "1" or "0", just like in the "complicated" challenge, but now there
# are a few one-character errors in the stream. You will need to filter them
# out. For example:
#
# If the frame is "00001000001111111111", remove the error in the first pulse
# and read the bit as "0".
# If the frame is "11111111110000010000", remove the error in the second pulse
# and read the bit as "1".
#
# Note: There *may* be multiple errors in a single pulse, but there will never
# be more than 3 errors in total in the data. Errors are inserted at random and
# will change every time you run the code.

require_relative '../manchester'

source = Manchester::Complex.new

payload = ''

puts "Pulse size is #{source.pulse_size}."

# Insert your code here. Remember that the frame length is the same as before
# but there are a few single errors in it. Also, remember to run your solution
# multiple times to make sure it works with the random errors.

puts "Decoded payload is #{payload.inspect}."
if simple.payload_correct?(payload)
  puts "Payload is correct!"
else
  puts "Payload is not correct."
end
