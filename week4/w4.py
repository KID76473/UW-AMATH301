import numpy as np
import scipy.linalg as la

A = np.array([[1, 4, -1], [3, 2, 0], [-1, 4, 3]])
print('determinant of A:', la.det(A))

M = np.array([[1, 2], [0, 3]])
[w, V] = la.eig(M)
print('eigen  value:', w)  # ???
print('eigen vector:', V)
D = np.diag(w)
print(D)

A = np.array([[6, 1, 1], [1, 8, 2], [2, 3, 9]])
b = np.array([[10], [-8], [-8]])
D = np.diag(np.diag(A))
P = A - D;

x = np.zeros((3, 1))
for i in range(100):
    x = la.solve_triangular(D, -P @ x + b)
print('x:', x)
