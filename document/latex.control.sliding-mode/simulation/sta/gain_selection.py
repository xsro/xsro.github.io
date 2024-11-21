import numpy as np
import matplotlib.pyplot as plt


def main_gain_selection(outdir=None):
    L=1
    k2=np.logspace(0.01,2,1000)
    levant=2*np.sqrt(L*(k2+L)/(k2-L))
    moreno=np.sqrt(2/(k2-L))
    chen=np.sqrt((-2*L**2+5*k2*L+11*k2**2)/(k2-L))
    seeber=np.sqrt(k2+L)
    plt.figure()
    plt.plot(k2/L-1,chen,label='Chen2024')
    plt.plot(k2/L-1,levant,label='Levant1998')
    plt.plot(k2/L-1,moreno,label="Moreno2014")
    plt.plot(k2/L-1,seeber,label='Seeber2017')

    plt.plot(k2/L-1,k2,'k--',label='$k_1=k_2$')

    used_k2=0.2
    used_L=0.1
    plt.plot((used_k2/used_L-1),0.18,"kx")

    plt.legend()
    plt.gca().set_xscale('log')
    plt.xlabel('$k2/L-1$')
    plt.ylabel('$k_1$')
    plt.ylim(-1,15)
    plt.grid()
    if outdir is not None:
        plt.savefig(outdir("k1-k2.pdf"))

if __name__ == '__main__':
    main_gain_selection()
    plt.show()