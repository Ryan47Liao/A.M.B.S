function [A] = traditional_credit_strategy (M,p,nm,J)
% M:How much cash do you have
% P: Your probability of wining
% nm: The number of times you want to play
% J: Your return rate
N=[0];
PROFIT=[0];
n = 0;
B=M;
profit=0;
while n < nm
    x=Gamble(p);
    if x<0
       x = -1;
       profit = profit + B*x;
    PROFIT = [PROFIT, profit];
    n = n+1;
    N = [ N , n];
    else
       profit = profit + B*x*J;
    PROFIT = [PROFIT, profit];
    n = n+1;
    N = [ N , n];
    end
end
A = [PROFIT;N];
end