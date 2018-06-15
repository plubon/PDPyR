import numpy as np
import math
from mst import mst
cimport numpy as np

def gini(c):
	cdef np.int_t m = len(c)
	cdef np.float_t enum = 0
	for i in range(m-1):
		for j in range(i+1, m):
			enum = enum + math.fabs(c[i]-c[j])
	cdef np.float_t denum = 0
	for i in range(m):
		denum = denum + c[i]
	denum = denum * (m-1)
	return enum / denum

def genie(np.ndarray[np.double_t, ndim=2] X, np.double_t g, np.int_t k):
	cdef np.int_t n = X.shape[0]
	cdef np.ndarray[np.int_t] z = np.arange(0, n)
	c = [1] * n
	cdef np.ndarray[np.long_t, ndim=2] M = mst(X)
	cdef np.ndarray[np.int_t] removed_edges = np.zeros(n-1, dtype=int)
	cdef np.int_t selected_edge
	cdef np.int_t min_c
	cdef np.int_t z1, z2, u, v
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



