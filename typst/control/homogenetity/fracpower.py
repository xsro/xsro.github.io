
import numpy as np
def ode4(func,tspan,x0,step=0.1):
    t0=tspan[0]
    tfinal=tspan[1]
    t=float(t0);x=float(x0)
    tout=[t0]
    xout=[x0]
    dxout=[]
    while t < tfinal:
        k1=func(t,x)
        k2=func(t+step/2,x+step/2*k1)
        k3=func(t+step/2,x+step/2*k2)
        k4=func(t+step,x+step*k3)
        t=t+step
        x=x+step/6*(k1+2*k2+2*k3+k4)
        tout.append(t)
        xout.append(x)
        dxout.append(k1)
    dxout.append(func(t,x))
    return tout,xout,dxout

def frac_power_x(x,v):
    if x==0:
        return 0
    else:
        return np.sign(x)*np.abs(x)**v

def sat(x, threhold=10):
    if x>threhold:
        return np.sign(x)*threhold
    else:
        return x

powers=[
    -3,-2,-1,-1/2,-1/3,
    0,1/3,1/2,1,2,3,
]

if __name__=="__main__":
    import matplotlib.pyplot as plt
    import os

    # plt.figure()
    # for i,power in enumerate(powers):
    #     tfinal=10
    #     def sat_rhs(t,x):
    #         o=frac_power_x(x,power)
    #         o=sat(o,threhold=20)
    #         return -o
    #     print(f"simulating dot(x)=-sign(x)|x|^{power}")
    #     sol=solve_ivp(sat_rhs,[0,tfinal],np.array([1.]),t_eval=np.linspace(0,tfinal,1000),method="BDF")
    #     plt.grid(True)
    #     plt.plot(sol.t,sol.y.T,label=f"$\\dot{{x}}=-sign(x)|x|^{power}$")
    # plt.tight_layout()
    # plt.legend()
    # plt.show()

    plt.figure()
    for i,power in enumerate(powers):
        tfinal=10
        T=2
        def sat_rhs(t,x):
            if t<T:
                o=frac_power_x(T-t,power)
                o=sat(o,threhold=20)
                return -o*x
            else:
                return 0
        print(f"simulating dot(x)=-sign(x)|x|^{power}")
        tout,xout,dxout=ode4(sat_rhs,[0,tfinal],1.,step=1e-4)
        plt.grid(True)
        plt.plot(tout,xout,label=f"$\\dot{{x}}=-|T-t|^{{{power}}} x$")
    plt.tight_layout()
    plt.legend()
    plt.show()
