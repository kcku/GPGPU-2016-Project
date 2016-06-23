Rprof("NDD-original-prof")
N.m = NULL
e.m = NULL 
N.v = NULL
e.v = NULL

for(j in seq(10,30,5)){
  for(k in seq(0.1,0.7,0.1))
  {
    N = NULL
    e = NULL
    for(i in 1:10000)
    {
      u=sort(5*rbeta(5,4,4))
      n=1
      X=rbind(rnorm(1,u[1],1),rnorm(1,u[2],1),rnorm(1,u[3],1),rnorm(1,u[4],1),rnorm(1,u[5],1))
  
      while(n<j)
      {
        x=t(t(c(rnorm(1,u[1],1),rnorm(1,u[2],1),rnorm(1,u[3],1),rnorm(1,u[4],1),rnorm(1,u[5],1))))
        X=cbind(X,x)
        s.mean=rowMeans(X)
        n=n+1
        if(abs((s.mean[order(s.mean)[3]]-s.mean[order(s.mean)[4]])/sqrt((var(X[order(s.mean)[3],])+var(X[order(s.mean)[4],]))/n)) > qtukey(1-k,5,5*n-5,lower.tail = T)/sqrt(2)) break 
      }
      e = c(e, sum(u[4:5]-u[order(s.mean)[4:5]]) ) #no consider
      N=c(N,5*n)
    }
    N.m = c(N.m,mean(N))
    e.m = c(e.m,mean(e)) # no
    N.v = c(N.v,var(N))
    e.v = c(e.v,var(e))  # no 
 }
}
Rprof(NULL)