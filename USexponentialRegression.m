%US oil production exponential regression
%Brent Hyman
%5/7/2015
%APPM 3050, HW #08
%**************************
%**************************
%clear out everything
clear all; clc
%read in the data
inFile = xlsread('OPDUS.xlsx');

%form the linear system
% -> A matrix
for i = 1:length(inFile)
	inputMatrix(i,1) = (inFile(i,1))^2;
	inputMatrix(i,2) = inFile(i,1);
	inputMatrix(i,3) = 1;
end
% -> right side vector
for j = 1:length(inFile)
	if(inFile(j,2) ~= 0)
		RSV(j,1) = log(inFile(j,2));
	else
		RSV(j,1) = 0;
	end
end

% -> the domain
t = linspace(inputMatrix(1,2),inputMatrix(length(inputMatrix),2));

% Solution to the least squares problem
A = inputMatrix;
[Q R] = qr(A);
parameterVector = R \ transpose(Q)*RSV;
% -> output parameters a, b, and c
disp('a:')
disp(parameterVector(1))
disp('b:')
disp(parameterVector(2))
disp('c:')
disp(parameterVector(3))

disp('=======================================')

% modify parameter vector to hold sigma (parameterVector(1)) and mu (parameterVector(2))
parameterVector(1) = sqrt((-1)/(2*parameterVector(1)));
parameterVector(2) = parameterVector(2)*(parameterVector(1))^(2);
Qinf = parameterVector(1)*sqrt(2*pi)*exp(parameterVector(3)+((parameterVector(2)^2)/(2*parameterVector(1)^2)));
parameterVector(3) = [];
disp('sigma:')
disp(parameterVector(1))
disp('mu:')
disp(parameterVector(2))

% plot the best fit curve
figure(1)
plot(t,exponentialFunct( Qinf , parameterVector(1) , parameterVector(2) , t ));
title('US Oil Production')
xlabel('t axis')
ylabel('y axis')
% -> plot the data:
for i = 1:length(inputMatrix)
    hold on
    plot(inFile(i,1),inFile(i,2),'*R')
    hold off
end