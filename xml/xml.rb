#!/usr/bin/env ruby
require 'optparse'
require 'rexml'

opts = {mode: :p}

OptionParser.new do |ops|
	ops.banner = "Usage: #{__FILE__} [options] file"

	#ops.on("-c", "--compress", "compress") {opts[:mode] = :c}
	ops.on("-p", "--pretty", "pretty") {opts[:mode] = :p}
end.parse!


doc = REXML::Document.new ARGF.read

case opts[:mode]
when :p
  fmter = REXML::Formatters::Pretty.new
  fmter.compact = true
  fmter.write(doc, STDOUT)
end
