require "spec_helper"

describe Calexcer::Sheet do
  let(:sample) { Calexcer::Samples[:vertical] }
  let(:calexcer) { Calexcer::Book.new(sample) }
  let(:sheet) { calexcer.sheets.first }
  
  example "sheetable" do
    expect(sheet).to be_a(Calexcer::Sheetable)
  end
  
  describe ".sheet_class_name" do
    example "get sheet class name" do
      expect(described_class.sheet_class_name("dummy")).to eq "Calexcer::Dummy"
      expect(described_class.sheet_class_name("dummy/layered_class")).to eq "Calexcer::Dummy::LayeredClass"
    end
  end
  
  describe "#vertical_sheet" do
    example "get a VerticalSheet" do
      expect(sheet.vertical_sheet).to be_a(Calexcer::VerticalSheet)
    end
  end
  
  describe "#horizontal_sheet" do
    example "get a HorizontalSheet" do
      expect(sheet.horizontal_sheet).to be_a(Calexcer::HorizontalSheet)
    end
  end
end
