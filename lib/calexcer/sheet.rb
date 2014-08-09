require "calexcer/sheetable"
module Calexcer
  class Sheet
    include Calexcer::Sheetable
    
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
    
    #--------------------#
    private
      
      def sheet_class(name)
        self.class.sheet_class_name(name)
      end
      
      def method_missing(name, *args, &block)
        begin
          if Calexcer.const_defined?(sheet_class(name))
            Calexcer.const_get(sheet_class(name)).new(self.sheet)
          else
            self.sheet.__send__(name, *args, &block)
          end
        rescue => e
          super
        end
      end
      
  end # class Sheet
end # module Calexcer
