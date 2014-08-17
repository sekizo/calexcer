require "spec_helper"

describe Calexcer::Book do
  let(:sample) { Calexcer::Samples[:vertical] }
  let(:calexcer) { described_class.new(sample) }
  
  describe "#path" do
    example "get path" do
      expect(calexcer.path).to eq(sample)
    end
  end
  
  describe "#book" do
    example "get spreadsheet instance" do
      expect do
        calexcer.book
      end.not_to raise_error
    end
  end
  
  describe "#sheets" do
    example "get an Array" do
      expect(calexcer.sheets).to be_a(Array)
    end
    
    example "includes Calexcer::Sheet" do
      calexcer.sheets.each do |sheet|
        expect(sheet).to be_a(Calexcer::Sheet)
      end
    end
  end
end
