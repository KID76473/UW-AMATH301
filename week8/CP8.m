%%% Problem 1
%%% Initialize t, and x_true

dt = 0.1;
t = 0 : dt : 10;
x_true = @(t) 1 / 2 * (cos(t) + sin(t) + exp(-t));

%%% Forward Euler
%%% Write a forward Euler scheme

x = ones(1, 101);
for i = 1 : length(x) - 1
    x(i + 1) = x(i) + dt * (cos(t(i)) - x(i));
end
A1 = x;

error = zeros(1, 101);
for i = 1 : length(x)
    error(i) = abs(x(i) - x_true(t(i)));
end
A2 = error;

%%% Backward Euler
%%% Write a backward Euler scheme

x = ones(1, 101);
for i = 1 : length(x) - 1
    x(i + 1) = (x(i) + dt * cos(t(i + 1))) / (1 + dt);
end
A3 = x;

error = zeros(1, 101);
for i = 1 : length(x)
    error(i) = abs(x(i) - x_true(t(i)));
end
A4 = error;

%%% Built-in Solver
%%% Use ode45
%%% Don't forget to transpose the solution you get from ode45.

x0 = 1;
f = @(t, x) cos(t) - x;
[~, x_ode] = ode45(f, t, x0);
A5 = x_ode.';

error = zeros(1, 101);
for i = 1 : length(x)
    error(i) = abs(x_ode(i) - x_true(t(i)));
end
A6 = error;

%%% Problem 2
%%% Initialize the parameters

a = 8;

%%% Forward Euler for dt = 0.01
%%% Initialize t and x_true
%%% Write a forward Euler scheme

dt = 0.01;
t = 0 : dt : 2;
x_true = 2 * atan(exp(a * t) / (1 + sqrt(2)));

x = zeros(1, 201);
x(1) = pi / 4;
for i = 1 : length(x) - 1
    x(i + 1) = x(i) + dt * a * sin(x(i));
end
A7 = x;

error = max(abs(x - x_true));
A8 = error;

%%% Forward Euler dt = 0.001
%%% Reinitialize t and x_true
%%% Write a forward Euler scheme

dt = 0.001;
t = 0 : dt : 2;
x_true =  2 * atan(exp(a * t) / (1 + sqrt(2)));

x = zeros(1, 2001);
x(1) = pi / 4;
for i = 1 : length(x) - 1
    x(i + 1) = x(i) + dt * a * sin(x(i));
end

error = max(abs(x - x_true));
A9 = A8 / error;

%%% Predictor-Corrector dt = 0.01
%%% Reinitialize t and x_true
%%% Write a forward Euler scheme and a backward Euler scheme in the same
%%% loop.
%%% The forward Euler scheme is the predictor.  The answer from forward
%%% Euler will be plugged into the sin(x_n+1) in the backward Euler scheme.

dt = 0.01;
t = 0 : dt : 2;
x_true = 2 * atan(exp(a * t) / (1 + sqrt(2)));

x = zeros(1, 201);
x(1) = pi / 4;
for i = 1 : length(x) - 1
    x(i + 1) = x(i) + dt * a * sin(x(i));
    x(i + 1) = x(i) + dt * a * sin(x(i + 1));
end
A10 = x;

error = max(abs(x - x_true));
A11 = error;

%%% Predictor-Corrector dt = 0.001
%%% Reinitialize t and x_true
%%% Write a forward Euler scheme and a backward Euler scheme in the same
%%% loop.
%%% The forward Euler scheme is the predictor.  The answer from forward
%%% Euler will be plugged into the sin(x_n+1) in the backward Euler scheme.

dt = 0.001;
t = 0 : dt : 2;
x_true =  2 * atan(exp(a * t) / (1 + sqrt(2)));

x = zeros(1, 2001);
x(1) = pi / 4;
for i = 1 : length(x) - 1
    x(i + 1) = x(i) + dt * a * sin(x(i));
    x(i + 1) = x(i) + dt * a * sin(x(i + 1));
end

error = max(abs(x - x_true));
A12 = A11 / error;

%%% Builtin Solver
%%% Reinitialize t and x_true
%%% Use ode45 to solve the ODE.
%%% Don't forget to transpose the solution you get from ode45.

t = 0 : 0.01 : 2;
x_true = 2 * atan(exp(a * t) / (1 + sqrt(2)));

f = @(t, x) a * sin(x);
[~, x_ode] = ode45(f, t, pi / 4);
A13 = x_ode.';

error = max(abs(x_true - x_ode.'));
A14 = error;

t = 0 : 0.001 : 2;
x_true = 2 * atan(exp(a * t) / (1 + sqrt(2)));

tspan = 0 : 0.001 : 2;
f = @(t, x) a * sin(x);
[~, x_ode] = ode45(f, t, pi / 4);

error = max(abs(x_true - x_ode.'));
A15 = A14 / error;

%%%  If you want to write local functions, put them here
