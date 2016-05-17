%exponential function (normal distribution)
%Brent Hyman
%5/7/2015
%APPM 3050, HW #08
%**************************
%**************************
function [oilProduction] = exponentialFunct(Q,sigma,mu,t)
    oilProduction = Q/(sigma*sqrt(2*pi)) * exp((-1/2)*((t-mu)/(sigma)).^(2));
end