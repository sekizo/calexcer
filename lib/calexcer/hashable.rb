module Calexcer
  module Hashable    
    def to_hash(*args)
      raise Calexcer::MethodNotImplementedError
    end
    
    def to_reversed_hash(*args)
      _events = {}
      self.to_hash(*args).each do |date, events|
        events.each do |event|
          unless event.nil?
            _events[event] ||= []
            _events[event] << date
          end
        end
      end
      
      _events
    end
    alias_method :to_r_hash, :to_reversed_hash
    alias_method :to_hashr, :to_reversed_hash
  end
end
