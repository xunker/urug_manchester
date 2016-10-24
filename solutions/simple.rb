require_relative '../manchester'

simple = Manchester::Simple.new

payload = ''
payload_size = nil

def read_bit(source)
  pulses = 2.times.map do |_i|
    source.get_next_pulse
  end
  if pulses == [0,1]
    0
  else
    1
  end
end

def read_byte(source)
  8.times.map do |_i|
    read_bit(source).to_s
  end.join.tap{|s| puts s.inspect}
end

while !payload_size || (payload.length < payload_size)
  puts payload.length
  if !payload_size
    payload_size = read_byte(simple).to_i(2)
    puts "Payload size is #{payload_size}"
  else
    # payload << read_byte(simple).unpack('h*')
    character = [read_byte(simple)].pack('B*')
    puts character.inspect
    payload << character
    sleep(0.1)
  end
end

puts "Payload is #{payload.inspect}"
