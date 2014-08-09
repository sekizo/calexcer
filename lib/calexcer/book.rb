require "spreadsheet"

module Calexcer
  class Book
    attr_reader :path
    
    def initialize(path)
      self.path = path
    end
    
    def book
      @book ||= Spreadsheet.open(self.path, "rb")
    end
    
    def sheets
      self.book.worksheets.collect{ |c| Calexcer::Sheet.new(c) }
    end
    
    #--------------------#
    protected
      
      attr_writer :path
  end
end
