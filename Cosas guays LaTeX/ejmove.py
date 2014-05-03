#!/usr/bin/python

import sys



def writeto(out, line_list):
	with open(fname, "w") as fout:
		fout.writelines(lines)
	
	print "created", fname	

if len(sys.argv) != 2:
	print 'expected file'
	sys.exit(1)

texin = sys.argv[1]
nameformat = "tex/geo_Hoja{0}.tex"
pattern = "\\subsection"
lines = []
index = 0

f = open(texin, "r")

for line in f:
	if line.startswith(pattern):
		print 'detected', line
		if len(lines) > 0:
			fname = nameformat.format(index)
			writeto(fname, lines)		
			lines = []
			index += 1
	
	lines.append(line)

fname = nameformat.format(index)
writeto(fname, lines)

f.close()

f = open(texin, "w")

for i in range(index + 1):
	f.write("\\input{" + nameformat.format(i) + "}\n")

