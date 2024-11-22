import numpy as np
import matplotlib.pyplot as plt


def main_gain_selection(outdir=None):
    L=0.1
    rate=np.logspace(-2,2,1000)
    k2=L+rate*L
    levant=2*np.sqrt(L*(k2+L)/(k2-L))
    moreno2012=2*np.sqrt(k2-np.sqrt(k2**2-L**2))
    moreno=np.sqrt(2/(k2-L))
    chen=np.sqrt((-2*L**2+5*k2*L+11*k2**2)/(k2-L))
    seeber=np.sqrt(k2+L)
    plt.figure()
    plt.plot(rate,chen,label='Chen2024')
    plt.plot(rate,levant,label='Levant1998')
    plt.plot(rate,moreno2012,label="Moreno2012")
    plt.plot(rate,moreno,label="Moreno2014")
    plt.plot(rate,seeber,label='Seeber2017')

    plt.plot(rate,k2,'k--',label='$k_1=k_2$')

    used_k2=0.2
    used_L=0.1
    plt.plot((used_k2/used_L-1),0.18,"kx")
    used_k2=(8*np.sqrt(2)-3)/7*L
    plt.plot((used_k2/used_L-1),np.sqrt(used_k2+L),"ko")

    plt.legend()
    plt.gca().set_xscale('log')
    plt.xlabel('$k2/L-1$')
    plt.ylabel('minimum value of $k_1$')
    plt.ylim(-0.5,5)
    plt.grid()
    if outdir is not None:
        plt.savefig(outdir("k1-k2.pdf"))

if __name__ == '__main__':
    main_gain_selection()
    plt.show()