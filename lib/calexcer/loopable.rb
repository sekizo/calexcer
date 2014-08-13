module Calexcer
  module Loopable
    attr_reader :current_row, :current_col
    attr_reader :x, :y
    
    attr_accessor :year, :month
    
    #--------------------#
    protected
      
      attr_accessor :row_start, :row_end, :col_start, :col_end
      
      attr_writer :current_row, :current_col
      attr_writer :x, :y
      
      attr_reader :current_date
      attr_accessor :current_year, :current_month
      
      def initialize_year_month(year: nil, month: nil)
        today = Date.today
        self.year = year||today.year
        self.month = month||today.month
      end
      
      def current_date=(date)
        @current_date = date
        if date.is_a?(Date)
          self.current_year = date.year
          self.current_month = date.year
        else
          self.current_year = self.year
          self.current_month = self.month
        end
      end
      
      def current_cell
        cell = self.cell(self.current_row, self.current_col)
        cell.year = self.year
        cell.month = self.month
        cell
      end
      
      def loop(&block)
        raise Calexcer::MethodNotImplementedError
      end
      
      def loop_vertical(&block)
        loop_will_start
        (self.col_start..self.col_end).each do |col|
          horizontal_loop_unit_will_start(col)
          (self.row_start..self.row_end).each do |row|
            vertical_loop_unit_will_start(row)
            yield(self.current_cell)
            vertical_loop_unit_will_end
          end
          vertical_loop_unit_did_end
          horizontal_loop_unit_will_end
        end
        horizontal_loop_unit_did_end
        loop_did_end
      end
      
      def loop_horizontal(&block)
        loop_will_start
        (self.row_start..self.row_end).each do |row|
          vertical_loop_unit_will_start(row)
          (self.col_start..self.col_end).each do |col|
            horizontal_loop_unit_will_start(col)
            yield(self.current_cell)
            horizontal_loop_unit_will_end
          end
          horizontal_loop_unit_did_end
          vertical_loop_unit_will_end
        end
        vertical_loop_unit_did_end
        loop_did_end
      end
        
      def loop_will_start
        dimensions
      end
      
      def loop_did_end
      end
      
      def horizontal_loop_unit_will_start(col)
        self.current_col = col
        self.x = self.current_col - self.col_start
      end
      
      def horizontal_loop_unit_will_end
      end
    
      def horizontal_loop_unit_did_end
      end
      
      def vertical_loop_unit_will_start(row)
        @current_row = row
        @y = @current_row - @row_start
      end
      
      def vertical_loop_unit_will_end
      end
      
      def vertical_loop_unit_did_end
      end
      
  end
end