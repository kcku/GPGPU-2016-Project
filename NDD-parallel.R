Rprof("NDD-parallel-prof")
source("gen_rnorm.R")

ndd = vector("double", 10000)
err = vector("double", 10000)
rbt = vector("double", 1750000)
qtk = matrix(NA, 29, 7)
ret = matrix(NA, 35, 4)

for(i in 1:350000) {
	rbt[(i*5-4):(i*5)] = sort(5*rbeta(5, 4, 4))
}
for (i in seq(5, 145, 5)) {
	qtk[i/5,] = qtukey(seq(0.3, 0.9, 0.1), 5, i)/sqrt(2)
}
rbt_idx = 1
rnm_idx = 1
rnm = gen_rnorm(rbt)
dim(rbt) = c(5, 350000)
dim(rnm) = c(5, 7000000)

for (i in seq(10, 30, 5)) {
	for (j in 1:7) {
		for (k in 1:10000) {
			n = 1
			u = rbt[,rbt_idx]
			X = matrix(rnm[,rnm_idx:(rnm_idx+i-1)], 5, i)
			while (n < i) {
				n = n+1
				r = rowMeans(X[,1:n])
				o = order(r)
				if (abs((r[o[3]]-r[o[4]])/sqrt((var(X[o[3],1:n])+var(X[o[4],1:n]))/n)) > qtk[n-1,j]) break
			}
			ndd[k] = 5*n
			err[k] = sum(u[4:5]-u[o[4:5]])
			rbt_idx = rbt_idx+1
			rnm_idx = rnm_idx+i
		}
		ret[(i/5-2)*7+j,] = c(mean(ndd), var(ndd), mean(err), var(err))
	}
}
Rprof(NULL)