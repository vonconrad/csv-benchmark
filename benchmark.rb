require 'rubygems'
require 'bundler/setup'

require 'benchmark'

require 'csv'
require 'fastercsv'
require 'ccsv'
require 'csvscan'
require 'excelsior'
require 'lightcsv'

['csv/presidents.csv', 'csv/geoip.csv'].each do |file|
  puts "\nTesting #{file}\n\n"

  Benchmark.bm do |x|
    x.report('csv      ') do
      CSV.open(file, 'r', ',') {|row| row}
    end

    x.report('fastercsv') do
      FasterCSV.foreach(file, :col_sep =>',') {|row| row}
    end

    x.report('lightcsv ') do
      LightCsv.foreach(file) {|row| row}
    end

    x.report('excelsior') do
      Excelsior::Reader.rows(File.open(file, 'r')) {|row| row}
    end

    x.report('ccsv     ') do
      Ccsv.foreach(file) {|row| row}
    end

    x.report('csvscan  ') do
      CSVScan.scan(File.open(file, 'r')) {|row| row}
    end
  end
end
