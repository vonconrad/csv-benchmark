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
  x.report('csv') do
    CSV.open(file, 'r', ',') do |row|
      row
    end
  end
  
  x.report('fastercsv') do
    FasterCSV.foreach(file, :col_sep =>',') do |row|
      row
    end
  end
  
  x.report('ccsv') do
    Ccsv.foreach(file) do |row|
      row
    end
  end
  
  x.report('csvscan') do
    open(file) do |io|
      CSVScan.scan(io) do |row|
        row
      end
    end
  end
  
  x.report('excelsior') do
    Excelsior::Reader.rows(File.open(file, 'rb')) do |row|
      row
    end
  end
end