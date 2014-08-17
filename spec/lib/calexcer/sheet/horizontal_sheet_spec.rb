require "spec_helper"
require "lib/shared_spec/shared_hashable_spec"

describe Calexcer::HorizontalSheet do
  let(:sample) { Calexcer::Samples[:horizontal] }
  let(:calexcer) { Calexcer::Book.new(sample) }
  let(:sheet) { calexcer.sheets.first.horizontal_sheet }
  
  example "Loopable" do
    expect(sheet).to be_a(Calexcer::Loopable)
  end
  
  describe "#to_hash" do
    example "get Hash calendar" do
      expect(sheet.to_hash).to be_a(Hash)
    end
    
    example "get calendar" do
      events = sheet.to_hash
      
      expect(events[Date.new(2014, 8, 3)]).to be_include("sunday game")
      expect(events[Date.new(2014, 8, 31)]).to be_include("live")
    end
    
    it_behaves_like "specified dimensions"
    
  end
  
  describe "#to_reversed_hash" do
    example "get reversed Hash calendar" do
      expect(sheet.to_r_hash).to be_a(Hash)
    end
    
    example "get calendar" do
      events = sheet.to_r_hash
      
      expect(events["sunday game"]).to  be_include(Date.new(2014, 8, 3))
      expect(events["sunday game"].size).to  eq 5
      expect(events["live"]).to         be_include(Date.new(2014, 8, 31))
    end
  end
  
end
