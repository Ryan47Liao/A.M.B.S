function[Ev] = GGG6_2_fn(M,MB,p,J,times,Confidence_Level,First_Bet)
%--Gamble Good Game provides the optimum gamble strategy for generalized gamble scenario in which you are aware of the probability of winning--
%Must Win Scheme is officially known as 'Martingale Betting System';In order to obtain a 'guaranteed' profit,
% You simplly keep raising your bet so that if you win, you win your lost back plus your target profit!
%-_-_-_-_-_--_-_-_-_-_--_-_-_-_-_--_-_-_-_-_--_-_-_-_-_--_-_-_-_-_--_-_-_-_-_-
%Legends: 
%M:Cash you have
%p:Probability of winning the game; 
%J:the return rate;i.e: if you bet $10, and if you win, you win 10*J back;First_Bet: the
%baseline value for traditional strategy, aka "flat Bet", you simply keep betting the same amount of money;
%!!!Please Leave "times,Confidence_level" 0 for the first time!!!
%Costume Setting:
%times:the number of time you are able to play using "flat Betting"; 
%Confidence_Level:The desired probability to win (Warning!Higher
%Confidence Level means more times to bet required, as you increase your Confidence Level, your profit will drop expoentially)
%High Risk, High Return! Have FUN~
%_-_-_-_-_-_--_-_-_-_--_-_-_-_-_-_-0w0_-_-_-_-_--_-_-_-_-_--_-_-_-_-_--_-_-_
%Latest Update:30/3/2020 DMY; v.0.62
%MB_Mod_2 implemented
%By Leonidas Liao
close all 
if times ~= 0 && Confidence_Level ~= 0 
    error('Times to play and Confidence Level can not both be non-zero value; If you desire to use Must_Win_Scheme, please enter desired Confidence Level; If you wish to play traditional method, please enter desired number of times to play')
elseif times - round (times) > 0 
    error('times must be an integer')
elseif Confidence_Level < 0 
    error('Confidence Level Must be between 0 and 1!')
elseif Confidence_Level >= 1 
    error('Confidence Level Must be between 0 and 1!')	
end
if p*J-(1-p)>0 && Confidence_Level == 0 
    disp('Must_Win_Scheme Not Recommanded. Traditional Strategy (Flat Betting)Deployed!')
elseif p*J-(1-p)< 0 && times == 0
    disp('The odds are against you! Must_Win_scheme Initiated...')
elseif p*J-(1-p)< 0 && times ~= 0
    disp('The odds are against you! Display Traditional Strategy Analysis... ')
elseif Confidence_Level ~= 0 
    disp('Confidence_Level Confirmed,initiating Must_Win_scheme... Simulating...')
end 
if Confidence_Level~=0 && Confidence_Level < p 
   Confidence_Level = p;
   disp('warning!CL can never be lower than p; CL is now automatically adjusted to be equal to p')
end
M = MB_Mod_2 (M,MB,p,J,Confidence_Level);
disp('Bankroll Required:')
disp(M)
TRAD_EP=[];
EVP=[];    
C=[];
N=[];
U=[];
RETURN=[];
REVENUE=[];
CC=[];
RISK=[];
Eps= 10^-4;
if First_Bet > MB
    First_Bet = MB; 
end
if Confidence_Level == 0 && times == 0
   disp('Warning! No specific Confidence_Level specified, GGG algorithm will run based on expected value maximizing Confidence_Level!')
end
%%%CORE Algorithm%%%
if times == 0
    
for c = Eps:Eps:1-Eps
    
n = log(1-c)/log(1-p);
if n-round(n)>=0
    n=round(n);
else
    n=round(n)-1;
end
if n <= 0 
    continue
end
BR = MB_Mod_2 (M,MB,p,J,c);
C=[C,c];
N=[N,n];
cc= 1-(1-p)^n;
CC = [CC, cc];
%CC as the collection of real (feasible) confidence_level
u = Gamble_Array_CORE_Cal_4(M,MB,n,J);
RETURN=[RETURN,u.*J/BR];
U = [U,u];
RISK = [RISK,(1-cc).*BR];
Trad_ep = First_Bet * Gamble_Expectation (p,J,n);
TRAD_EP = [TRAD_EP , Trad_ep ] ;
end
REVENUE = J.*U.*CC;
EVP = REVENUE-RISK;
CL=max(C(EVP==max(EVP)))+Eps;
    if CL >= 1
     CL = CL - Eps;
    end
nm=N(C==CL);
else
   nm = times;
