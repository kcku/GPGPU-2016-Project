NVCC = nvcc -O3 -arch=sm_20
FLAG = -Xcompiler -fPIC
LIB = CUDA_Rmath
OUT = gen_rnorm

all:
	$(NVCC) $(FLAG) -dc $(OUT).cu
	$(NVCC) $(FLAG) -dlink $(OUT).o $(LIB)/*.o -o link.o
	g++ -shared $(OUT).o $(LIB)/*.o link.o -lcudart -o $(OUT).so 

clean:
	rm -rf $(OUT).so $(OUT).o link.o