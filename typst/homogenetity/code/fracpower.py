
import numpy as np
from scipy.integrate import solve_ivp

configs=[
    (r"$\dot{x}=-x$",lambda t,x:-x**1,),
    (r"$\dot{x}=-\mathrm{sign}(x)$",lambda t,x:-np.sign(x),),
    (r"$\dot{x}=-\sqrt[3]{x}$",lambda t,x:-x**(1/3),),
    (r"$\dot{x}=-\mathrm{sign}(x)|x|^2$",lambda t,x:-np.sign(x)*x**2,),
]



if __name__=="__main__":
    import matplotlib.pyplot as plt
    for i,(latex,rhs) in enumerate(configs):
        plt.subplot(2,2,i+1)
        tfinal=100 if i==3 else 10
        sol=solve_ivp(rhs,[0,tfinal],np.array([1.]),t_eval=np.linspace(0,tfinal,1000))
        plt.grid(True)
        plt.plot(sol.t,sol.y.T)
        plt.title(latex)
    plt.tight_layout()
    plt.show()