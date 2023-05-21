%%% Problem 1
data = readmatrix('population.csv');
t = data(1, :);
N = data(2, :);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Determine your stepsize dt from the vector t

dt = -110 : 1 : 120;

%%% Use the appropriate second order differences from the Theory Lecture

A1 = (3 * N(end) - 4 * N(end - 1) + N(end - 2)) / 20;

A2 = (N(11) - N(9)) / 20;

A3 = (- 3 * N(1) + 4 * N(2) - N(3)) / 20;

N_prime = zeros(1, length(t));
N_prime(1) = A3;
N_prime(end) = A1;
for i = 2 : 23
    N_prime(i) = (N(i + 1) - N(i - 1)) / 20;
end
A4 = N_prime;

A5 = N_prime ./ N;

sum = 0;
for i = 1 : length(A5)
    sum = sum + A5(i);
end
avg = sum / length(A5);
A6 = avg;

%%% For dN/dt you will need to use a combination of the above differences,
%%% but the choice will be obvious based on which direction you can/cannot
%%% go in the horizontal axis.  Whenever possible use central difference;
%%% only use forward or backward when central is not possible.




%%% Problem 2
data = readmatrix('brake_pad.csv');
r = data(1, :);
T = data(2, :);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Determine your stepsize dr from the vector r

dr = 0.017;

theta = 0.7051;

%%% Use the LHR formula from the coding lecture

T_total = 0;
for i = 1 : length(r) - 1
    T_total = T_total + r(i) * T(i) * theta * dr;
end
A7 = T_total;

A = 0;
for i = 1 : length(r) - 1
    A = A + r(i) * theta * dr;
end

T_avg = T_total / A;
A8 = T_avg;

%%% Use the RHR formula from the coding lecture

T_total = 0;
for i = 2 : length(r)
    T_total = T_total + r(i) * T(i) * theta * dr;
end
A9 = T_total;

A = 0;
for i = 2 : length(r)
    A = A + r(i) * theta * dr;
end

T_avg = T_total / A;
A10 = T_avg;

%%% Use the Trapezoid rule formula or the trapz function from the coding lecture

lhr = 0;
rhr = 0;
for i = 1 : length(r) - 1
    lhr = lhr + r(i) * T(i) * theta * dr;
    rhr = rhr + r(i + 1) * T(i + 1) * theta * dr;
end
T_total = (lhr + rhr) / 2;
A11 = T_total;

% LHR = dr * sum(r(1:end-1));
% RHR = dr * sum(r(2:end));
% total = (LHR + RHR) / 2;

lhr = 0;
rhr = 0;
for i = 1 : length(r) - 1
    lhr = lhr + r(i) * theta * dr;
    rhr = rhr + r(i + 1) * theta * dr;
end
A = (lhr + rhr) / 2;

T_avg = T_total / A;
A12 = T_avg;

%%% Problem 3
%%% You'll have to use anonymous functions here.  You can see the syntax in
%%% the Numerical Integration coding lecture where the builtin function
%%% "integrand" is used.

f = @(x) x .^ 2 / 2 - x .^ 3 / 3;

T = @(z) 0.95 ./ sqrt(f(0.95) - ((0.95 * z) .^ 2 / 2 - (0.95 * z) .^ 3 / 3));
A13 = integral(T, 0, 1);

T = @(z) 0.5 ./ sqrt(f(0.5) - ((0.5 * z) .^ 2 / 2 - (0.5 * z) .^ 3 / 3));
A14 = integral(T, 0, 1);

T = @(z) 0.01 ./ sqrt(f(0.01) - ((0.01 * z) .^ 2 / 2 - (0.01 * z) .^ 3 / 3));
A15 = integral(T, 0, 1);
