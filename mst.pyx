import numpy as np
import numpy.linalg as lalg
cimport numpy as np

def mst(np.ndarray[np.double_t, ndim=2] x):
	cdef np.int_t n = x.shape[0]
	cdef np.ndarray[np.int_t] F = np.full(n, np.inf, dtype=np.int)
	cdef np.ndarray[np.double_t] D = np.full(n, np.inf)
	cdef np.int_t lastj = 0
	cdef np.ndarray[np.long_t, ndim=2] ret = np.zeros((n-1, 3), dtype=int)
	cdef np.ndarray[np.int_t] M = np.zeros(n, dtype=int)
	M[0] = 1
	cdef np.int_t no_of_added = 0
	cdef np.int_t bestj
	cdef np.float_t d
	cdef np.ndarray[np.double_t] a1
	cdef np.ndarray[np.double_t] a2
	for i in range(n-1):
		bestj = 0
		for j in range(1,n):
			if M[j] == 0:
				d = lalg.norm(x[lastj,:] - x[j, :])
				if d < D[j]:
					D[j] = d
					F[j] = lastj
				if D[j] < D[bestj]:
					bestj = j
		ret[no_of_added, 0] = F[bestj]
		ret[no_of_added, 1] = bestj
		a1 = x[F[bestj], :]
		a2 = x[bestj,:]
		ret[no_of_added, 2] = lalg.norm(a1-a2)
		no_of_added = no_of_added + 1
		M[bestj] = 1
		lastj = bestj
	ret = ret[ret[:,2].argsort()]
	return ret[:,:2]




