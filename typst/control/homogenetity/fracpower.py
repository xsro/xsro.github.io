
import numpy as np
from scipy.integrate import solve_ivp

configs=[
    (r"$\dot{x}=-\mathrm{sign}(x)$",lambda t,x:-np.sign(x),),
    (r"$\dot{x}=-1/\sqrt[3]{x}$",lambda t,x:-np.sign(x)*np.abs(x)**(-1/3),),
    (r"$\dot{x}=-1/x$",lambda t,x:-1/x,),
    (r"$\dot{x}=-\mathrm{sign}(x)1/|x|^2$",lambda t,x:-np.sign(x)*np.abs(x)**(-2),),
]



if __name__=="__main__":
    import matplotlib.pyplot as plt
    import os
    rhs_data=[]
    ode_data=[]
    x=np.linspace(-1,1,100)
    rhs_data.append(x.reshape((-1,1)))
    for i,(latex,rhs) in enumerate(configs):
        tfinal=10
        def sat_rhs(t,x):
            o=rhs(t,x)
            if abs(o)>10:
                return np.sign(o)*10
            return o
        print("simulating",str(rhs))
        sol=solve_ivp(sat_rhs,[0,tfinal],np.array([1.]),t_eval=np.linspace(0,tfinal,1000))
        y=np.array(list(map(lambda x:-rhs(0,x),x)))
        rhs_data.append(y.reshape((-1,1)))
        plt.subplot(4,2,2*i+2)
        plt.grid(True)
        plt.plot(sol.t,sol.y.T)
        plt.title(latex)
        plt.subplot(4,2,2*i+1)
        plt.grid(True)
        plt.plot(x,y)
    plt.tight_layout()
    # np.savetxt(__file__+".csv",np.hstack(rhs_data),fmt='%1.2e')
    plt.show()
