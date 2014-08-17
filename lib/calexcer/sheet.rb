require "calexcer/hashable"
require "calexcer/cell"

module Calexcer
  class Sheet
    include Calexcer::Hashable
    
    attr_reader :sheet
    
    def self.sheet_class_name(name)
      _name = []
      "#{name}".split("/").each do |layer|
        _name << layer.sub(/^(.)/) {|char| char.upcase }.gsub(/_(.)/) {|char| char.upcase.sub(/_/, "") }
      end
      
      "Calexcer::" + _name.join('::')
    end
    
    def initialize(sheet)
      self.sheet = sheet
    end
    
    def cell(row, col, cell_class: Calexcer::Cell)
      cell_class.new(self.sheet[row, col])
    end
    
    def [](row, col)
      self.sheet[row, col]
    end
    
    #--------------------#
    protected
      
      attr_writer :sheet
    
    #--------------------#
    private
      
      def dimensions(*args)
        arg = args.shift||{}
        
        @row_start, @row_end, @col_start, @col_end = self.sheet.dimensions
        
        @row_start =  arg[:row_start] || @row_start
        @row_end =    arg[:row_end]   || @row_end
        @col_start =  arg[:col_start] || @col_start
        @col_end =    arg[:col_end]   || @col_end
      end
      
      def sheet_class(name)
        self.class.sheet_class_name(name)
      end
      
      def method_missing(name, *args, &block)
        begin
          if Calexcer.const_defined?(sheet_class(name))
            Calexcer.const_get(sheet_class(name)).new(self.sheet, *args)
          else
            self.sheet.__send__(name, *args, &block)
          end
        rescue => e
          super
        end
      end
      
  end # class Sheet
end # module Calexcer
