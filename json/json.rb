#!/usr/bin/env ruby
require 'optparse'
require 'json'

opts = {mode: :p}

OptionParser.new do |ops|
	ops.banner = "Usage: #{__FILE__} [options] file"

	ops.on("-c", "--compress", "compress") {opts[:mode] = :c}
	ops.on("-p", "--pretty", "pretty") {opts[:mode] = :p}
	ops.on("-d", "--debug", "debug") {opts[:mode] = :d}
end.parse!

json = JSON.parse(ARGF.read)

case opts[:mode]
when :c
	puts JSON.generate(json)
when :p
	puts JSON.pretty_generate(json)
when :d
	@json = json
	binding.irb
end

