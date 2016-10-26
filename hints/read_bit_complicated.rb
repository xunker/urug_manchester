# Reading pulses and converting them to a bit.
# For the "simple" and "complicated" challenges, it won't work with any of the
# other challenges unless you modify it.

# Assume `source` is an instance of Manchester::Simple or ::Complicated.

pulses = 2.times.map{
  source.pulse_size.times.map{
    print '.'
    source.read_signal
  }.uniq
}.flatten

bit = if pulses == [0,1] # low-high
  0
elsif pulses == [1,0] # high-low
  1
end

# `bit` is now a 1 or a 0.
