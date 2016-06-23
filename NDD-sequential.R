Rprof("NDD-sequential-prof")

gen_rnorm = function() {
	rbind(rnorm(1, u[1]), rnorm(1, u[2]), rnorm(1, u[3]), rnorm(1, u[4]), rnorm(1, u[5]))
}
N.m = NULL
e.m = NULL 
N.v = NULL
e.v = NULL
qtk = matrix(NA, 29, 7)

for (i in seq(5, 145, 5)) {
	qtk[i/5,] = qtukey(seq(0.3, 0.9, 0.1), 5, i)/sqrt(2)
}
for (i in seq(10, 30, 5)) {
	for (j in 1:7) {
		N = vector("double", 10000)
		e = vector("double", 10000)
		for (k in 1:10000) {
			n = 1
			u = sort(5*rbeta(5, 4, 4))
			X = gen_rnorm()
			while (n < i) {
				X = cbind(X, gen_rnorm())
				r = rowMeans(X)
				o = order(r)
				n = n+1
				if (abs((r[o[3]]-r[o[4]])/sqrt((var(X[o[3],])+var(X[o[4],]))/n)) > qtk[n-1,j]) break 
			}
			N[k] = 5*n
			e[k] = sum(u[4:5]-u[o[4:5]])
		}
		N.m = c(N.m, mean(N))
		e.m = c(e.m, mean(e)) # no
		N.v = c(N.v, var(N))
		e.v = c(e.v, var(e))  # no 
	}
}
Rprof(NULL)