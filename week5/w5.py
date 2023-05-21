import numpy as np
import matplotlib.pyplot as plt

x = np.arange(2, 5, 0.01)
f = x * np.cos(x)
df = np.cos(x) - x * np.sin(x)
plt.plot(x, f, x, df)

root_entry = np.argmin(abs(df))
root = x[root_entry]
print(root)
plt.plot(root, 0, 'k.', root, f[root_entry], 'g.', markersize=40)
plt.show()
