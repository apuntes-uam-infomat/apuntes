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
contents = packagefile.read()
cwlfile = open(sys.argv[2], "w")

#\\(?<cmd_type>newcommand|newcommandx|renewcommand|newenvironment|newenvironmentx|renewenvironment|DeclareMathOperator)*?{(?<name>.*?)}(\[(?<nargs>\d*)])?(\[(?<optargspec>.*]))?[^%\n]*%?(?<arginfo>[^\|\n]*)
matches = re.finditer("\\\\(?P<cmd_type>providecommand|newcommand|newcommandx|renewcommand|newenvironment|newenvironmentx|renewenvironment|DeclareMathOperator)\\*?{(?P<name>.*?)}(\\[(?P<nargs>\\d*)])?(\\[(?P<optargspec>.*]))?[^%\\n]*%?(?P<arginfo>[^\\|\\n]*)", contents)

processed = []

for match in matches:
	arginfo = []
	cmd = match.group('name')
	cmd_type = match.group('cmd_type')
	arginfo_str = match.group('arginfo')
	optargspec_str = match.group('optargspec')
	modifiers = "m"

	if "environment" in cmd_type:
		cmd = "\\begin{%s}" % cmd
		modifiers = "" 

	if cmd in processed:
		continue

	processed.append(cmd)

	if arginfo_str is not None and (not arginfo_str.isspace() and len(arginfo_str) > 0):
		parse_arginfo(arginfo, match.group('arginfo'))
	elif optargspec_str is not None:
		parse_argspec(arginfo, match.group('optargspec'), cmd_type)

	optional_args = [arg for arg in arginfo if arg['optional']]
	mandatory_args = [arg for arg in arginfo if not arg['optional']]

	nargs = match.group('nargs') 
	if match.group('nargs') is not None:
		nargs = int(nargs)
	else:
		nargs = 0

	mandatory_args.extend([{"name": "arg%d" % i, "optional": False} for i in range(len(optional_args) + len(mandatory_args), nargs)])

	# accumulate arguments
	optional_args = [optional_args[0:i] for i in range(len(optional_args) + 1)]
	
	# stringify
	mandatory_args_str = ''.join(["{%s}" % arg['name'] for arg in mandatory_args])
	optional_args_str = [''.join(["[%s]" % arg['name'] for arg in arglst]) for arglst in optional_args]

	arg_combinations = [arg + mandatory_args_str for arg in optional_args_str]

	lines = [ cmd + argstr + "#" + modifiers + "\n" for argstr in arg_combinations]

	for line in lines:
		cwlfile.write(line)

cwlfile.close()
packagefile.close()
