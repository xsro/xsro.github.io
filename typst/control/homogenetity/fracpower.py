
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
        if abs(step/6*(k1+2*k2+2*k3+k4))>2:
            print(1)
            k2=func(t+step/2,x+step/2*k1)
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
    if np.abs(x)>threhold:
        return np.sign(x)*threhold
    else:
        return x

powers=[
    -3,-2,-1,"-1/2","-1/3",
    0,"1/3","1/2",1,2,3,
]
# powers=[-1]

if __name__=="__main__":
    import matplotlib.pyplot as plt
    import os

    plt.figure()
    threhold=8
    plt.title("simulation with "+r"$\dot{x}=-sign(x)|x|^v$"+f" control threhold {threhold}")
    for i,power_ in enumerate(powers):
        power=eval(power_) if type(power_)==str else power_
        tfinal=10
        def sat_rhs(t,x):
            o=frac_power_x(x,power)
            o=sat(o,threhold=8)
            return -o
        print(f"simulating dot(x)=-sign(x)|x|^{power}")
        tout,xout,dxout=ode4(sat_rhs,[0,tfinal],1.,step=1e-3)
        plt.subplot(2,1,1)
        plt.grid(True)
        plt.plot(tout,xout,label=f"v={power_}")
        plt.subplot(2,1,2)
        plt.grid(True)
        plt.plot(tout,dxout,label=f"v={power_}")
    plt.tight_layout()
    plt.legend()
    plt.show()

    plt.figure()
    threhold=8
    plt.title("simulation with "+r"$\dot{x}=sat(-|T-t|^v x)$"+f" control threhold {threhold}")
    for i,power_ in enumerate(powers):
        power=eval(power_) if type(power_)==str else power_
        tfinal=10
        T=2
        def sat_rhs(t,x):
            if t<T:
                o=-frac_power_x(T-t,power)*x
                o=sat(o,threhold=10)
                return o
            else:
                return 0
        print(f"simulating dot(x)=-sign(x)|x|^{power}")
        tout,xout,dxout=ode4(sat_rhs,[0,T],1.,step=1e-3)
        plt.subplot(2,1,1)
        plt.grid(True)
        plt.plot(tout,xout,label=f"$v={power_}$")
        plt.subplot(2,1,2)
        plt.grid(True)
        plt.plot(tout,dxout,label=f"$v={power_}$")
    plt.tight_layout()
    plt.legend()
    plt.show()
