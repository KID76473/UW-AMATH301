import numpy as np
import matplotlib.pyplot as plt

x = np.arange(0, 10, 0.5)
print(x)
y = x ** 2 + 3
z = -x ** 2 -6 * x +80
print(y)
plt.plot(x, y, 'r:')
plt.plot(x, z, 'o')
plt.show()
