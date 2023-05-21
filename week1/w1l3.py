import numpy as np

A = np.array([[-1, 2, 1], [3, 0, -1], [4, -2, 2], [-2, 1, 3]])
print(A)
print(type(A))
print(A.ndim)
print(A.shape)
B = np.array([[1, -2, 0, 3], [2, 1, -4, 1], [-3, 0, 1, 1]])
print(B)
B = B +100
print(B)
x = np.array([[2], [-3], [1], [4]])
y = np.array([[-1], [-2], [1], [3]])
x_dot_y = x[0, 0] * y[0, 0] + x[1, 0] * y[1, 0] + x[2, 0] * y[2, 0] + x[3, 0] * y[3, 0]  # dot product
print(x_dot_y)
A = np.array([[-1, 2, 1], [3, 0, 1], [4, -2, 2], [-2, 1, 3]])
B = np.array([[1, -2], [2, 1], [-3, 0]])
print(A @ B)
