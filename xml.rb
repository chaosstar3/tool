#!/usr/bin/env ruby
require 'optparse'
require 'rexml'
require_relative 'common'

opts = {mode: :p}

OptionParser.new do |ops|
	ops.banner = "Usage: #{__FILE__} [options] file"

	#ops.on("-c", "--compress", "compress") {opts[:mode] = :c}
	ops.on("-p", "--pretty", "pretty") {opts[:mode] = :p}
	ops.on("-r", "--replace", "replace file") {opts[:replace] = true}
end.parse!

output = Output.new(opts[:replace])

doc = REXML::Document.new ARGF.read

case opts[:mode]
when :p
  fmter = REXML::Formatters::Pretty.new
  fmter.compact = true
  fmter.write(doc, output.out)
end

output.close
