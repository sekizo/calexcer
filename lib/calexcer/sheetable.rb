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
    alias_method :to_hashr, :to_reversed_hash
    
    #--------------------#
    protected
      
      attr_writer :sheet
    
    #--------------------#
    private
      
      def cell_to_datetime(cell)
        EXCEL_DATE_START + cell.value - 2
      end
      
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
      
      def normalize(cell)
        case cell
        when Spreadsheet::Formula
          cell_to_datetime(cell).to_date
        when DateTime, Date
          cell.to_date
        when Numeric
          Date.new(self.current_year, self.current_month, cell)
        else
          cell
        end
      end
      
  end
end
