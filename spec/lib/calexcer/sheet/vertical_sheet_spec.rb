require "spec_helper"
require "lib/shared_spec/shared_hashable_spec"

describe Calexcer::VerticalSheet do
  let(:sample) { Calexcer::Samples[:vertical] }
  let(:calexcer) { Calexcer::Book.new(sample) }
  let(:sheet) { calexcer.sheets.first.vertical_sheet }
  
  example "Loopable" do
    expect(sheet).to be_a(Calexcer::Loopable)
  end
  
  describe "#to_hash" do
    example "get Hash calendar" do
      expect(sheet.to_hash).to be_a(Hash)
    end
    
    example "get events" do
      expect(sheet.to_hash[Date.new(2014,8,1)]).to  be_include("My birthday")
      expect(sheet.to_hash[Date.new(2014,8,27)]).to be_include("My wife's birthday")
      expect(sheet.to_hash[Date.new(2014,8,13)]).to be_include("My friend's birthday")
      expect(sheet.to_hash[Date.new(2014,8,31)]).to be_include("My favorite artist's live")
      expect(sheet.to_hash[Date.new(2014,8,15)]).to be_include("World War 2 end")
    end
    
    example "block to get non-events" do
      expect(sheet.to_hash.collect{|k,v| v}.flatten).not_to be_include("Description of the calendar")
    end
    
    it_behaves_like "specified dimensions"
    
  end # describe "#to_hash"
  
  describe "#to_reversed_hash" do
    example "get hash" do
      expect(sheet.to_reversed_hash).to be_a(Hash)
    end
    
    example "get dates" do
      events = sheet.to_r_hash
      expect(events["My birthday"]).to                be_include(Date.new(2014, 8, 1))
      expect(events["My wife's birthday"]).to         be_include(Date.new(2014, 8, 27))
      expect(events["My friend's birthday"]).to       be_include(Date.new(2014, 8, 13))
      expect(events["My favorite artist's live"]).to  be_include(Date.new(2014, 8, 31))
      expect(events["World War 2 end"]).to            be_include(Date.new(2014, 8, 15))
    end
    
    example "block to get non-events" do
      events = sheet.to_r_hash
      expect(events["Description of the calendar"]).to be_nil
    end
    
  end # describe "#to_reversed_hash"
end
