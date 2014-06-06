function [Ediff] = deltaU(i,j,x)
%DELTAU(i,j,x)
%       returns the energy differance of fliping
%       index i,j in matrix x of +/-1 mangnetic spins
%       periodic boundry conditions ignore largest index
%       -------------------------------------
%       Ediff=2*x(i,j)*(top+bottom+left+right)

if i == 1
    bottom = x(length(x)-1,j);
else
    bottom = x(i-1,j);
end

if i == length(x)-1
    top = x(1,j);
else
    top = x(i+1,j);
end

if j == 1
    left = x(i,length(x)-1);
else
    left = x(i,j-1);
end

if j == length(x)-1
    right = x(i,1);
else
    right = x(i,j+1);
end
Ediff=2*x(i,j)*(top+right+bottom+left);