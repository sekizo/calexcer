require "json"

module Calexcer
  module Sheetable
    EXCEL_DATE_START = DateTime.new(1900,1,1).freeze
    
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
    
    def to_json
      self.to_hash.to_json
    end
    
    def to_reversed_json
      self.to_reversed_hash.to_json
    end
    alias_method :to_r_json, :to_reversed_json
    
    #--------------------#
    protected
      
      attr_writer :sheet
    
    #--------------------#
    private
      
      def dimensions
        @row_start, @row_end, @col_start, @col_end = self.sheet.dimensions
      end
      
      def cell_to_datetime(cell)
        EXCEL_DATE_START + cell.value - 2
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
