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
    Ccsv.foreach(file) do |values|
      values
    end
  end
end