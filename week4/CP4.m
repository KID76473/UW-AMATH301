
%%%  Problem 1
%%%  First go to the end of your m-file to create your Jacobi and
%%%  Gauss-Seidel functions.

%%% Once you have created your functions return here.
%%% Initialize your matrix A and RHS b
    
A = [1.1 0.2 -0.2 0.5; 0.2 0.9 0.5 0.3; 0.1 0 1 0.4; 0.1 0.1 0.1 1.2];
b = [1; 0; 1; 0];

%%% Use your Jacobi and Gauss-Seidel functions to find A1 through A4.

Tj = zeros(1, 4);
Ej = zeros(1, 4);
i = 1;
while i <= 4
    [Tj(i), Ej(i)] = J(A, b, 10^(-2 * i));
    i = i + 1;
end
A1 = Tj;
A2 = Ej;

Tgs = zeros(1, 4);
Egs = zeros(1, 4);
i = 1;
while i <= 4
    [Tgs(i), Egs(i)] = GS(A, b, 10^(-2 * i));
    i = i + 1;
end
A3 = Tgs;
A4 = Egs;

%%%  Problem 2
%%%  Initialize your Day 0 vector x
    
x = zeros(3, 100000);
x(:, 1) = [0.9; 0.09; 0.01];
      
%%%  Part 1: without a vaccine
%%%  Make sure to have p = 0
%%%  Initialize the SIR matrix M, and save it as A5

M = [199/200 0 1/10000; 1/200 999/1000 0; 0 1/1000 9999/10000];
A5 = M;

%%%  Create a loop to find the day that the number of infected
%%%  individuals hits 50% and another loop for the steady state of the
%%%  infected population
%%%  There is a way to put everything under one loop if you make clever use
%%%  of conditionals

temp = true;
for i = 1 : 100000
    x(:, i + 1) = M * x(:, i);
    if x(2, i + 1) >= 0.5 && temp
        D0 = i;
        temp = false;
    end
    if abs(x(2, i) - x(2, i + 1)) < 1e-8
        break
    end
end
F0 = x(2, i + 1);

%%% Save the days and steady state in a row vector A6

A6 = [D0, F0];

%%%  Reinitialize your Day 0 vector x

x = zeros(3, 100000);
x(:, 1) = [0.9; 0.09; 0.01];  

%%%  Part 2: with a vaccine
%%%  Make sure to have p = 2/1000
%%%  Initialize the SIR matrix M, and save it as A7

M = [199/200 - 2/1000 0 1/10000; 1/200 999/1000 0; 2/1000 1/1000 9999/10000];
A7 = M;

%%%  Create a loop to find the day that the number of infected
%%%  individuals hits 50% and another loop for the steady state of the
%%%  infected population
%%%  There is a way to put everything under one loop if you make clever use
%%%  of conditionals

temp = true;
for i = 1 : 100000
    x(:, i + 1) = M * x(:, i);
    if x(2, i + 1) >= 0.5 && temp
        D1 = i;
        temp = false;
    end
    if abs(x(2, i) - x(2, i + 1)) < 1e-8
        break
    end
end
F1 = x(2, i + 1);

%%% Save the days and steady state in a row vector A8

A8 = [D1, F1]; 

%%%  Problem 3
  
%%%  Initialize your 114x114 tridiagonal matrix A

v1 = ones(114, 1);
v2 = ones(113, 1);
A = 2 * diag(v1) - diag(v2, 1) - diag(v2, -1);
A9 = A;

%%%  Initialize your 114x1 RHS column vector rho

rho = zeros(114, 1);
for j = 1 : 114
    rho(j, 1) = 2 * (1 - cos(53 * pi / 115)) * sin(53 * pi * j / 115);
end
A10 = rho;

%%%  Implement Jacobi's method for this system.
%%%  Don't use the function you created before because that was designed for
%%%  a specific task, and will not work here.

% P = diag(diag(A114));
L = tril(A,-1);
U = triu(A,+1);
D = diag(A);
phi = zeros(114, 100000);
phi(:, 1) = ones(114, 1);

M = -(L+U)./D;
c = rho./D;
% i = 1;
% while max(abs(phi(:, i + 1) - phi(:, i))) > 1e-5
%     phi(:, i + 1) = M * phi(:, i) + c;
%     disp(max(abs(phi(:, i + 1) - phi(:, i))))
%     i = i + 1;
% end

for i = 1 : 100000
    phi(:, i + 1) = M * phi(:, i) + c;
    if max(abs(phi(:, i) - phi(:, i + 1))) <= 1e-5
        break
    end
end

%%%  Create a column vector phi that contains the exact solution given in
%%%  the assignment file

i = i + 1;
A11 = phi(:, i);
A12 = i;

%%%  Save the difference of the Jacobi solution and the exact solution as
%%%  A13.  Use the maximal entry in absolute value to calculate this error.

temp = zeros(1, 144);
for j = 1 : 114
    temp(j) = phi(j, i) - sin(53 * pi * j / 115);
end
A13 = max(abs(temp));

%%%  Implement Gauss-Seidel for this system.
%%%  Don't use the function you created before because that was designed for
%%%  a specific task, and will not work here.

U = triu(A) - diag(diag(A));
L = tril(A);

phi = ones(114, 10000);

M = -L \ U;
c = L \ rho;
for i = 1 : 10000
    phi(:, i + 1) = M * phi(:, i) + c;
    if max(abs(phi(:, i) - phi(:, i + 1))) <= 1e-5
        break
    end
end

i = i + 1;
A14 = phi(:, i);
A15 = i;


%%%  Save the difference of the Gauss-Seidel solution and the exact solution as
%%%  A13.  Use the maximal entry in absolute value to calculate this error.

temp = zeros(1, 144);
for j = 1 : 114
    temp(j) = max(abs(phi(j, i) - sin(53 * pi * j / 115)));
end
A16 = max(temp);

%%% Jacobi and Gauss Seidel Iteration functions
%%% Create your functions here
%%% Both functions will need two outputs and three inputs
%%% The code within the function will be very similar to
%%% Week 4 coding lecture 2

function [i, E] = J(A, b, e)
    P = diag(diag(A));
    T = A - P;
    
    y = zeros(4, 1);
    
    i = 0;
    M = -P \ T;
    c = P \ b;
    while max(abs(A * y - b)) >= e
        y = M * y + c;
        i = i + 1;
    end
    
    E = max(abs(A * y - b));
end

function [i, E] = GS(A, b, e)
    U = triu(A) - diag(diag(A));
    P = tril(A);
    
    y = zeros(4, 1);
    
    M = -P \ U;
    c = P \ b;
    i = 0;
    while max(abs(A * y - b)) >= e
        y = M * y + c;
        i = i + 1;
    end
    
    E = max(abs(A * y - b));
end
