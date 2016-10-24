# "Complicated" challenge. Each "pulse" from the source is represented by a run
# of many "1" or "0". Each of these runs will need to be detected and turned
# in to a single pulse, which will then be combined in to a frame and translated
# to as bit.
# If the frame is "00000000001111111111", then the bit is a "0".
# If the frame is "11111111110000000000", then the bit it a "1".
#
# REMEMBER: you can see how long a pulse is (the number of 1s or 0s in it) by
# using the source#pulse_size.

require_relative '../manchester'

source = Manchester::Complex.new

payload = ''

puts "Pulse size is #{source.pulse_size}."

# Insert your code here.
# Use the same approach as simple.rb, but also use the source#pulse_size to
# know how many 1s/0s in a row represent a single pulse.

puts "Decoded payload is #{payload.inspect}."
if simple.payload_correct?(payload)
  puts "Payload is correct!"
else
  puts "Payload is not correct."
end