end
%Traditional Strategy
if p*J-(1-p)>0 && times == 0 && Confidence_Level == 0
   Ut_Vector_Analysis_(TG_Test(First_Bet,p,nm,J),0)
   disp('time played:')
   disp(nm)
   return
elseif times ~= 0
   Ut_Vector_Analysis_(TG_Test(M,p,times,J),0)
   disp('time played:')
   disp(times)
   return
end

%
if times == 0 && Confidence_Level == 0
u=max(U(EVP==max(EVP)));
disp('In order to obtain the optimal expected profit, you need the following')
disp('Your confidence level:')
disp(CL)
disp('Affordable trails under given confidence level')
disp(nm)
disp('first trial')
disp(u)
disp('Target Profit:')
disp(u.*J)
end
   %Costumized Confidence Level
if times == 0 && Confidence_Level ~= 0
    n = log(1-Confidence_Level)/log(1-p);
if n-round(n)>=0
    n=round(n);
else
    n=round(n)-1;
end
u = Gamble_Array_CORE_Cal_4(M,MB,n,J);
   Confidence_Level= 1-(1-p)^n;
    Cl_next= 1-(1-p)^(n+1);
    disp('The Closet Feasible Confidence level:')
    disp(Confidence_Level);
    disp('The next Feasible Confidence level:')
    disp(Cl_next)
    disp('Your Starting Bet:')
    disp(u)
    disp('Target Profit:')
    disp(u.*J)
    disp('Rate of Return')
    disp(J.*u/M)

end
m = 0;
B = u;
BET = [B];
v=[];
if Confidence_Level == 0 
Ev=max(EVP);
else
    nm = log(1-Confidence_Level)/log(1-p);
    round(nm);
    disp('Affordable trails under given confidence level')
    disp(nm)
    D = Expected_Profit_Cal(p,J,nm,u);
    Ev = D(1);
end 
nr = 0; 
while abs(nr+1 - nm) > 10^-3
        m = m+B.*-1;
        B = u - m/J;
        BET = [BET,B];
        nr = nr + 1;
        v=[v,m];
    end
        nr = nr + 1;
        m = m+B.*1.*J;
        v=[v,m];

    disp('This is the estimated Ideal Trail along with its graph')
    disp(v);
    disp('Please follow the bet instruction carefully')
    Bet_trail=1:length(BET);
    Bet_Mat=[Bet_trail;BET];
    disp(Bet_Mat);
    if m >= u 
    disp('YOU WON!!!')
    end
    Error = abs(sum(BET)-M);
    if Error > 1 
       disp('WARNING:Efficient Sequencial Devision Negative!(Ignore if there are Maximum Bet Constraint)')
    end
   
%The following captures a simulated result of a random traditional strategy
    v=[0,v];
    A = traditional_credit_strategy(First_Bet,p,nm,J);
    T_P = A(1,:);
    T_Trail = A(2,:);
    while length(T_P) > length(v)   
        T_P(end)=[];
        T_Trail(end)=[];
    end
    %Now Plot the graphs:
    tic
    figure;
    tiledlayout(1,3)
    nexttile
    plot (C,EVP,'mo',C,REVENUE,'go',C,RISK,'rx',C,TRAD_EP,'b*')
    legend('Expected Profit(CL)','Expected REVENUE(CL)','Expected RISK(CL)','Traditional Method')
    title('EP C-Curve')
    xlabel('Confidence Level'),ylabel('Expected Profit')
    %2nd plot
    nexttile
    plot (N,CC,'kx',N,RETURN,'mo-')
    legend('Number of trials(CL)','Return in percentage')
    title('Trails/Confidence Level/Return Rate')
    xlabel('Affordable Trials'),ylabel('Confidence Level/Return')
    axis([0 nm+5 0 1])
    %3rd plot 
    nexttile
    Y = -M.*ones(1,length(T_Trail));
    plot(T_Trail,v,'m',T_Trail,T_P,'b',T_Trail,Y,'r')
    legend('Must-Win-Scheme','Traditional Method','Broke Threshold')
    xlabel('Trials'),ylabel('Profit')
    title('Gamble Simulation')
    %figure 2
    figure;
    a_MWS_Analysis(M,MB,p,J,Confidence_Level);
    %figure 3 
    figure;
    Ut_Vector_Analysis_plot(TG_Test(First_Bet,p,nm,J),0)
    %figure 4
    figure;
    MvD_3_1_fn_(Geometric_pdf(p),1:round(10/p),Gtest(p),0,nm)
    graphing_time=toc
    %
    Traditional_Expected_Profit = First_Bet * Gamble_Expectation (p,J,nm)
        if u == 0 
        disp('The Best Strategy is to not play at all...')
        end
    disp('Expected Profit:')
end	