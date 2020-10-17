function [y] = Gamble(p)
if rand() < p
    y=1;
else
    y=-1;
end

