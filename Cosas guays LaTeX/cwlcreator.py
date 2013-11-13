import re
import sys

if len(sys.argv) != 3:
	print "Need the package name and destination"
	sys.exit()

packagefile = open(sys.argv[1], "r")
contents = packagefile.read()
cwlfile = open(sys.argv[2], "w")

matches = re.finditer("\\\\(newcommand|renewcommand|DeclareMathOperator)\\*?{(.*?)}(\\[(\\d*)])?.*", contents)

for match in matches:
	line = "%s" % match.group(2)

	if match.group(4) is not None:
		for i in range(int(match.group(4))):
			line += "{arg%d}" % i

	line += "#m\n"
	cwlfile.write(line)

cwlfile.close()
packagefile.close()
