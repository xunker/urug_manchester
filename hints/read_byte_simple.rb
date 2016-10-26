# Reading bits and converting them to a binary byte.
# For the "simple" challenge, it won't work with any of the other challenges
# unless you modify it.

# Assume `source` is an instance of Manchester::Simple.

byte = 8.times.map{
  pulses = 2.times.map do
    source.read_signal
  end

  bit = if pulses == [0,1] # low-high
    0
  elsif pulses == [1,0] # high-low
    1
  end

  bit.to_s
}.join

# `byte` is now a string of 8 bits.
