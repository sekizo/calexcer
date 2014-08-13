require "nkf"

module Calexcer
  class Cell
    EXCEL_DATE_START = DateTime.new(1900,1,1).freeze
    
    attr_reader :cell
    attr_accessor :year, :month
    
    def initialize(cell, year: nil, month: nil)
      super()
      self.cell = cell
      today = Date.today
      self.year = year||today.year
      self.month = month||today.month
    end
    
    def value
      case self.cell
      when Date
        self.cell.to_date
      when String
        value_as_string(self.cell)
      when Numeric
        value_as_date(self.cell)
      when Spreadsheet::Formula
        value_as_formula(self.cell.value)
      end
    end
    
    #--------------------#
    protected
    
      attr_writer :cell
      
    #--------------------#
    private
      
      def value_as_date(cell_value)
        begin
          Date.new(self.year, self.month, cell_value)
        rescue ArgumentError => e
          EXCEL_DATE_START + cell_value - 2
        end
      end
      
      def value_as_formula(cell_value)
        case cell_value
        when String
          value_as_string(cell_value)
        else
          value_as_date(cell_value)
        end
      end
      
      def value_as_string(value)
        v = NKF::nkf('-WwZ1', value)
        case  v
        when /^[0-9]+/
          value_as_date(v.match(/^[0-9]+/).to_s.to_i)
        else
          value
        end
      end
  end
end