function [x]=initialize(size,threshold)
%INITIALIZE(size,threshold)
%
%   initialize a NxN array of randomly assigned +/-1's
%
%   size - width/hieght of the square matrix
%   Theshold -  deterimes the bias of the array
%            - a value between 0 and 1
%            - 0 returns all 1's
%            - 1 returns all -1's
%            - 0.5 equally wieghts the values

x = ones(size,size);          %create array of 1's
for i = 1:size
    for ii = 1:size
        if rand < threshold   %randomly flip them negitive
            x(i,ii) = -1;
        end
    end
end