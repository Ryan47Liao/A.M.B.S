function [f] = Geometric_pdf(p)
% x: the number of times to reach a success 
%Support: all integers
f = @(x) (1-p)^(x-1).*p;
end