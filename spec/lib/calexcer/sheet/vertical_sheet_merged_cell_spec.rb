require "spec_helper"

describe Calexcer::VerticalSheet do
  let(:sample) { Calexcer::Samples[:vertical_merged_cell] }
  let(:calexcer) { Calexcer::Book.new(sample) }
  let(:sheet) { calexcer.sheets.first.vertical_sheet }
  
  context "merged cell calendar" do
    describe "#to_hash" do
      example "get merged cell events" do
        hash = sheet.to_hash
        date = Date.new(2014, 9, 7)
        events = hash[date]
        
        expect(events).to  be_include("[0,0]9/7")
        expect(events).to  be_include("[1,1]9/7")
        expect(events).to  be_include("[2,2]9/7")
      end
      
      example "block to get non-events" do
        expect(sheet.to_hash.collect{|k,v| v}.flatten).not_to be_include("Description of the calendar")
      end
    end # describe "#to_hash"
  end # context "merged cell calendar"
end
