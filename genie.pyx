import numpy as np
import math
from mst import mst

def gini(c):
	m = len(c)
	enum = 0
	for i in range(m-1):
		for j in range(i+1, m):
			enum = enum + math.fabs(c[i]-c[j])
	denum = 0
	for i in range(m):
		denum = denum + c[i]
	denum = denum * (m-1)
	return enum / denum

def genie(X, g, k):
	n = X.shape[0]
	z = np.arange(0, n)
	c = [1] * n
	M = mst(X)
	removed_edges = np.zeros(n-1)
	for j in range(n-k):
		selected_edge = 0
		if(gini(c) <= g):
			while(removed_edges[selected_edge] != 0):
				selected_edge = selected_edge + 1
		else:
			min_c = min(c)
			while(removed_edges[selected_edge] != 0 or (c[z[M[selected_edge][0]]] != min_c and c[z[M[selected_edge][1]]] != min_c)):
				selected_edge = selected_edge + 1	
		removed_edges[selected_edge] = 1
		z1 = z[M[selected_edge][0]]
		z2 = z[M[selected_edge][1]]
		u = min(z1,z2)
		v = max(z1,z2)
		c[u] = c[u] + c[v]
		c.pop(v)
		for i in range(len(z)):
			if z[i] == v:
				z[i] = u
			if z[i] > v:
				z[i] = z[i] - 1
	return z



