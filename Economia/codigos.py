#! /usr/bin/python
import math
import random

def computeValueSTMinusMin(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0
	minimum = a**len(path)*S0
	string =""

	for i in path:
		if i == a:
			prob = prob * p
			string = string +"a"
		elif i == b:
			prob = prob *(1-p)
			string = string + "b"
		else:
			print "Some error occurs"

		value = value * i
		if value < minimum:
			minimum = value

	print string, " & ",  str("{:.4f}".format(value - minimum)), " & ", str("{:.4f}".format(prob)), " \\\\"
	return (value - minimum) * prob


def computeValueMaxMinusST(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0
	maximum = S0

	for i in path:
		if i == a:
			prob = prob * p
		elif i == b:
			prob = prob *(1-p)
		else:
			print "Some error occurs"

		value = value * i
		if value > maximum:
			maximum = value

	return (maximum - value) * prob


def computeValueCallBarreraUp_Out(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0

	for i in path:
		if value >= barrera:
			value = 0
			break
		elif i == a:
			prob = prob * p
		elif i == b:
			prob = prob *(1-p)
		else:
			print "Some error occurs"

		value = value * i

	if (value - K) >= 0:
		return (value - K) * prob
	else:
		return 0


def computeValueCallBarreraUp_In(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0
	flag = False

	for i in path:
		if value >= barrera:
			flag = True
		elif i == a:
			prob = prob * p
		elif i == b:
			prob = prob *(1-p)
		else:
			print "Some error occurs"

		value = value * i

	if flag:
		if (value - K) >= 0:
			return (value - K) * prob
		else:
			return 0
	else:
		return 0


def computeValuePutBarreraDown_Out(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0
	string = ""
	flag = True

	for i in path:
		if value <= barrera:
			value = 0
			flag = False
		if i == a:
			prob = prob * p
			string = string + "a"
		elif i == b:
			prob = prob *(1-p)
			string = string + "b"
		else:
			print "Some error occurs"

		value = value * i

	if flag:
		if (K - value) >= 0:
			print string, " & ",  str("{:.4f}".format(K-value)), " & ", str("{:.6f}".format(prob)), " \\\\"
			return (K - value) * prob
		else:
			print string, " & 0 & ", str("{:.6f}".format(prob)), " \\\\"
			return 0
	else:
		print string, " & 0 & ", str("{:.6f}".format(prob)), " \\\\"
		return 0


def computeValuePutBarreraDown_In(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0
	flag = False
	string = ""

	for i in path:
		if value <= barrera:
			flag = True
		elif i == a:
			prob = prob * p
			string = string + "a"
		elif i == b:
			prob = prob *(1-p)
			string = string + "b"
		else:
			print "Some error occurs"

		value = value * i

	if flag:
		if (K - value) >= 0:
			return (K - value) * prob
		else:
			return 0
	else:
		return 0


def computeValueCallAsiaticaAritmetica(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0
	media = 0
	string = ""

	for i in path:
		if value <= barrera:
			flag = True
		elif i == a:
			prob = prob * p
			string = string + "a"
		elif i == b:
			prob = prob *(1-p)
			string = string + "b"
		else:
			print "Some error occurs"

		value = value * i
		media = media + value

	media = media / len(path)

	if (media - K) >= 0:
		print string, " & ",  str("{:.4f}".format(media-K)), " & ", str("{:.4f}".format(prob)), " \\\\"
		return (media - K) * prob
	else:
		print string, " & 0 & ", str("{:.4f}".format(prob)), " \\\\"
		return 0

def computeValueCallAsiaticaGeometrica(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0
	media = S0
	string = ""

	for i in path:
		if value <= barrera:
			flag = True
		elif i == a:
			prob = prob * p
			string = string + "a"
		elif i == b:
			prob = prob *(1-p)
			string = string + "b"
		else:
			print "Some error occurs"

		value = value * i
		media = media * value

	media = math.pow(media, 1.0 / len(path))

	if (media - K) >= 0:
		print string, " & ",  str("{:.4f}".format(media-K)), " & ", str("{:.4f}".format(prob)), " \\\\"
		return (media - K) * prob
	else:
		print string, " & 0 & ", str("{:.4f}".format(prob)), " \\\\"
		return 0


def computeValueActivo2_3_c(path, a, b, p, S0, barrera, K):
	prob = 1
	value = S0
	summatory = S0
	string =""

	for i in path:
		if i == a:
			prob = prob * p
			string = string + "a"
		elif i == b:
			prob = prob *(1-p)
			string = string + "b"
		else:
			print "Some error occurs"

		value = value * i
		summatory = summatory + value

	if 6*S0 > summatory:
		print string, " & ",  str("{:.4f}".format(S0-(1.0/6.0)*summatory)), " & ", str("{:.4f}".format(prob)), " \\\\"
		return value * prob
	else:
		print string, " & 0 & 0 \\\\"
		return 0


def computeValueCashORNothing(path, a, b, p, S0, barrera, K):
	# barrera: valor a superar
	# K:	   cash pagado
	prob = 1
	value = S0
	string =""

	for i in path:
		if i == a:
			prob = prob * p
			string = string + "a"
		elif i == b:
			prob = prob *(1-p)
			string = string + "b"
		else:
			print "Some error occurs"

		value = value * i

	if value >= barrera:
		print string, " & ",  str("{:.4f}".format(K)), " & ", str("{:.4f}".format(prob)), " \\\\"
		return K * prob
	else:
		print string, " & 0 & 0 \\\\"
		return 0


def computeValueAssetORNothing(path, a, b, p, S0, barrera, K):
	# barrera: valor a superar
	prob = 1
	value = S0
	string =""

	for i in path:
		if i == a:
			prob = prob * p
			string = string + "a"
		elif i == b:
			prob = prob *(1-p)
			string = string + "b"
		else:
			print "Some error occurs"

		value = value * i

	if value >= barrera:
		print string, " & ",  str("{:.4f}".format(value)), " & ", str("{:.4f}".format(prob)), " \\\\"
		return value * prob
	else:
		print string, " & 0 & 0 \\\\"
		return 0


def compute_future_value_binary_tree(a,b,p,T,S0,func, barrera, K):
	trajectory = []

	trajectory.append([a])
	trajectory.append([b])

	finalValue = 0

	for path in trajectory:
		if len(path) == T:
			finalValue = finalValue + func(path, a, b, p, S0, barrera, K)
		else:
			pathA = list(path)
			pathA.append(a)
			pathB = list(path)
			pathB.append(b)
			trajectory.append(pathA)
			trajectory.append(pathB)


	return finalValue


#print compute_future_value_binary_tree(1.08,0.93,0.5,10,12,computeValueCallBarreraUp_Out, 1.08**8*12, 12)

#print compute_future_value_binary_tree(1.08,0.93,0.5,10,12,computeValueCallBarreraUp_In, 1.08**8*12, 12)

#print compute_future_value_binary_tree(1.08,0.93,0.5,10,12,computeValuePutBarreraDown_Out, 1.08**(-8)*12, 12)

#print compute_future_value_binary_tree(1.08,0.93,0.5,10,12,computeValuePutBarreraDown_In, 1.08**(-8)*12, 12)

#print compute_future_value_binary_tree(1.08,0.93,0.77,6,10,computeValueCallAsiaticaAritmetica, 0, 10)

#print compute_future_value_binary_tree(1.08,0.93,0.77,6,10,computeValueCallAsiaticaGeometrica, 0, 10)

#print compute_future_value_binary_tree(1.08,0.93,0.77,6,10,computeValueActivo2_3_c, 0, 10)

#print compute_future_value_binary_tree(1.08,0.93,0.53,6,10,computeValueCashORNothing, 10, 1)

#print compute_future_value_binary_tree(1.08,0.93,0.53,6,10,computeValueAssetORNothing, 10, 0)

#print compute_future_value_binary_tree(1.07,0.93,0.512,12,12,computeValuePutBarreraDown_Out, 1.07**(-8)*12, 12)

print compute_future_value_binary_tree(1.092412275,0.9154053122,0.9179234294,4,10,computeValueSTMinusMin, 1.08**8*12, 12)