import numpy as np
import statsmodels.api as sm 
import matplotlib.pyplot as plt 


# Load data
nsample = 100
x = np.linspace(0, 10, 100)
X = np.column_stack((x, x ** 2))
beta = np.array([1, 0.1, 10])
e = np.random.normal(size=nsample)



