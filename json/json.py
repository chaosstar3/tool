import os
import sys
sys.path.remove(os.path.dirname(os.path.abspath(__file__)))
import json as jsonlib
import code

from optparse import OptionParser

parser = OptionParser()
parser.add_option("-c", "--compress", dest="mode", action="store_const", const="c")
parser.add_option("-p", "--pretty", dest="mode", action="store_const", const="p")
parser.add_option("-d", "--debug", dest="mode", action="store_const", const="d")
(options, args) = parser.parse_args()

io = open(args[0], 'r') if len(args) > 0 else sys.stdin
json = jsonlib.load(io)

if options.mode == 'c':
	print(jsonlib.dumps(json, ensure_ascii=False))
elif options.mode == 'p':
	print(jsonlib.dumps(json, indent = 2, ensure_ascii=False))
elif options.mode == 'd':
	code.interact(local=dict(globals(), **locals()))

