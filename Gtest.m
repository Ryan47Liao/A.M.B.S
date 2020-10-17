function[t]=Gtest(p)
t=[];
for i=1:10000
    v=1;
    z=0;
    while z<=0
        z=Gamble(p);
        if z<0
        v=v+1;
        else
        t=[t,v]; 
    	break
        end
        t=sort(t);
    end
end
