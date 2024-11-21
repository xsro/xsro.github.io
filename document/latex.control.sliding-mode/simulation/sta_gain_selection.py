import numpy as np
import matplotlib.pyplot as plt

if __name__ == '__main__':
    L=1
    k2=np.logspace(0.01,2,1000)
    levant=2*np.sqrt(L*(k2+L)/(k2-L))
    chen=np.sqrt((-2*L**2+5*k2*L+11*k2**2)/(k2-L))
    plt.figure()
    plt.plot(k2,chen,label='chen')
    plt.plot(k2,levant,label='levant')
    plt.legend()
    plt.gca().set_xscale('log')
    plt.xlabel('$k2/L$')
    plt.ylabel('$k_1$')
    plt.grid()
    plt.show()