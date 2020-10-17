function [ A ] = Expected_Profit_Cal (p,J,n,u)
X=0;
x1=u;
U = [];
    for i = 1:n+1
        X=X+x1;
        U = [ U , x1];
        x1=(X/J)+u;
    end
Expected_Profit = [];
Expected_Loss=[];
Expected_Revenue=[];
for i = 1:n+1
    Expected_Revenue = [ Expected_Revenue; p.*(1-p)^(i-1)];
    Expected_Loss = [Expected_Loss ; (1-p).^i];
    Expected_Profit = [ Expected_Profit ; (2 .* p -1).*( 1 - p ).^(i-1) ];
    
end
EXPECTED_PROFIT = U*Expected_Profit;
EXPECTED_REVENUE = U*Expected_Revenue;
EXPECTED_LOSS = U* Expected_Loss;
Check = EXPECTED_REVENUE - EXPECTED_LOSS;
error = EXPECTED_PROFIT - Check;
A=[EXPECTED_PROFIT,EXPECTED_REVENUE,EXPECTED_LOSS,error];
end