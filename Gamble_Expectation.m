function [Eexpected_Gain_Trad] = Gamble_Expectation (p,J,nm)
%This function calculates the expected value of a specific bet 
E = p*J-(1-p);
Eexpected_Gain_Trad=E*nm;
end