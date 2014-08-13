require "calexcer/sheet"
require "calexcer/loopable"

module Calexcer
  class VerticalSheet < Calexcer::Sheet
    include Calexcer::Loopable
    
    def initialize(sheet, year: nil, month: nil)
      super(sheet)
      self.initialize_year_month(year: year, month: month)
    end
    
    def to_hash
      @events = {}
      
      self.loop do |cell|
        case cell.value
        when Date
          self.cell_as_date(cell.value)
        else
          self.cell_as_string(cell.value, self.current_date)
        end
      end
      
      @events
    end
    
    #--------------------#
    protected
      
      def add_event(date, event)
        return nil if date.nil?
        @events[date] ||= []
        @events[date] << event unless event.nil?
      end
      
      def cell_as_date(date)
        self.current_date = date
      end
      
      def cell_as_string(string, date)
        self.add_event(self.current_date, string)
      end
      
      def loop(&block)
        self.loop_vertical(&block)
      end
      
      def vertical_loop_unit_will_start(row)
        super(row)
        self.current_year = self.year
        self.current_month = self.month
      end
      
      def vertical_loop_unit_did_end
        super
        self.current_date = nil
      end
      
  end
end
