function [PROFIT] = TG_Test(M,p,nm,J)
e = 4;
PROFIT=[];
Ev = nm*(p.*M*J-(1-p)*M);
    for i = 1:10^e
        A = traditional_credit_strategy(M,p,nm,J);
        Profit = A(1,end);
        PROFIT =[PROFIT,Profit];
    end    
end