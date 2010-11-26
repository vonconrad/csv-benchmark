require 'rubygems'
require 'bundler/setup'

require 'benchmark'

require 'csv'
require 'fastercsv'
require 'ccsv'
require 'csvscan'
require 'excelsior'

file = 'csv/presidents.csv'

Benchmark.bm do |x|
  x.report('csv      ') do
    CSV.open(file, 'r', ',') {|row| row}
  end
  
  x.report('fastercsv') do
    FasterCSV.foreach(file, :col_sep =>',') {|row| row}
  end
  
  x.report('ccsv     ') do
    Ccsv.foreach(file) {|row| row}
  end
  
  x.report('csvscan  ') do
    open(file) do |io|
      CSVScan.scan(io) {|row| row}
    end
  end
  
  x.report('excelsior') do
    Excelsior::Reader.rows(File.open(file, 'r')) {|row| row}
  end
end