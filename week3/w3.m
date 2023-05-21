
% backslash
% Ax = b
A1 = [2 1; -6 1];
b1 = [5; -3];
x1 = A \ b;

% no solution
A2 = [3 2; 3 2];
b2 = [5; 4];
x2 = A2 \ b2;

% infinitely many solution
A3 = [3 2; 3 2];
b3 = [5; 5];
x3 = A3 \ b3;

% cond calculates the condition number of a matrix
cond(A1)
% rcond calculates 1 / cond(A)
rcond(A1)
% det calculates the determinant of a matrix
det(A1)

% PA = LU
% Ax = b
A = [2 1 1; 4 3 3; 8 7 9];
b = [1; 1; -1];
% finally we get LUx = b and we assume Ly = b and y = Ux
L = [1 0 0; 2 1 0; 4 3 1];
U = [2 1 1; 0 1 1; 0 0 2];
y = L \ b;
x = U \ y;
% another way to solve it using lu(A)
[L1, U1, P1] = lu(A);
yy = L \ (P1 * b);
xx = U1 \ yy;
% Ax = b
% PAx = Pb
% LUx = Pb Ux = y
% Ly = Pb
% y = L \ (P * b)
% x = U \ y

% inverse of a matrix
inv(A);
% Ax = b
% A^-1 * A * x = A^-1 * b
% x = A^-1 * b
xxx = inv(A) * b;

% If the system is lower/upper triangular, you can use forward/back substitution.  The code for this in MATLAB is x = A\b and O(N^2) 

% If you have to solve multiple systems with the same A, but different right hand sides, you can use LU - decomposition.  
% The first system will take O)N^3) flops, but subsequent systems will only take O(N^2) flops.  

% You can always fall back on Gaussian elimination.  The code for this in MATLAB is also x = A\b, 
% but if A is not triangular than it takes O(N^3) flops.  

% You should not use matrix inverses.  
