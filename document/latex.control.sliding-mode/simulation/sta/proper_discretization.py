"""
Python 3.12.4 on win32 (AMD64)
Implement of Super Twisting Sliding Mode Algorithm (STA) with Proper discretization of homogeneous differentiators
see https://linkinghub.elsevier.com/retrieve/pii/S0005109814002180 for the discretization
@author: xsro@foxmail.com
"""
import numpy as np
import matplotlib.pyplot as plt
import dataclasses

@dataclasses.dataclass
class STAParams:
    k1=1e-3
    k2=1.1
    dw=0.1
    def domega(self, t):
        return self.dw*np.sin(t)

def sgn(x):
    return np.sign(x)
def sig(x,q):
    if x==0:
        return 0
    return np.abs(x)**q*sgn(x)

def sta(t, x, p):
    x1=x[0]
    x2=x[1]
    dx1=-p.k1*sig(x1,1/2)+x2
    dx2=-p.k2*sgn(x1)
    return np.array([dx1,dx2])
@dataclasses.dataclass
class Sol:
    t:np.ndarray
    y:np.ndarray
def rk4(func,tspan,x0,args,h=0.01):
    t=np.arange(tspan[0],tspan[1],h)
    x=np.zeros((len(x0),len(t)))
    x[:,0]=x0
    for i,ti in enumerate(t):
        k1=func(ti,x[:,i],*args)
        k2=func(ti+h/2,x[:,i]+h*k1/2,*args)
        k3=func(ti+h/2,x[:,i]+h*k2/2,*args)
        k4=func(ti+h,x[:,i]+h*k3,*args)
        if i==len(t)-1:
            break
        x[:,i+1]=x[:,i]+h*(k1+2*k2+2*k3+k4)/6
    return Sol(t,x)

def outdir(filename):
    import os
    folder=os.path.join(os.path.dirname(__file__),"out")
    if not os.path.exists(folder):
        os.makedirs(folder)
    outpath=os.path.join(folder,filename)
    return outpath


def main_proper_discretization(outdir=None):
#%%
    p=STAParams()
    x0=np.array([1.,0.])
#%% simulate with different steps
    steps=[0.1,0.01,0.001]
    sols=[rk4(sta, [0,2000], x0, args=(p,),h=step) for step in steps]

#%%
    fig=plt.figure()
    for i,sol in enumerate(sols):
        ax=fig.add_subplot(len(sols),1,i+1)
        ax.plot(sol.t, sol.y[0], label=f"step={steps[i]}")
        plt.legend()
        plt.grid()
    plt.tight_layout()
    if outdir is not None:
        plt.savefig(outdir("step.pdf"))

if __name__=="__main__":
    main_proper_discretization()
    plt.show()