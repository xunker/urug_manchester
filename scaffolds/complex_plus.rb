# "Complex-Plus" challenge. Signals are structured like in "complicated" and
# "complex", but here the length of each pulse may vary slightly over time
# from the value in source.pulse_size. You will need to allow for the changes
# at the edge of the frames and between pulses to be slightly out of sync. They
# won't be more than 10 percent off.

require_relative '../manchester'

source = Manchester::ComplexPlus.new

payload = ''

puts "Pulse size is #{source.pulse_size}."

# Insert your code here. Remember that the pulse length may vary up to 10%, so
# you will need to account for that and  have your code adjust accordingly.

# A simple loop, like in all the other challenges, probably won't work here.
# You'll need to build a full state-machine.

puts "Decoded payload is #{payload.inspect}."
if simple.payload_correct?(payload)
  puts "Payload is correct!"
else
  puts "Payload is not correct."
end
