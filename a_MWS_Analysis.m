function [] = a_MWS_Analysis(M,MB,p,J,Confidence_Level)
%This function provides insight into the amount of profit possible giving
%strike M_W_Scheme;
%%%
if  Confidence_Level < 0 
    error('Confidence Level Must be between 0 and 1!')
elseif Confidence_Level >= 1 
    error('Confidence Level Must be between 0 and 1!')	
end
%%%
n = log(1-Confidence_Level)/log(1-p);
if n-round(n)>=0
    n=round(n);
else
    n=round(n)-1;
end
Target_Profit = J.*Gamble_Array_CORE_Cal_4(M,MB,n,J);
PROFIT = [0,Target_Profit];
MWS_Streak = [0,1];
Likelyhood = [1,Confidence_Level];
Cumulated_Wealth = [M,M+Target_Profit]; 
R = 0.001;
while Likelyhood(end)>=R
    %MWS Streak!%
    M = M + Target_Profit;
    n = log(1-Confidence_Level)/log(1-p);
if n-round(n)>=0
    n=round(n);
else
    n=round(n)-1;
end
    Target_Profit = J.*Gamble_Array_CORE_Cal_4(M,MB,n,J);
    PROFIT = [PROFIT,Target_Profit];
    Cumulated_Wealth = [Cumulated_Wealth,Cumulated_Wealth(end)+PROFIT(end)];
    MWS_Streak = [MWS_Streak,MWS_Streak(end)+1];
    Likelyhood = [Likelyhood,Likelyhood(end)*Confidence_Level];
end
PROFIT = PROFIT/M;
Cumulated_Wealth = Cumulated_Wealth/M;
%Now Plot the graphs:
    tiledlayout(1,3)
    nexttile
    plot (MWS_Streak,PROFIT,'b',MWS_Streak,Likelyhood,'r')
    legend('Streak-Profit','Streak-Likelyhood')
    title('Return_Rate Likelyhood')
    xlabel('Streak Count'),ylabel('Profit/Likelyhood')
    %2nd plot
    nexttile
    plot (MWS_Streak,Likelyhood,'r',MWS_Streak,PROFIT,'b',MWS_Streak,Cumulated_Wealth,'m')
    legend('Streak-Likelyhood')
    title('Conjugation')
    xlabel('Streak Count'),ylabel('Likelyhood')
    %3rd plot
    nexttile
    plot (MWS_Streak,Likelyhood,'r',MWS_Streak,Cumulated_Wealth,'m')
    legend('Streak-Likelyhood','Cumulated Wealth')
    title('MWS-Wining-Streak-Cumulated Wealth')
    xlabel('Streak Count'),ylabel('Cumulated Wealth')
end