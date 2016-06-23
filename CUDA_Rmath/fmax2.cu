#include "Rmath.h"

__device__ double fmax2(double x, double y)
{
	if (isnan(x) || isnan(y))
		return x + y;
	return (x < y) ? y : x;
}