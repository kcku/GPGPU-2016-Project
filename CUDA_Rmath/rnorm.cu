#include "Rmath.h"

__device__ double rnorm(unsigned I1, unsigned I2, double mu, double sigma)
{
    if (isnan(mu) || !isfinite(sigma) || sigma < 0.)
	return NAN;
    if (sigma == 0. || !isfinite(mu))
	return mu; /* includes mu = +/- Inf with finite sigma */
    else
	return mu + sigma * norm_rand(I1, I2);
}