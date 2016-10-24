module Manchester
  class Simple < Base
    def pulse_size
      1
    end

    def includes_sync_header?
      false
    end

    def initialize
      @position = 0
    end

    def pulses
      @pulses ||= ([PAYLOAD_SIZE] + MESSAGE).map{|byte| byte.map{|bit| PULSE_DESCRIPTIONS[bit]}}.flatten
    end

    def get_next_pulse
      if pulse = pulses[@position]
        @position += 1
        pulse
      else
        gone_too_far!
      end
    end
  end
end
