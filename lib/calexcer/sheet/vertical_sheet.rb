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
        v = normalize(cell)
        case v
        when Date
          self.current_date = v
        when Integer
          self.current_date = Date.new(self.current_)
        else
          self.add_event(self.current_date, v)
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
    
    def loop(&block)
      self.loop_vertical(&block)
    end
    
    def vertical_loop_unit_did_end
      super
      self.current_date = nil
    end
    
    #--------------------#
    private
      
      def normalize(cell)
        case cell
        when Spreadsheet::Formula
          cell_to_datetime(cell).to_date
        when DateTime
          cell.to_date
        when Integer
          Date.new(self.current_year, self.current_month, cell)
        else
          cell
        end
      end
    
  end
end
