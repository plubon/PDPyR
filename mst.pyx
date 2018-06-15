import numpy as np
import numpy.linalg as lalg

def mst(x):
	n = x.shape[0]
	F = np.full(n, np.inf, dtype=np.int)
	D = np.full(n, np.inf)
	lastj = 0
	ret = np.zeros((n-1, 3), dtype=int)
	M = np.zeros(n, dtype=int)
	M[0] = 1
	no_of_added = 0
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
	return ret[:,:2]+1




