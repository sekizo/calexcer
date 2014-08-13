module Calexcer
  module Sheetable    
    attr_reader :sheet
    
    def to_hash
      raise Calexcer::MethodNotImplementedError
    end
    
    def to_reversed_hash
      _events = {}
      self.to_hash.each do |date, events|
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
    
    #--------------------#
    protected
      
      attr_writer :sheet
    
    #--------------------#
    private
      
      def dimensions
        @row_start, @row_end, @col_start, @col_end = self.sheet.dimensions
      end
      
      def method_missing(name, *args, &block)
        begin
          self.sheet.__send__(name, *args, &block)
        rescue => e
          super
        end
      end
    
  end
end
