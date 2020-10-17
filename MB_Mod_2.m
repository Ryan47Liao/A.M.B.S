function [M] = MB_Mod_2 (M,MB,p,J,Confidence_Level)
%Maximum_Bet Constraint
%Improved Math based Algorithm
    n = log(1-Confidence_Level)/log(1-p);
if n-round(n)>=0
    n=round(n);
else
    n=round(n)-1;
end
u = Gamble_Array_CORE_Cal_4(M,MB,n,J);
M = u.*J.*((1/J+1).^n-1);
end