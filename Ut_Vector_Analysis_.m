function [sigma] = Ut_Vector_Analysis_(V,n)
%This function take an input of a vector and then  generate its PDF and CDF
% after rounding all elements in the vector. n stand for the number of
% equal distanced sections you wish to divide the vector into.
%Adapted Rounding Algorithm
%If n == 0, there will be no rounding. 
mu=(sum(V))/(length(V));
V=sort(V);
k=[];
for i=1:length(V)
    k=[k,(V(i)-mu).^2];
end
 Var=sum(k)/length(k);
 sigma=sqrt(Var);
 disp('Expected Value:')
 disp(mu)
 disp('Variance:')
 disp(Var)
 disp('Standard Deviation:')
 %The following is PDF+CDF Generator
%This Algorithm seperates the vector into n portions and then round nearby
%elements into the median of these portions.
if n == 0
    x = V; 
else
    V=sort(V);
Vr=[];
z=(V(end)-V(1))/n;
W=[V(1)];
U=[];
for i=0:n
    U=[U,V(1)+i.*z];
end
for i=0.5:(n-0.5)
    W=[W,V(1)+i.*z];
end
W=[W,W(end),W(end)];
U=[U,U(end),U(end)];
for i=1:length(V)
    while length(Vr)<i
        for j= 0: length(W)
            if U(j+1)<= V(i) && V(i)<= U(j+2)
                V(i)= W(j+2);
                Vr=[Vr,V(i)];
                break    
            end
        end
    end
end
x=Vr;
end
% Vector-element-repetition-eliminate-function
% this function eliminate the same terms of a vector 
K=[];
for i=1:length(x)-1
    if x(i)~=x(i+1)
        K =[K,x(i)];
    end
    w=[K,x(end)];
end
%this function captures the frequency of a vector
y=[];
z=1;
for i=1:length(V)-1
    if V(i)==V(i+1)
        z=z+1;
    else
      y=[y,z];
      z=1;
    end
    f=[y,z];
end
y=f;
%now we have z carrying the value of x-axis with y carrying the frequency
%of each element within vector x.
S=sum(y);
Y=[];
    for i=y
    Y=[Y,i/S];
    end
%Vector F captures all the frequencies.
    F=[0];
    for j=1:length(Y)
        F=[F,F(end)+Y(j)];
    end
    F(1)=[];
    tiledlayout(1,2)
    %top plot
    nexttile
    plot(w,Y,'b',w,F,'r')
    xlabel('value')
    ylabel('density')
    legend('Probability Density Function','Cumulative Density Function')
    title('pdf/cdf')
    %bottom plot 
    nexttile
    bar(w,Y)
    xlabel('value'),ylabel('density')
    title('bar pdf')
end
