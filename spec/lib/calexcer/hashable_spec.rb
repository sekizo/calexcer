require "spec_helper"

describe Calexcer::Hashable do
  let(:sample) { Calexcer::Samples[:vertical] }
  let(:calexcer) { Calexcer::Book.new(sample) }
  let(:sheet) { calexcer.sheets.first }
  
  describe ".to_hash" do
    example "raise Calexcer::MethodNotImplementedError" do
      expect do
        sheet.to_hash
      end.to raise_exception(Calexcer::MethodNotImplementedError)
    end
  end
  
  describe ".to_reversed_hash" do
    example "raise Calexcer::MethodNotImplementedError" do
      expect do
        sheet.to_reversed_hash
      end.to raise_exception(Calexcer::MethodNotImplementedError)
    end
  end
end
