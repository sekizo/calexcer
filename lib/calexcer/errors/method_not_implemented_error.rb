module Calexcer
  class MethodNotImplementedError < StandardError
    def message
      "method not implemented"
    end
  end
end