require 'fileutils'

class Output
	def initialize replace
		@replace = (replace and ARGF.file.is_a? File)
		@original = ARGF.filename
		@tmp = "#{ARGF.filename}.tmp"
	end

	def out
		@output = @replace ? File.open(@tmp, "w") : $stdout

		if block_given?
			yield @output
			close()
		else
			@output
		end
	end

	def close
		if @replace
			@output.close()
			FileUtils.move(@tmp, @original)
		end
	end
end
