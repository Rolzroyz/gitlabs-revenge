function [UU] = initU(i,j,x)
%INITU(i,j,x)
%   returns the energy of the initial matrix
%   prevents user from indexing outer layer
%   has periodic boundry conditions
%   works on any matrix 2<imax,jmax<length(x)
%   if you are wondring why the funny matrix condition
%   it has to do with the the way pcolor plots data and has been rigorusly
%   tested for first order error analysis.
if or(i == length(x),j == length(x))
    return
end

if i == length(x)-1
    top = x(1,j);
else
    top = x(i+1,j);
end

if j == length(x)-1
    right = x(i,1);
else
    right = x(i,j+1);
end


UU= - x(i,j)*(top+right);