%-------------------------------------------------------------------------- 
%  PQ Kernel 1.0
%  
%  This function computes the PQ kernel in O(n log n) time based on 
%  merge sort, as described in [1].
%  
%  Copyright (C) 2014  Radu Tudor Ionescu, Marius Popescu
%  
%  This program is free software: you can redistribute it and/or modify
%  it under the terms of the GNU General Public License as published by
%  the Free Software Foundation, either version 3 of the License, or any
%  later version.
%  
%  This program is distributed in the hope that it will be useful,
%  but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%  
%  You should have received a copy of the GNU General Public License
%  along with this program.  If not, see <http://www.gnu.org/licenses/>.
%--------------------------------------------------------------------------
%
%  The PQK function has one or two input parameters. There are three ways
%  of calling this function:
%
%  a) K = PQK(X)
%     Input:
%        X - a matrix of column-wise samples (or histograms).
%
%     Output: 
%        K - a pairwise kernel matrix between the samples of X.
%
%     Example:
%        >> X = [4, 2, 3;
%                5  4, 1;
%                2, 1, 4;
%                3, 3, 2]
%        >> K = pqk(X)
%
%  b) k = PQK(A,B)
%     Input: 
%        A, B - two samples given either as column vectors or row vectors.
%
%     Output:
%        k - the PQ kernel between A and B, i.e. k_PQ(A,B).
%
%     Example:
%        >> A = [1, 2, 4, 2, 1]
%        >> B = [3, 1, 3, 4, 1]
%        >> k = pqk(A,B)
%
%  c) K = PQK(X,Y)
%     Input: 
%        X, Y - two matrices of column-wise samples (or histograms).
%
%     Output: 
%        K - a pairwise kernel matrix between the samples in Y (on rows)
%        and the samples in X (on columns).
%  
%     Example:
%        >> X = [4, 2, 3;
%                5  4, 1;
%                2, 1, 4;
%                3, 3, 2]
%        >> Y = [1, 2;
%                3  1;
%                2, 5;
%                4, 3]
%        >> K = pqk(X,Y)
%
%  The PQ kernel is roughly 2% better than the intersection kernel or the 
%  Jensen-Shannon kernel on the Pascal VOC 2007 data set. More details 
%  about the PQ kernel are given in [1]. Please cite the paper if you use
%  this code in you scientific work.
% 
%  [1] Radu Tudor Ionescu, Marius Popescu (2014) PQ kernel: a rank 
%      correlation kernel for visual word histograms. Pattern Recognition 
%      Letters, Elsevier.
%


