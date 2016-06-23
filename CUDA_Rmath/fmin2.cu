#include "Rmath.h"

__device__ double fmin2(double x, double y)
{
	if (isnan(x) || isnan(y))
		return x + y;
	return (x < y) ? x : y;
}