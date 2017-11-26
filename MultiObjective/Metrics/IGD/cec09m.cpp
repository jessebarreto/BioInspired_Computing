 /*
 * =============================================================
 * cec09m.cpp
 *
 * Matlab-C source codes
 *
 * Test instances for CEC 2009 MOO Competition
 *
 * Usage: [f,c] = cec09m(x, 'problem_name') or f = cec09m(x, 'problem_name')
 *
 * Please refer to the report for more information.
 * =============================================================
 */

#include "mex.h"
#include <string.h>
#include "cec09m.h"

typedef void (*PPROCU)(double *, double *, unsigned int);
typedef void (*PPROCC)(double *, double *, double *, unsigned int);

unsigned int i, dimx, ndat, nobj, ncon, size;
double *px, *pf, *pc;
char *fname;

void Useage()
{
	if(fname != 0) free(fname);
	mexErrMsgTxt("useage: [f,c] = cec09m(x, 'problem_name') in case of constraint problems \n or f = cec09m(x, 'problem_name') for other problems");	
}

void ExeU(unsigned int nobj, PPROCU pobj, int nlhs, mxArray *plhs[])
{
	if(nlhs!=1) Useage();
	plhs[0] = mxCreateDoubleMatrix(nobj, ndat, mxREAL);
	pf   	= mxGetPr(plhs[0]);
	for(i=0; i<ndat; i++)
	{
		(*pobj)(px+i*dimx, pf+i*nobj, dimx);
	}	
}

void ExeC(unsigned int nobj, unsigned int ncon, PPROCC pobj, int nlhs, mxArray *plhs[])
{
	if(nlhs!=2) Useage();
	plhs[0] = mxCreateDoubleMatrix(nobj, ndat, mxREAL);
	pf   	= mxGetPr(plhs[0]);
	plhs[1] = mxCreateDoubleMatrix(ncon, ndat, mxREAL);
	pc   	= mxGetPr(plhs[1]);		
	for(i=0; i<ndat; i++)
	{
		(*pobj)(px+i*dimx, pf+i*nobj, pc+i*ncon, dimx);
	}	
}

/* The gateway routine */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
	fname = 0;
	
  	/*  Check for proper number of arguments. */
 	if (nrhs != 2) Useage(); 	
  	
  	px 	  = mxGetPr(prhs[0]);  	// pointer to data 
  	dimx  = mxGetM(prhs[0]);	// dimension of data
  	ndat  = mxGetN(prhs[0]);	// number of data
  	size  = mxGetNumberOfElements (prhs[1]) + 1;
	fname = (char*)mxCalloc(size, sizeof(char));
	if(mxGetString (prhs[1], fname, size) != 0) Useage();
	
	if(strcmp(fname, "UF1")==0)
	{
		ExeU(2, &CEC09::UF1, nlhs, plhs);
	}
	else if(strcmp(fname, "UF2")==0)
	{
		ExeU(2, &CEC09::UF2, nlhs, plhs);
	}
	else if(strcmp(fname, "UF3")==0)
	{
		ExeU(2, &CEC09::UF3, nlhs, plhs);
	}
	else if(strcmp(fname, "UF4")==0)
	{
		ExeU(2, &CEC09::UF4, nlhs, plhs);
	}
	else if(strcmp(fname, "UF5")==0)
	{
		ExeU(2, &CEC09::UF5, nlhs, plhs);
	}
	else if(strcmp(fname, "UF6")==0)
	{
		ExeU(2, &CEC09::UF6, nlhs, plhs);
	}
	else if(strcmp(fname, "UF7")==0)
	{
		ExeU(2, &CEC09::UF7, nlhs, plhs);
	}
	else if(strcmp(fname, "UF8")==0)
	{
		ExeU(3, &CEC09::UF8, nlhs, plhs);
	}
	else if(strcmp(fname, "UF9")==0)
	{
		ExeU(3, &CEC09::UF9, nlhs, plhs);
	}
	else if(strcmp(fname, "UF10")==0)
	{
		ExeU(3, &CEC09::UF10, nlhs, plhs);
	}
	else if(strcmp(fname, "CF1")==0)
	{
		ExeC(2, 1, &CEC09::CF1, nlhs, plhs);
	}
	else if(strcmp(fname, "CF2")==0)
	{
		ExeC(2, 1, &CEC09::CF2, nlhs, plhs);
	}
	else if(strcmp(fname, "CF3")==0)
	{
		ExeC(2, 1, &CEC09::CF3, nlhs, plhs);
	}
	else if(strcmp(fname, "CF4")==0)
	{
		ExeC(2, 1, &CEC09::CF4, nlhs, plhs);
	}
	else if(strcmp(fname, "CF5")==0)
	{
		ExeC(2, 1, &CEC09::CF5, nlhs, plhs);
	}
	else if(strcmp(fname, "CF6")==0)
	{
		ExeC(2, 2, &CEC09::CF6, nlhs, plhs);
	}
	else if(strcmp(fname, "CF7")==0)
	{
		ExeC(2, 2, &CEC09::CF7, nlhs, plhs);
	}
	else if(strcmp(fname, "CF8")==0)
	{
		ExeC(3, 1, &CEC09::CF8, nlhs, plhs);
	}
	else if(strcmp(fname, "CF9")==0)
	{
		ExeC(3, 1, &CEC09::CF9, nlhs, plhs);
	}
	else if(strcmp(fname, "CF10")==0)
	{
		ExeC(3, 1, &CEC09::CF10, nlhs, plhs);
	}
	else if(strcmp(fname, "R2_DTLZ2_M5")==0)
	{
		if(nlhs!=1) Useage();
		plhs[0] = mxCreateDoubleMatrix(nobj, ndat, mxREAL);
		pf   	= mxGetPr(plhs[0]);	
		for(i=0; i<ndat; i++)
		{
			CEC09::R2_DTLZ2_M5(px+i*dimx, pf+i*nobj, dimx, 5);
		}	
	}	
	else if(strcmp(fname, "R3_DTLZ3_M5")==0)
	{
		if(nlhs!=1) Useage();
		plhs[0] = mxCreateDoubleMatrix(nobj, ndat, mxREAL);
		pf   	= mxGetPr(plhs[0]);	
		for(i=0; i<ndat; i++)
		{
			CEC09::R3_DTLZ3_M5(px+i*dimx, pf+i*nobj, dimx, 5);
		}	
	}
	else if(strcmp(fname, "WFG1_M5")==0)
	{
		if(nlhs!=1) Useage();
		plhs[0] = mxCreateDoubleMatrix(nobj, ndat, mxREAL);
		pf   	= mxGetPr(plhs[0]);	
		for(i=0; i<ndat; i++)
		{
			CEC09::WFG1_M5(px+i*dimx, pf+i*nobj, dimx, 5); //Shizheng, please check it, I'm not sure about the mean of M
		}	
	}																				
	else
	{
		Useage();
	}	
}
