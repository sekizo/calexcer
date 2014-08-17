require "calexcer/sheet"
require "calexcer/loopable"

module Calexcer
  class VerticalSheet < Calexcer::Sheet
    include Calexcer::Loopable
    
    def initialize(sheet, year: nil, month: nil)
      super(sheet)
      self.initialize_year_month(year: year, month: month)
    end
    
    def to_hash(*args)
      hash_args = args.shift||{}
      
      self.ignore_header = hash_args[:ignore_header]||true
      self.events = {}
      
      self.loop(hash_args) do |cell|
        if (self.ignore_header) && (! cell.value.nil?)
          self.ignore_header = false
        else
          case cell.value
          when Date
            self.cell_as_date(cell.value)
          else
            self.cell_as_string(cell.value, self.current_date)
          end
        end
      end
      
      self.events
    end
    
    #--------------------#
    protected
      
      attr_accessor :events
      attr_accessor :ignore_header
      
      def add_event(date, event)
        return nil if (date.nil?)||(event.nil?)
        self.events[date] ||= []
        self.events[date] << event
      end
      
      def cell_as_date(date)
        @dates ||= {}
        @dates[self.current_row] = date
        self.current_date = date
      end
      
      def cell_as_string(string, date)
        self.add_event(self.current_date, string)
      end
      
      def loop(*args, &block)
        self.loop_vertical(*args, &block)
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
