
%%% Problem 1
data = readmatrix('lynx.csv');
t = data(1, :);
pop = data(2, :);
%%% Don't delete the lines above when submitting to gradescope

%%% Replace the value of the population for the years given in the assignment file and save it as A1

pop(11) = 34;
pop(29) = 27;
A1 = pop;

%%% Calculate the value of the cubic spline interpolation of the data at t = 24.5 using the interp1 function.  Save this as A2.

A2 = interp1(t, pop, 24.5, 'spline');

%%% Use polyfit to calculate the coefficients for A3, A5, and A7
%%% Use norm to calculate the error for A4, A6, and A8

coeffs = polyfit(t, pop, 1);
A3 = coeffs;
y = polyval(coeffs, t);
A4 = norm(y - pop);

coeffs = polyfit(t, pop, 2);
A5 = coeffs;
y = polyval(coeffs, t);
A6 = norm(y - pop);

coeffs = polyfit(t, pop, 10);
A7 = coeffs;
y = polyval(coeffs, t);
A8 = norm(y - pop);

%%% Problem 2
data = readmatrix('CO2_data.csv');
t = data(1, :);
co2 = data(2, :);
%%% Don't delete the lines above when submitting to gradescope

%%% Use polyfit to calculate the coefficients for A9
%%% Use norm to calculate the error for A10

coeffs = polyfit(t, co2, 1);
A9 = coeffs;
y = polyval(coeffs, t);
A10 = norm(y - co2);

%%% Fit the exponential

coeffs = polyfit(t, log(co2 - 260), 1);
A11 = [exp(coeffs(2)), coeffs(1), 260];
y = exp(polyval(coeffs, t)) + 260;
A12 = norm(y - co2);

%%% Fit the sinusoidal
%%% There are a few different ways to do this, and we will refrain from giving away the answer to this part.  
%%% The class has been doing loops for a while now, so this part should be doable, albeit a little tricky.  
%%% We can however check to see if there are any bugs that we can spot.


month = 1; % index of month
year = 1;
amplitude = zeros(1, floor(t(end))); % amplitude of each year
group = zeros(1, 12); % value of co2 in a year
for i = 1 : 744
    group(month) = co2(i) - y(i);
    if year - t(i) < 1 && year - t(i) > 0
        month = month + 1;
    else
        amplitude(year) = max(group) - min(group);
        month = 1;
        group = zeros(1, 12);
        year = year + 1;
    end
end
% amplitude(year) = max(group) - min(group);

sum = 0;
for i = 1 : length(amplitude)
    sum = sum + amplitude(i);
end
avg = sum / length(amplitude) / 2;

A13 = [avg, 2 * pi];
A14 = norm(y + avg * sin(2 * pi * t) - co2);
