"""
Python 3.12.4 on win32 (AMD64)
Implement of Super Twisting Sliding Mode Algorithm (STA) with Runge Kutta 4th order method
@author: xsro@foxmail.com
"""
import numpy as np
import matplotlib.pyplot as plt
import dataclasses

@dataclasses.dataclass
class STAParams:
    k1=0.19
    k2=0.2
    d=0.1  #扰动幅值
    c=1.0
    def disturbance(self, t):
        return self.d*np.sin(t)

def sgn(x):
    return np.sign(x)
def sig(x,q):
    """python 中没有定义0**q,(q<0)，所以这里定义为0"""
    if x==0:
        return 0
    return np.abs(x)**q*sgn(x)

def sta(t, x, p):
    x1=x[0]
    dx1=x2=x[1]
    w=x[2]
    d=p.disturbance(t)

    s=p.c*x1+x2
    u0=-p.k1*sig(s,1/2)+w
    dw=-p.k2*sgn(s)
    dx2=u0-p.c*x2+d
    return np.array([dx1,dx2,dw]),{"s":s,"u0":u0,"d":d}
@dataclasses.dataclass
class Sol:
    t:np.ndarray
    y:np.ndarray
    signals:list
def rk4(func,tspan,x0,args,h=0.01):
    t=np.arange(tspan[0],tspan[1],h)
    x=np.zeros((len(x0),len(t)))
    x[:,0]=x0
    signals=[]
    for i,ti in enumerate(t):
        k1,s=func(ti,x[:,i],*args)
        signals.append(s)
        k2,_=func(ti+h/2,x[:,i]+h*k1/2,*args)
        k3,_=func(ti+h/2,x[:,i]+h*k2/2,*args)
        k4,_=func(ti+h,x[:,i]+h*k3,*args)
        if i==len(t)-1:
            break
        x[:,i+1]=x[:,i]+h*(k1+2*k2+2*k3+k4)/6
    return Sol(t,x,signals)

def main_basic(outdir=None):
    for k1 in [0.17,0.18]:
        p=STAParams()
        p.k1=k1
        x0=np.array([1.5,-1.,0.])
        sol=rk4(sta, [0,50], x0, args=(p,),h=0.001)
        fig=plt.figure()
        axes=fig.subplots(2,1).flat
        axes[0].plot(sol.t, sol.y[0], label=f"x1")
        axes[0].plot(sol.t, sol.y[1], label=f"x2")
        axes[0].plot(sol.t, [s["s"] for s in sol.signals], label=f"s")

        axes[1].plot(sol.t, sol.y[2], label=f"w")
        axes[1].plot(sol.t, [s["d"] for s in sol.signals] , label=f"d(t)")
        for ax in axes:
            ax.legend()
            ax.grid()
        plt.tight_layout()
        if outdir is not None: 
            plt.savefig(outdir(f"sta_{p.k1}_{p.k2}.png"))


#%%
if __name__=="__main__":
    main_basic()
    plt.show()

# %%
