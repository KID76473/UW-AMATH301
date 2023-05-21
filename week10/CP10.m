%%% Problem 1
%%% First model the problem, and then solve it using ode45.

dt = 0.01;
t = 0 : dt : 6;
m0 = 2;
V0 = 1;

[~, V] = ode45(@(t, V) ode_mV(t, V), t, [V0, V0]);
A1 = V(:, 1);
A2 = V(:, 2);

for i = 1 : length(V(:, 2))
    if V(i, 2) > 10
        break;
    end
end
A3 = t(i);
A4 = 2;

[~, m] = ode45(@(t, m) ode_mV(t, m), t, [m0, m0]);
A5 = m(:, 1);
A6 = m(:, 2);

A7 = m(i, 2) / V(i, 2);

%%% Problem 2
%%% Use finite differences for boundary value problems and loop to iterate
%%% each timstep

dt = 0.01;
dx = 0.01;
x = -1 : dx : 1;
P = zeros(length(x), 1);
for i = 1 : length(x)
    P(i) = exp(1 - 1 / (1 - x(i) ^ 2));
end
mu = dt / (2 * dx ^ 2);
P_a = 0;
P_b = 0;

A = diag((1 + 2 * mu) * ones(1, length(x) - 2));
diag2 = -mu * ones(1, length(x) - 3);
A = A + diag(diag2, -1) + diag(diag2, 1);
A8 = A;

B = diag((1 - 2 * mu) * ones(length(x) - 2, 1));
diag2 = mu * ones(1, length(x) - 3);
B = B + diag(diag2, -1) + diag(diag2, 1);

b = B * P(2 : end - 1);
A9 = b;

% plot(x,P);  
% pause(0.1);
% hold on;
for t = dt : dt : 1
    b = B * P(2 : end - 1);
    b(1) = b(1) + mu * P_a;
    b(end) = b(end) + mu * P_b;
    P(2 : end - 1) = A \ b;
%     plot(x,P);  
%     pause(0.1);
end
% hold off
A10 = b;

A11 = P(151);

for t = dt : dt : 100
    b = B * P(2 : end - 1);
    b(1) = b(1) + mu * P_a;
    b(end) = b(end) + mu * P_b;
    P(2 : end - 1) = A \ b;
end
A12 = P(151);
    
%%% Problem 3

load CP10_M1.mat
load CP10_M2.mat
load CP10_M3.mat
%%%%%%%%%%%%%%%%%

U = M2;
S = M3;
V = M1;
data = U * S * V';
[m, n] = size(data);
sum = m * n;
sum = sum * 8 / 1e6;
A13 = sum;

for k = 1 : 1000
    if (m * k + k + n * k) / (m * n) > 0.99
        break;
    end
end
A14 = k;

A15 = (m * k + k + n * k) * 8 / 1e6;

W = V';
B =  U(:, 1 : k) * S(1 : k, 1 : k) * W(1 : k, :);
B = uint8(B);
imshow(B);
A16 = 17;

%%% Functions

function dx = ode_mV(t, x)
    dx1 = 2 - x(1);
    dx2 = x(1);
    dx = [dx1; dx2];
end
