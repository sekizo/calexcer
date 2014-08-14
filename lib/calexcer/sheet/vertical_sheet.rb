require "calexcer/sheet"
require "calexcer/loopable"

module Calexcer
  class VerticalSheet < Calexcer::Sheet
    include Calexcer::Loopable
    
    def initialize(sheet, year: nil, month: nil)
      super(sheet)
      self.initialize_year_month(year: year, month: month)
    end
    
    def to_hash(ignore_header: true)
      self.ignore_header = ignore_header
      self.events = {}
      
      self.loop do |cell|
        case cell.value
        when Date
          self.cell_as_date(cell.value)
        else
          self.cell_as_string(cell.value, self.current_date)
        end
      end
      
      self.events
    end
    
    #--------------------#
    protected
      
      attr_accessor :events
      attr_accessor :ignore_header
      
      def add_event(date, event)
        return nil if date.nil?
        self.events[date] ||= []
        self.events[date] << event unless event.nil?
      end
      
      def cell_as_date(date)
        if self.ignore_header
          self.ignore_header = false
        else
          @dates ||= {}
          @dates[self.current_row] = date
          self.current_date = date
        end
      end
      
      def cell_as_string(string, date)
        self.add_event(self.current_date, string) unless self.ignore_header
        self.ignore_header = false
      end
      
      def loop(&block)
        self.loop_vertical(&block)
      end
      
      def vertical_loop_unit_will_start(row)
        super(row)
        self.current_year = self.year
        self.current_month = self.month
        
        @dates ||= {}
        self.current_date = @dates[row] unless @dates[row].nil?
        
      end
      
      def vertical_loop_unit_did_end
        super
        self.current_date = nil
      end
      
  end
end
