$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'calexcer'

Calexcer::Root = File.expand_path('../..', __FILE__)
Calexcer::SampleDir = File.join(Calexcer::Root, "spec/sample")

Calexcer::Samples = {}
Calexcer::Samples[:vertical] = File.join(Calexcer::SampleDir, "vertical_calendar.xls")
Calexcer::Samples[:horizontal] = File.join(Calexcer::SampleDir, "horizontal_calendar.xls")

Calexcer::Samples[:vertical_merged_cell] = File.join(Calexcer::SampleDir, "vertical_calendar_merged_cell.xls")
