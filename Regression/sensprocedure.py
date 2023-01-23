import numpy as np
import pandas as pd
from scipy.stats.mstats import theilslopes
from matplotlib import pyplot as plt

def main():
    df = pd.read_excel("HomeWork_Regression_2022.xls", sheet_name = "VMres3")
    x = np.array(df["T(s)"])
    y = np.array(df["allocated heap"])
    slope, intercept, low, up = theilslopes(y, x, 0.95)
    print("Pendenza: {} \nIntervallo di confidenza al 95%: [{},{}]  \nIntercetta: {}".format(slope, low, up, intercept))

    plt.scatter(x, y)
    plt.plot(x, slope*x + intercept, color='r')
    plt.plot(x, low*x + intercept, color='g')
    plt.plot(x, up*x + intercept, color='b')

    plt.xlabel('X')
    plt.ylabel('Y')
    plt.show()

if __name__ == "__main__":

    main()