require "spec_helper"

shared_examples "specified dimensions" do
  let(:specified_dimension) { 50 }
  
  example "specified row start" do
    expect do
      sheet.to_hash(row_start: specified_dimension)
    end.to change{ sheet.__send__(:row_start) }.from(nil).to(specified_dimension)
  end
  
  example "specified row end" do
    expect do
      sheet.to_hash(row_end: specified_dimension)
    end.to change{ sheet.__send__(:row_end) }.from(nil).to(specified_dimension)
  end
  
  example "specified col start" do
    expect do
      sheet.to_hash(col_start: specified_dimension)
    end.to change{ sheet.__send__(:col_start) }.from(nil).to(specified_dimension)
  end
  
  example "specified col end" do
    expect do
      sheet.to_hash(col_end: specified_dimension)
    end.to change{ sheet.__send__(:col_end) }.from(nil).to(specified_dimension)
  end
  
end
