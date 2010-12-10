require 'rubygems'
require 'bundler/setup'

require 'benchmark'

require 'csv'
require 'fastercsv'
require 'ccsv'
require 'csvscan'
require 'excelsior'

file = 'csv/geoip.csv'

Benchmark.bm do |x|
  x.report('csv      ') do
    CSV.open(file, 'r', ',') {|row| row}
  end
  
  x.report('fastercsv') do
    FasterCSV.foreach(file, :col_sep =>',') {|row| row}
  end

  x.report('excelsior') do
    csv = File.open(file, 'r')
    Excelsior::Reader.rows(csv) {|row| row}
  end
  
  x.report('ccsv     ') do
    Ccsv.foreach(file) {|row| row}
  end
  
  x.report('csvscan  ') do
    csv = File.open(file, 'r')
    CSVScan.scan(csv) {|row| row}
  end
end