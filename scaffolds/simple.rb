# "Simple" challenge. Each "pulse" from the source is represented by a single
# "1" or "0". A pair of pulses is called a "frame", and will represent a binary
# "bit".
#
# If the frame is "01", then the bit is a "0".
# If the frame is "10", then the bit it a "1".
#
# You should never receive a frame that is "00" or "11"; if you see one of those
# then you probably have a timing problem somewhere.
#
# Read 8 bit and join them together to get one binary "byte".
#
# The first byte you read will be the "payload size" and will need to be
# converted in to an integer. This number tells you how many remaining bytes are
# left in the source stream.
#
# Once you have read the payload size, keep reading one byte from the source and
# convert it in a character (not an integer). Keep doing this until you have
# read the number of bytes indicated by payload size.
#
# Then, stop reading the source and combine all your characters in to a string.
# Check if this new string is the correctly decoded data by calling the
# `#payload_correct?` method. If that returns true then it is correct.

require_relative '../manchester'

source = Manchester::Simple.new

payload = ''

# Put your code here. See additional instructions in the comments at the top
# of this file.
# First you will need to read the payload size.
# Then you will need to read that many bytes from the source, covert them in to
# characters and append them to the `payload` string variable.
#
# Get a "pulse" from the source by calling `source.get_next_pulse`

puts "Decoded payload is #{payload.inspect}."
if simple.payload_correct?(payload)
  puts "Payload is correct!"
else
  puts "Payload is not correct."
end
