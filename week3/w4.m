
A = [1 4 -1; 3 2 0; -1 4 3];
det(A)

A = [4, 1; 3, 2];
[V, D] = eig(A);
diap(V * D * inv(V));

% Jacobi method
A = diag([1, 2, 3, 4, 5]) + 0.1 * randn(5);
L = tril(A,-1);  % lower triangle
U = triu(A,+1);  % upper triangle
D = diag(A);
b = ones(5,1);
x = zeros(5,1);


M = -(L+U)./D;
c = b./D;
x = M*x + c;
