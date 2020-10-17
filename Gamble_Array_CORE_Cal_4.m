function [u] = Gamble_Array_CORE_Cal_4 (M,MB,n,J)
%Incorperated Maximum_Bet Constraint 
%Imrpoved Formula Based Algorithm;Proved by mathmetical induction
u = M/(J.*(1/J+1).^n-J);
if u*(1/J+1).^(n-1) > MB
   u = MB/(1/J+1).^(n-1);
end
end
