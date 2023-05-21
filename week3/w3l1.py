import numpy as np
import scipy.linalg

A = np.array([[1, 2], [3, 4]])
B = np.array([[-2, 1], [0, 3]])
print("A: ", A)
print("B: ", B)

# elementwise multiplication
C = A * B
print("C: ", C)

# normal multiplication
D = A @ B
print("D:", D)

A = np.array([[2, 1], [-6, 1]])
b = np.array([[5], [-3]])
x = scipy.linalg.solve(A, b)
print("Ax = b")
print("x: ", x)

A = np.array([[2, 1, 1], [0, 1, 1], [0, 0, 2]])
b = np.array([[1], [-1], [-2]])
x = scipy.linalg.solve_triangular(A, b)  # upper triangle
print(x)
x = scipy.linalg.solve_triangular(A, b, lower=True)  # lower triangle

# condition number of a matrix
A = np.array([3, 2], [3, 2])
print(np.linalg.cond(A))
print(np.linalg.det(A))
