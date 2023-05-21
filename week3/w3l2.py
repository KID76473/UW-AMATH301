import numpy as np
import scipy.linalg

A = np.array([[2, 1, 1], [4, 3, 3], [8, 7, 9]])
b = np.array([[1], [1], [-1]])

P, L, U = scipy.linalg.lu(A)
P = P.T
y = scipy.linalg.solve_triangular(L, P @ b, lower=True)
x = scipy.linalg.solve_triangular(U, y)
print(x)

x = scipy.linalg.inv(A) @ b
print(x)
