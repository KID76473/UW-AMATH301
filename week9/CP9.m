%%% Problem 1
%%% Use ode45 to solve the Fitzhugh-Nagumo IVP
%%% For the maxima use the plot to narrow down the times you use to search
%%% for the maximum.

v0 = 1;
w0 = 0;
dt = 0.5;
t = 0 : dt : 100;
[t, x] = ode45(@(t, y) ode_vw(t, y), t, [v0, w0]);
A1 = x(:, 1);

maxx = x(1, 1);
for i = 1 : 20
    if x(i, 1) > maxx
        maxx = x(i, 1);
    end
end
A2 = t(x(:, 1) == maxx);

maxx = x(81, 1);
for i = 80 : 100
    if x(i, 1) > maxx
        maxx = x(i, 1);
    end
end
A3 = t(x(:, 1) == maxx);

A4 = 1 / (A3 - A2);

%%% Problem 2
%%% Use ode45 to solve the Chua equation
%%% You can tell something is chaotic if it is seemingly random
%%% If it looks like all solutions tend toward a point or a circle it is
%%% not chaotic.

dt = 0.05;
t = 0 : dt : 100;
x0 = 0.1;
y0 = 0.2;
z0 = 0.3;
[~, I] = ode45(@(t, I) ode_xyz(t, I), t, [x0, y0, z0]);
A5 = 1;
A6 = I';

y0 = y0 + 1e-5;
[~, I] = ode45(@(t, I) ode_xyz(t, I), t, [x0, y0, z0]);
A7 = max(max(abs(I' - A6)));

y0 = 0.2;
[~, I] = ode45(@(t, I) ode_xyz_alter(t, I), t, [x0, y0, z0]);
A8 = 0;

%%% Problem 3

%%% Part 1: Finite Differences
%%% Use finite differences to solve the BVP
%%% Be careful about the shape of the vectors, you may have to transpose to
%%% get the correct shape.  It's a good idea to print the solutions out to
%%% make sure the shape is correct.

x0 = 1;
xT = 0.5;
dt = 0.1;
t = 0 : dt : 6;

v = (dt ^ 2 - 2) * ones(length(t) - 2, 1);
u = ones(length(t) - 3, 1);
A = (diag(v) + diag(u, -1) + diag(u, 1)) / dt ^ 2;
A9 = A;

tt = 0.1 : dt : 5.9;
b = 5 * cos(4 * tt);
b(1) = 5 * cos(4 * 0.1) - x0 / dt ^ 2;
b(end) = 5 * cos(4 * 5.9) - xT / dt ^ 2;
b = b';
A10 = b;

x_int = A \ b;
x = [x0; x_int; xT];
A11 = x;

C1 = (0.5 + cos(24) / 3 - 4 * cos(6) / 3) / sin(6);
C2 = 4 / 3;
x_true = C1 * sin(t) + C2 * cos(t) - cos(4 * t) / 3;
error = max(abs(x' - x_true));
A12 = error;

%%% Part 2: Shooting Method via Bisection
%%% Use the shooting method to solve the BVP
%%% It's a good idea to test out a few in the command window first to make
%%% sure that your initial conditions gets you to different sides of the right
%%% boundary condition.
%%% Use the plot to help you figure out what your choices of initial
%%% conditions should be

v1 = 2;
v2 = 2.5;

[t_v1, x_v1] = ode45(@(t, x) ode_x(t, x), t, [x0, v1]);
disp(x_v1(end, 1));

[t_v2, x_v2] = ode45(@(t, x) ode_x(t, x), t, [x0, v2]);
disp(x_v2(end, 1));

mid = (v1 + v2) / 2;
[t_mid, x_mid] = ode45(@(t, x) ode_x(t, x), t, [x0, mid]);

for i = 1 : 100
    if abs(x_mid(end, 1) - xT) < 1e-8
        break;
    elseif sign(x_mid(end, 1) - xT) == sign(x_v1(end, 1) - xT)
        v1 = mid;
        [t_v1, x_v1] = ode45(@(t, x) ode_x(t, x), t, [x0, v1]);
    elseif sign(x_mid(end, 1) - xT) == sign(x_v2(end, 1) - xT)
        v2 = mid;
        [t_v2, x_v2] = ode45(@(t, x) ode_x(t, x), t, [x0, v2]);
    end
    mid = (v1 + v2) / 2;
    [t_mid, x_mid] = ode45(@(t, x) ode_x(t, x), t, [x0, mid]);
end
A13 = x_mid(:, 1);

error = max(abs(x_mid(:, 1)' - x_true));
A14 = error;

A15 = max(abs(A13 - A11));

%%% You can set up your ODEs as functions here if you like

function y = ode_vw(t, y)
    a = 0.7;
    b = 1;
    tau = 12;
    v_prime = y(1) - y(1) ^ 3 / 3 - y(2) + 1 / 10 * (5 + sin(pi * t / 10));
    w_prime = (a + y(1) - b * y(2)) / tau;
    y = [v_prime; w_prime];
end

function current = ode_xyz(t, I)
    alpha = 16;
    beta = 30;
    x_prime = alpha * (I(2) + I(1) / 6 - I(1) ^ 3 / 16);
    y_prime = I(1) - I(2) + I(3);
    z_prime = -beta * I(2);
    current = [x_prime; y_prime; z_prime];
end

function I = ode_xyz_alter(t, I)
    alpha = 16;
    beta = 100;
    x_prime = alpha * (I(2) * I(1) / 6 - I(1) ^ 3 / 16);
    y_prime = I(1) - I(2) + I(3);
    z_prime = -beta * I(2);
    I = [x_prime; y_prime; z_prime];
end

function y = ode_x(t, x)
    y1 = x(2);
    y2 = 5 * cos(4 * t) - x(1);
    y = [y1; y2];
end
