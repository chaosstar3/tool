#!/usr/bin/env ruby
require 'optparse'
require 'json'

opts = {mode: :p}

OptionParser.new do |ops|
	ops.banner = "Usage: #{__FILE__} [options] file"

	ops.on("-c", "--compress", "compress") {opts[:mode] = :c}
	ops.on("-p", "--pretty", "pretty") {opts[:mode] = :p}
	ops.on("-d", "--debug", "debug") {opts[:mode] = :d}
	ops.on("-l", "--lines", "lines") {opts[:lines] = true}
end.parse!

# detect_lines
first_line = ""
unless opts[:lines]
	first_line = ARGF.readline
	begin
		json = [JSON.parse(first_line)]
		opts[:lines] = true
	rescue JSON::ParserError
		opts[:lines] = false
	end
end

# read json
if opts[:lines]
	ARGF.readlines.each do |line|
		json.append JSON.parse(line)
	end
else
	json = JSON.parse(first_line + ARGF.read)
end

case opts[:mode]
when :c
	puts JSON.generate(json)
when :p
	puts JSON.pretty_generate(json)
when :d
	@json = json
	binding.irb
end

