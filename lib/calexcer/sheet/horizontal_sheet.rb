require "calexcer/sheet"
require "calexcer/loopable"

module Calexcer
  class HorizontalSheet < Calexcer::Sheet
    include Calexcer::Loopable
    
    def initialize(sheet, year: nil, month: nil)
      super(sheet)
      self.initialize_year_month(year: year, month: month)
    end
    
    def to_hash
      self.events = {}
      self.dates = {}
      
      self.loop do |cell|
        v = normalize(cell)
        
        case v
        when nil
        when Date
          self.current_date = v
          self.dates[self.x]  = v
        when String
          self.cell_string(v, dates[self.x])
        end
      end
      
      self.events
    end
    
    #--------------------#
    protected
      
      attr_accessor :current_event
      attr_accessor :events, :dates
      
      def cell_string(string, date)
        case
        when string.empty?
        when event_definition?(string)
          self.current_event = string
        else
          if (date) && (self.current_event)
            self.events[date] ||= []
            self.events[date] << self.current_event
          end
        end
      end
      
      def loop(&block)
        self.loop_horizontal(&block)
      end
      
      def horizontal_loop_unit_will_start(col)
        super(col)
        self.current_year = self.year
        self.current_month = self.month
      end
      
      def horizontal_loop_unit_did_end
        super
        self.current_event = nil
      end
      
    #--------------------#
    private
      
      def event_definition?(string)
        (self.current_event.nil?) && (self.x == 0) && (! string.empty?)
      end
      
  end
end
