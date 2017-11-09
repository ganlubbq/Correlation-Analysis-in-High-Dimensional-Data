% This is a MATLAB implementation supporting the paper
%
% "Determining the Dimension of the Improper Signal
% Subspace in Complex-Valued Data" by Tanuj Hasija, Christian Lameiro and
% Peter J. Schreier, IEEE Signal Processing Letters, vol. 24, no. 11, pp. 1606-1610, Nov. 2017.
% 
% ## ----------------------------------------------------------------------------
% ##
% ##   File: Max_Min_ITC_Impropriety.m
% ##   Copyright (c) <2017> Signal and System Theory Group, 
% ##                        Univ. of Paderborn, http://sst.upb.de
% ##                        https://github.com/SSTGroup/Correlation-Analysis-in-High-Dimensional-Data
% ##
% ##   Permission is hereby granted, free of charge, to any person
% ##   obtaining a copy of this software and associated documentation
% ##   files (the "Software"), to deal in the Software without restriction,
% ##   including without limitation the rights to use, copy, modify and
% ##   merge the Software, subject to the following conditions:
% ##
% ##   1.) The Software is used for non-commercial research and
% ##       education purposes.
% ##
% ##   2.) The above copyright notice and this permission notice shall be
% ##       included in all copies or substantial portions of the Software.
% ##
% ##   3.) Publication, distribution, sublicensing, and/or selling of
% ##       copies or parts of the Software requires special agreements
% ##       with the Signal and System Theory Group, University of Paderborn,
% ##       and is in general not permitted.
% ##
% ##   4.) Modifications or contributions to the Software must be
% ##       published under this license. 
% ##   
% ##   5.) Any publication that was created with the help of this Software  
% ##       or parts of this Software must include a citation of the paper 
% ##       referenced above.
% ##
% ##   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
% ##   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
% ##   OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
% ##   NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
% ##   HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
% ##   WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
% ##   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
% ##   OTHER DEALINGS IN THE SOFTWARE.
% ##
% ##   Persons using the Software are encouraged to notify the
% ##   Signal and System Theory Group at the University of Paderborn
% ##   about bugs. 
% ##
% ##
% ##   Author: Tanuj Hasija, <tanuj.hasija@sst.upb>
% ##   Date: 18.08.2017
% ##   Version: v1 
% ## ----------------------------------------------------------------------------

function [d_cap, r_d] = Max_Min_ITC_Impropriety(M, Vx1,Vx2, rmax)
% Max_Min_ITC_Impropriety.m - Detector based on ITC for number of improper signals (14)
%
%
% Input:
%
% M:         number of samples
% Vx1:       right singular vectors of X
% Vx2:       right singular vectors of complex conjugate of X
% rmax:      maximum allowable PCA rank
%
% Output:
%
% d_cap:     estimated number of improper signals
% r_d:       PCA rank required to obtain d_cap

d_cap_vector = zeros(1,rmax);

for r=1: rmax
    
    K = svd(Vx1(:,1:r)'*Vx2(:,1:r));
    I_MDL = zeros(1,r);
    
    for s=0:r-1
        
        iter=s+1;
        F_K = 1 - K(1:s).^2;
        I_MDL(iter) = M/2*(log(prod(F_K))) + log(M)/2*(2*r*s + s -s^2);
        
    end
    
    [~,idx] = min(I_MDL);
    s_min = idx-1;
    d_cap_vector(r) = s_min;
    
end

[d_cap, r_d] = max(d_cap_vector);

end