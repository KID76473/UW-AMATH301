
%%% Problem 1
%%% Implement the Bisection method as we did in the Week 5 Coding Lecture

t = [0 : 0.01 : 5];
c = 1.3 * (exp(-1 * t / 11) - exp(- 4 * t / 3));
dc = 1.3 * (-exp(-t / 11) / 11 + 4 * exp(-4 * t / 3) / 3);
plot(t, c, t, dc, 'linewidth', 4); 

a = 1;
b = 3;
mid = (a + b) / 2;
dc_mid = 1.3 * (-exp(-mid / 11) / 11 + 4 * exp(-4 * mid / 3) / 3);

while abs(dc_mid) >= 1e-8
    
    if dc_mid >= 0
        a = mid;
    elseif dc_mid < 0
        b = mid;
    end
    
    mid = (a + b) / 2;
    dc_mid = 1.3 * (-exp(-mid / 11) / 11 + 4 * exp(-4 * mid / 3) / 3);

end

A1 = mid;
A2 = 1.3 * (exp(-1 * mid / 11) - exp(- 4 * mid / 3));
A3 = 1.3 * (-exp(-mid / 11) / 11 + 4 * exp(-4 * mid / 3) / 3);

%%% Problem 2
%%% Implement Newton's method as we did in the Week 5 Coding Lecture

x = zeros(1, 100);
x(1) = 2;
f = x(1) ^ 2;
df = 2 * x(1);
ddf = 2;

i = 1;
while abs(df) >= 1e-8
    
    x(i + 1) = x(i) - df / ddf;
    
    i = i + 1;
    f = x(i) ^ 2;
    df = 2 * x(i);
    
end

A4 = i; % wrong
A5 = x(i); % correct

x = zeros(1, 1000);
x(1) = 2;
g = x(1) ^ 500;
dg = 500 * x(1) ^ 499;
ddg = 500 * 499 * x(1) ^ 498;

i = 1;
while abs(dg) >= 1e-8
    
    x(i + 1) = x(i) - dg / ddg;
    
    i = i + 1;
    g = x(i) ^ 500;
    dg = 500 * x(i) ^ 499;
    ddg = 500 * 499 * x(i) ^ 498;
    
end

A6 = i;
A7 = x(i);

x = zeros(1, 1000);
x(1) = 2;
h = x(1) ^ 1000;
dh = 1000 * x(1) ^ 999;
ddh = 1000 * 999 * x(1) ^ 998;

i = 1;
while abs(dh) >= 1e-8
    
    x(i + 1) = x(i) - dh / ddh;
    
    i = i + 1;
    h = x(i) ^ 1000;
    dh = 1000 * x(i) ^ 999;
    ddh = 1000 * 999 * x(i) ^ 998;
    
end

A8 = i;
A9 = x(i);
