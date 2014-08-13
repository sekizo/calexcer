require "spec_helper"

describe Calexcer::Cell do
  let(:sample) { Calexcer::Samples[:vertical] }
  let(:calexcer) { Calexcer::Book.new(sample) }
  let(:sheet) { calexcer.sheets.first }
  
  let(:target) { described_class.new(sheet[0, 0], year: 2014, month: 8) }
  describe "#value" do
    context "nill cell" do
      before { allow(target).to receive(:cell) { nil } }
      example("return nil") { expect(target.value).to be_nil }
    end
    
    context "Date cell" do
      before { allow(target).to receive(:cell) { DateTime.new(target.year, target.month, 1) } }
      example("return Date") { expect(target.value).to be_a(Date) }
      example("not return DateTime") { expect(target.value).not_to be_a(DateTime) }
    end
    
    context "Float cell" do
      let(:day) { 2.0 }
      before { allow(target).to receive(:cell) { day } }
      example("return Date") { expect(target.value).to be_a(Date) }
      example("return the date") { expect(target.value.day).to eq day }
    end
    
    context "Integer cell" do
      let(:day) { 3 }
      before { allow(target).to receive(:cell) { day } }
      example("return Date") { expect(target.value).to be_a(Date) }
      example("return the date") { expect(target.value.day).to eq day }
    end
    
    context "Spreadsheet::Formula cell" do
      let(:sample_cell) { { pos: { row: 8, col: 1 }, value: Date.new(2014, 8, 4) } }
      let(:target) { described_class.new(sheet[sample_cell[:pos][:row], sample_cell[:pos][:col]], year: 2014, month: 8) }
      example("return Date") { expect(target.value).to be_a(Date) }
      example("return the date") { expect(target.value).to eq sample_cell[:value] }
      
    end
  end
end
