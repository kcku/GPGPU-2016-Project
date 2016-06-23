NVCC = nvcc -O3 -arch=sm_20
FLAG = -Xcompiler -fPIC

all:
	$(NVCC) $(FLAG) -dc *.cu

clean:
	rm -rf *.o