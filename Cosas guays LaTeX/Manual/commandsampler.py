#!/usr/bin/python
import re
import sys
import operator

# http://docs.python.org/dev/library/itertools.html
def accumulate(iterable, func=operator.add):
    'Return running totals'
    # accumulate([1,2,3,4,5]) --> 1 3 6 10 15
    # accumulate([1,2,3,4,5], operator.mul) --> 1 2 6 24 120
    it = iter(iterable)
    total = next(it)
    yield total
    for element in it:
        total = func(total, element)
        yield total

def parse_arginfo(info, argstr):
	result = re.finditer("(\d)(O)?:(.*?);", argstr)
	info.extend([{ "name": match.group(3).strip(), "optional": match.group(2) is not None } for match in result])

def parse_argspec(info, argstr, cmd_type):

	if cmd_type == "newcommandx":
		result = re.finditer("\\s*(\\d)=(.*?)[,\\]]", argstr)
		info.extend([{"name": match.group(2), "optional": True } for match in result])
	else:
		content = argstr.strip(']')
		if len(content) == 0:
			content = "arg0"
		info.append({"name": content, "optional": True})


def arg_to_str(arg):
	if arg['optional']:
		base = "[%s]"
	else:
		base = "{%s}"

	return base % arg['name']

if len(sys.argv) != 3:
	print "Need the package name and destination"
	sys.exit()

packagefile = open(sys.argv[1], "r")
cmdfile = open(sys.argv[2], "w")
lipsum = "Lorem ipsum dolor sit amet."
processed = []
cmddefs_begun = False

#\\(?<cmd_type>newcommand|newcommandx|renewcommand|newenvironment|newenvironmentx|renewenvironment|DeclareMathOperator)*?{(?<name>.*?)}(\[(?<nargs>\d*)])?(\[(?<optargspec>.*]))?[^%\n]*%?(?<arginfo>[^\|\n]*)
rgx = re.compile(r"\\(?P<cmd_type>newcommand|newcommandx|renewcommand|newenvironment|newenvironmentx|renewenvironment|DeclareMathOperator)\*?{(?P<name>.*?)}(\[(?P<nargs>\d*)])?(\[(?P<optargspec>.*]))?[^%\n]*%?(?P<arginfo>[^\|\n]*)")

cmdfile.write("\\footnotesize\\begin{longtable}{|p{3.5cm}|p{2cm}|}\n \\hline")


for line in packagefile:
	# Don't start processing until we find the mark.
	if not cmddefs_begun:
		cmddefs_begun = "BEGIN CMDDEF" in line
		continue

	if "IGN" in line:
		continue

	if line.startswith("%"):
		title = "\\bottomrule \\multicolumn{2}{|p{5.5cm}|}{\\textbf{%s}} \\\\ \\toprule \n" % line[1:].strip()
		cmdfile.write(title)
		continue

	match = rgx.match(line)

	if match is None:
		continue

	arginfo = []
	cmd = match.group('name')
	cmd_type = match.group('cmd_type')
	arginfo_str = match.group('arginfo')
	optargspec_str = match.group('optargspec')
	nargs = match.group('nargs')
	is_env = False
	envname = ""

	if "environment" in cmd_type:
		continue

	if cmd in processed:
		continue

	processed.append(cmd)

	if arginfo_str is not None and (not arginfo_str.isspace() and len(arginfo_str) > 0):
		parse_arginfo(arginfo, match.group('arginfo'))
	elif optargspec_str is not None:
		parse_argspec(arginfo, match.group('optargspec'), cmd_type)

	optional_args = [arg for arg in arginfo if arg['optional']]
	mandatory_args = [arg for arg in arginfo if not arg['optional']]

	if nargs is not None:
		nargs = int(nargs)
	else:
		nargs = 0

	mandatory_args.extend([{"name": "arg%d" % i, "optional": False} for i in range(len(optional_args) + len(mandatory_args), nargs)])

	# stringify
	mandatory_args_str = ''.join(["{%s}" % arg['name'] for arg in mandatory_args])
	optional_args_str = ''.join(["[%s]" % arg['name'] for arg in optional_args])

	cmdstr = cmd + optional_args_str + mandatory_args_str

	towrite = "\\verb|{0}| & $\\displaystyle{0}$ \\\\ \\midrule \n".format(cmdstr)

	cmdfile.write(towrite)

cmdfile.write("\\end{longtable}")

cmdfile.close()
packagefile.close()
