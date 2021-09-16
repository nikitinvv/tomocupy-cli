#ifndef CFUNC_CUH
#define CFUNC_CUH

#include <cufft.h>
#include <cufftXt.h>
#include <cuda_fp16.h>
#include "defs.cuh"

class cfunc
{
    bool is_free;
	real* fl;
    complex* flc;
    real* gtmp;
    complex* fz;
    float* lp2p1;
    float* lp2p2;
    float* lp2p1w;
    float* lp2p2w;
    float* C2lp1;
    float* C2lp2;
    int* lpids;
    int* wids;
    int* cids;
    int nlpids;
    int nwids;
    int ncids;
    cufftHandle plan_forward;
	cufftHandle plan_inverse;
    cudaArray* ga;
    cudaArray* fla;  
    cudaTextureObject_t texfl;  
    cudaTextureObject_t texg;  

public:
    int n;      
    int nproj;      
    int ntheta; 
    int nrho; 
    int nz;  
    
    cfunc(int nproj, int nz, int n, int ntheta, int nrho);
	~cfunc();      
    void free();
    void setgrids(size_t fz, size_t lp2p1, size_t lp2p2, size_t lp2p1w, size_t lp2p2w, 
        size_t C2lp1, size_t C2lp2, size_t lpids, size_t wids, size_t cids, 
        size_t nlpids, size_t nwids, size_t ncids);	
    void backprojection(size_t f, size_t g, size_t stream);
};

#endif