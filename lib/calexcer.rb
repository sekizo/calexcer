require "calexcer/version"

Dir.glob(File.join(File.dirname(__FILE__), "/**/*.rb")).each do |entry|
  require entry
end

module Calexcer
  # Your code goes here...
end
