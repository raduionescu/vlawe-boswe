/*
 PQ Kernel 1.0
 
 This algorithm computes the PQ kernel in O(n log n) time based on 
 merge sort. This is a mex source file to be compiled and used in
 Matlab.
 
 Copyright (C) 2014  Radu Tudor Ionescu, Marius Popescu
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or any
 later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdlib.h>
#include <string.h>

#include "mex.h"
                                   
long merge_sort1(double *a, double *tmp_array, mwIndex left, mwIndex right)
{
    mwIndex i, j, k, center;
    long sl, sr, m;
    
    if (left < right)
    {
        center = (left + right) >> 1;
        sl = merge_sort1(a, tmp_array, left, center);
        sr = merge_sort1(a, tmp_array, center + 1, right);
        
        m = 0;
        i = left;
        j = center + 1;
        while ((i <= center) && (j <= right))
        {
            if (a[j] < a[i])
            {
                m += center + 1 - i;
                j++;
            }
            else
            {
                i++;
            }
        }
        for (i = center + 1; i > left; i--) tmp_array[i - 1] = a[i - 1];
        for (j = center; j < right; j++) tmp_array[right + center - j] = a[j + 1];
        for (k = left; k <= right; k++)
            a[k] = (tmp_array[i] < tmp_array[j]) ? tmp_array[i++] : tmp_array[j--];
        return sl + sr + m;
    }
    else
    {
        return 0;
    }
}
                     
void merge_sort2(double *a, double *b, double *tmp_array_1, double *tmp_array_2, mwIndex left, mwIndex right)
{
    mwIndex i, j, k, center;
    
    if (left < right)
    {
        center = (left + right) >> 1;
        merge_sort2(a, b, tmp_array_1, tmp_array_2, left, center);
        merge_sort2(a, b, tmp_array_1, tmp_array_2, center + 1, right);
        
        for (i = center + 1; i > left; i--)
        {
            tmp_array_1[i - 1] = a[i - 1];
            tmp_array_2[i - 1] = b[i - 1];
        }
        for (j = center; j < right; j++)
        {
            tmp_array_1[right + center - j] = a[j + 1];
            tmp_array_2[right + center - j] = b[j + 1];
        }
        for (k = left; k <= right; k++)
            if ((tmp_array_1[i] < tmp_array_1[j]) || ((tmp_array_1[i] == tmp_array_1[j]) && (tmp_array_2[i] < tmp_array_2[j])))
            {
                a[k] = tmp_array_1[i];
                b[k] = tmp_array_2[i];
                i++;
            }
            else
            {
                a[k] = tmp_array_1[j];
                b[k] = tmp_array_2[j];
                j--;
            }
    }
}

void merge_sort_idx(double *a, mwIndex *idx, double *tmp_array_1, mwIndex *tmp_array_2, mwIndex left, mwIndex right)
{
    mwIndex i, j, k, center;
    
    if (left < right)
    {
        center = (left + right) >> 1;
        merge_sort_idx(a, idx, tmp_array_1, tmp_array_2, left, center);
        merge_sort_idx(a, idx, tmp_array_1, tmp_array_2, center + 1, right);
        
        for (i = center + 1; i > left; i--)
        {
            tmp_array_1[i - 1] = a[i - 1];
            tmp_array_2[i - 1] = idx[i - 1];
        }
        for (j = center; j < right; j++)
        {
            tmp_array_1[right + center - j] = a[j + 1];
            tmp_array_2[right + center - j] = idx[j + 1];
        }
        for (k = left; k <= right; k++)
            if (tmp_array_1[i] < tmp_array_1[j])
            {
                a[k] = tmp_array_1[i];
                idx[k] = tmp_array_2[i];
                i++;
            }
            else
            {
                a[k] = tmp_array_1[j];
                idx[k] = tmp_array_2[j];
                j--;
            }
    }
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    mxArray *tmp1, *tmp2;
    double *a, *b, *x, *xx, rez, *ker, *tmp_array_1, *tmp_array_2;
    long s, n0, n1, n2, n3, t;
    mwIndex i, j, k, l;
    mwSize m, n, nx;
    mwIndex *idx, *tmp_idx;
    
    if (nlhs > 1) mexErrMsgTxt("Too many output arguments.");
    if (nrhs == 1)
    {
        if (!mxIsDouble(prhs[0])) mexErrMsgTxt("The input argument must be double.");
        if (mxIsSparse(prhs[0])) mexErrMsgTxt("The input argument must not be sparse.");
        
        /* Assumes the input is a column-wise matrix of samples (histograms).
           It will compute a kernel matrix between each pair of samples.
         */
        
        m = mxGetM(prhs[0]);
        n = mxGetN(prhs[0]);
        
        tmp1 = mxDuplicateArray(prhs[0]);
        x = mxGetPr(tmp1);
        
        idx = malloc(m * sizeof(mwIndex));
        tmp_idx = malloc(m * sizeof(mwIndex));
        
        a = malloc(m * sizeof(double));
        b = malloc(m * sizeof(double));
        
        tmp_array_1 = malloc(m * sizeof(double));
        tmp_array_2 = malloc(m * sizeof(double));
        
        plhs[0] = mxCreateDoubleMatrix(n, n, mxREAL);
        
        if (a == NULL || b == NULL || tmp_array_1 == NULL || tmp_array_2 == NULL || idx == NULL || tmp_idx == NULL || plhs[0] == NULL) mexErrMsgTxt("Out of memory.");

        ker = mxGetPr(plhs[0]);

        for (k = 0; k < n; k++)
        {
            memcpy(a, &x[k * m], m * sizeof(double));
            for (i = 0; i < m; i++) idx[i] = i;
            merge_sort_idx(&x[k * m], idx, tmp_array_1, tmp_idx, 0, m - 1);
            
            for (l = k; l < n; l++)
            {
                if (l == k)
                {
                    memcpy(b, a, m * sizeof(double));
                }
                else
                {
                    memcpy(a, &x[k * m], m * sizeof(double));
                    for (i = 0; i < m; i++) b[i] = x[l * m + idx[i]];
                }
                
                merge_sort2(a, b, tmp_array_1, tmp_array_2, 0, m - 1);
                
                // Compute the total number of pairs
                n0 = (m * (m - 1)) >> 1;
                
                // Compute the number of equal pairs in a
                i = 0;
                n1 = 0;
                while (i < m - 1)
                {
                    t = 1;
                    j = i + 1;
                    while (a[j] == a[i]) {j++; t++;}
                    n1 += (t * (t - 1)) >> 1;
                    i = j;
                }
                
                // Compute the number of equal pairs in a and b
                i = 0;
                n3 = 0;
                while (i < m - 1)
                {
                    t = 1;
                    j = i + 1;
                    while ((a[j] == a[i]) && (b[j] == b[i])) {j++; t++;}
                    n3 += (t * (t - 1)) >> 1;
                    i = j;
                }
                
                // Compute the number of discordant pairs
                s = merge_sort1(b, tmp_array_2, 0, m - 1);
                
                // Compute the number of equal pairs in b
                i = 0;
                n2 = 0;
                while (i < m - 1)
                {
                    t = 1;
                    j = i + 1;
                    while (b[j] == b[i]) {j++; t++;}
                    n2 += (t * (t - 1)) >> 1;
                    i = j;
                }
                
                rez = (double) (n0 + n3 - n1 - n2 - (2 * s));
                ker[l * n + k] = rez;
                ker[k * n + l] = ker[l * n + k];
            }
        }
        
        free(a);
        free(b);
        free(idx);
        free(tmp_idx);
        free(tmp_array_1);
        free(tmp_array_2);
        mxDestroyArray(tmp1);
    }
    else if (nrhs == 2)
    {
        if ((!mxIsDouble(prhs[0])) || (!mxIsDouble(prhs[1]))) mexErrMsgTxt("The input arguments must be double.");
        if (mxIsSparse(prhs[0]) || mxIsSparse(prhs[1])) mexErrMsgTxt("The input arguments must not be sparse.");

        if (mxGetNumberOfDimensions(prhs[0]) > 2 || mxGetNumberOfDimensions(prhs[1]) > 2) mexErrMsgTxt("The input arguments must be 1-dimensional or 2-dimensional arrays.");
        
        if ((mxGetM(prhs[0]) <= 1 || mxGetN(prhs[0]) <= 1) &&
            (mxGetM(prhs[1]) <= 1 || mxGetN(prhs[1]) <= 1))
        {
            if (mxGetNumberOfElements(prhs[0]) != mxGetNumberOfElements(prhs[1])) mexErrMsgTxt("The input arguments must have the same number of elements.");
            
            /* Assumes the two input parameters are two samples (can be both row or column vectors).
               It will compute a the kernel function between the two samples.
             */
            
            n = mxGetNumberOfElements(prhs[0]);
            
            tmp1 = mxDuplicateArray(prhs[0]);
            tmp2 = mxDuplicateArray(prhs[1]);
            a = mxGetPr(tmp1);
            b = mxGetPr(tmp2);
            
            tmp_array_1 = malloc(n * sizeof(double));
            tmp_array_2 = malloc(n * sizeof(double));
            
            if (tmp_array_1 == NULL || tmp_array_2 == NULL) mexErrMsgTxt("Out of memory.");
            
            merge_sort2(a, b, tmp_array_1, tmp_array_2, 0, n - 1);
            
            // Compute the total number of pairs
            n0 = (n * (n - 1)) >> 1;
            
            // Compute the number of equal pairs in a
            i = 0;
            n1 = 0;
            while (i < n - 1)
            {
                t = 1;
                j = i + 1;
                while (a[j] == a[i]) {j++; t++;}
                n1 += (t * (t - 1)) >> 1;
                i = j;
            }
            
            // Compute the number of equal pairs in a and b
            i = 0;
            n3 = 0;
            while (i < n - 1)
            {
                t = 1;
                j = i + 1;
                while ((a[j] == a[i]) && (b[j] == b[i])) {j++; t++;}
                n3 += (t * (t - 1)) >> 1;
                i = j;
            }
            
            // Compute the number of discordant pairs
            s = merge_sort1(b, tmp_array_2, 0, n - 1);
            
            // Compute the number of equal pairs in b
            i = 0;
            n2 = 0;
            while (i < n - 1)
            {
                t = 1;
                j = i + 1;
                while (b[j] == b[i]) {j++; t++;}
                n2 += (t * (t - 1)) >> 1;
                i = j;
            }

            free(tmp_array_1);
            free(tmp_array_2);
            mxDestroyArray(tmp1);
            mxDestroyArray(tmp2);
            
            plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
            ker = mxGetPr(plhs[0]);
            ker[0] = (double) (n0 + n3 - n1 - n2 - (2 * s));
        }
        else
        {
            if (mxGetM(prhs[0]) != mxGetM(prhs[1])) mexErrMsgTxt("The two input arguments must have the same number of rows.");
            if ((!mxIsDouble(prhs[0])) || (!mxIsDouble(prhs[1]))) mexErrMsgTxt("The input arguments must be double.");
            if (mxIsSparse(prhs[0]) || mxIsSparse(prhs[1])) mexErrMsgTxt("The input arguments must not be sparse.");

            /* Assumes the two input parameters are two matrices of column-wise samples.
               The input matrices must have the same number of features (i.e. rows).
               It will compute a the kernel matrix between pairs of samples a and b,
               where b is taken from the first input matrix and a from the second one.
             */
            
            m = mxGetM(prhs[0]);
            n = mxGetN(prhs[0]);
            nx = mxGetN(prhs[1]);
            
            tmp1 = mxDuplicateArray(prhs[0]);
            tmp2 = mxDuplicateArray(prhs[1]);
            x = mxGetPr(tmp1);
            xx = mxGetPr(tmp2);
            
            idx = malloc(m * sizeof(mwIndex));
            tmp_idx = malloc(m * sizeof(mwIndex));
            
            a = malloc(m * sizeof(double));
            b = malloc(m * sizeof(double));
            
            tmp_array_1 = malloc(m * sizeof(double));
            tmp_array_2 = malloc(m * sizeof(double));
            
            plhs[0] = mxCreateDoubleMatrix(nx, n, mxREAL);
            
            if (a == NULL || b == NULL || tmp_array_1 == NULL || tmp_array_2 == NULL || idx == NULL || tmp_idx == NULL || plhs[0] == NULL) mexErrMsgTxt("Out of memory.");
            
            ker = mxGetPr(plhs[0]);
            
            for (k = 0; k < nx; k++)
            {
                for (i = 0; i < m; i++) idx[i] = i;
                merge_sort_idx(&xx[k * m], idx, tmp_array_1, tmp_idx, 0, m - 1);
                
                for (l = 0; l < n; l++)
                {
                    memcpy(a, &xx[k * m], m * sizeof(double));
                    for (i = 0; i < m; i++) b[i] = x[l * m + idx[i]];
                    
                    merge_sort2(a, b, tmp_array_1, tmp_array_2, 0, m - 1);
                    
                    // Compute the total number of pairs
                    n0 = (m * (m - 1)) >> 1;
                    
                    // Compute the number of equal pairs in a
                    i = 0;
                    n1 = 0;
                    while (i < m - 1)
                    {
                        t = 1;
                        j = i + 1;
                        while (a[j] == a[i]) {j++; t++;}
                        n1 += (t * (t - 1)) >> 1;
                        i = j;
                    }
                    
                    // Compute the number of equal pairs in a and b
                    i = 0;
                    n3 = 0;
                    while (i < m - 1)
                    {
                        t = 1;
                        j = i + 1;
                        while ((a[j] == a[i]) && (b[j] == b[i])) {j++; t++;}
                        n3 += (t * (t - 1)) >> 1;
                        i = j;
                    }
                    
                    // Compute the number of discordant pairs
                    s = merge_sort1(b, tmp_array_2, 0, m - 1);
                    
                    // Compute the number of equal pairs in b
                    i = 0;
                    n2 = 0;
                    while (i < m - 1)
                    {
                        t = 1;
                        j = i + 1;
                        while (b[j] == b[i]) {j++; t++;}
                        n2 += (t * (t - 1)) >> 1;
                        i = j;
                    }
                    
                    rez = (double) (n0 + n3 - n1 - n2 - (2 * s));
                    ker[l * nx + k] = rez;
                }
            }
            
            free(a);
            free(b);
            free(idx);
            free(tmp_idx);
            free(tmp_array_1);
            free(tmp_array_2);
            mxDestroyArray(tmp1);
            mxDestroyArray(tmp2);
        }
    }
    else mexErrMsgTxt("One or two input arguments required.");
}

