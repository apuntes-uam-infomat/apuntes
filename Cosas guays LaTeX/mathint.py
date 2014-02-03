#!/usr/bin/python

import sys
from StringIO import StringIO
from subprocess import call
import os

def get_mathematica_result(lines):
	special_var_name = 'miretval'
	lines[-1] = special_var_name + " = " + lines[-1]
	lines.append('Print[TeXForm[' + special_var_name + ']]')
	print lines

	f_in = open('min_tmp', 'w')
	f_in.write('\n'.join(lines))
	f_in.close()

	f_out = open('min_tmp_out', 'w+')
	call(['math', '-script', 'min_tmp'], stdout=f_out)
	f_out.seek(0)
	result = f_out.read().strip()

	os.remove('min_tmp')
	os.remove('min_tmp_out')
	return result


keyword_begin = 'MI<'
keyword_end = '>MI'
in_math_mode = False

if len(sys.argv) == 1:
	print 'wrong args! usage: mathint.py <file>'
	sys.exit(0)

f = open(sys.argv[1], "r+")

final_lines = []
to_interpret = []

for line in f:
	line = line.strip()
	if not in_math_mode:
		if not keyword_begin in line:
			final_lines.append(line)
		else:
			in_math_mode = True
	
	if in_math_mode:
		line = line.replace(keyword_begin, '') 
		
		if keyword_end in line:
			in_math_mode = False
			line = line.replace(keyword_end, '')

		to_interpret.append(line.strip())

		if not in_math_mode:
			final_lines.append(get_mathematica_result(to_interpret))
			to_interpret = []

f.seek(0)
f.truncate()
f.write('\n'.join(final_lines))

f.close()
