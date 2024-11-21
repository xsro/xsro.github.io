"""Python 3.12.4 on win32 (AMD64)
Implement of Proper discretization of homogeneous differentiators
see https://linkinghub.elsevier.com/retrieve/pii/S0005109814002180 for the discretization
@author: xsro@foxmail.com
"""

from dataclasses import dataclass
import numpy as np
import matplotlib.pyplot as plt
from functools import lru_cache


def sig(x,q):
    if abs(x)==0:
        return 0
    else:
        return np.sign(x)*abs(x)**q

@dataclass
class HDD:
    lambdas =[1.1,3.0,4.1,3]
    L=24.
    def phi(self, i):
        n=len(self.lambdas)-1
        L=self.L
        def phi_i(e0):
            return -self.lambdas[n-i]*L**((i+1)/(n+1)) *sig(e0,(n-i)/(n+1))
        return phi_i

def euler1(t,x0,d:HDD,f):
    """equation 8 one-step euler method to (7)"""
    n=len(x0)-1
    x=np.zeros((len(x0),len(t)))
    x[:,0]=x0
    for it,ti in enumerate(t):
        if it==len(t)-1:
            break
        h=t[it+1]-t[it]
        e0=x[0,it]-f[it]
        for i in range(n):
            x[i,it+1]=x[i,it]+h*(d.phi(i)(e0)+x[i+1,it])
        x[n,it+1]=x[-1,it]+h*(d.phi(n)(e0))
    return x

@lru_cache(maxsize=None)
def fractional(n):
    if n==0:
        return 1
    else:
        return n*fractional(n-1)

def proper(t,x0,d:HDD,f):
    """equation 13 proper discretization of homogeneous SM-based differentiator"""
    n=len(x0)-1
    x=np.zeros((len(x0),len(t)))
    x[:,0]=x0
    for it,ti in enumerate(t):
        if it==len(t)-1:
            break
        h=t[it+1]-t[it]
        e0=x[0,it]-f[it]
        for i in range(n):
            x[i,it+1]=x[i,it]+h*(d.phi(i)(e0))
            for j in range(1,n-i+1):
                x[i,it+1]+=h**j/fractional(j)*x[j+i,it]
        x[n,it+1]=x[-1,it]+h*(d.phi(n)(e0))
    return x

def produce_f(t):
    f=t**4-5*t**2+2*t
    fd1=4*t**3-10*t+2
    fd2=12*t**2-10
    fd3=24*t
    fs=[f,fd1,fd2,fd3]
    return fs

#%% Figure 2
if __name__=="__main__":
    d=HDD()
    t=np.arange(0,50,0.001)
    x0=np.array([0.0,0.0,0.0,0.0])
    fs=produce_f(t)
    xdata=[solver(t,x0,d,fs[0]) for solver in [euler1,proper]]
    # reproduce Figure 2
    fig=plt.figure()
    axes=fig.subplots(2,2).reshape((4,))
    for i,x in enumerate(xdata):
        for j in range(len(x0)):
            axes[j].plot(t,(x[j,:]-fs[j]))
    for i,ax in enumerate(axes):
        ax.set_xlabel("time")
        ax.set_ylabel(f"$z_{i}-f_0^{{({i})}}$")
        ax.legend(["Euler","Proper"])
    plt.tight_layout()
    # reproduce Figure 3
    fig=plt.figure()
    x=xdata[1]
    for j in range(len(x0)):
        ax1=fig.add_subplot(4,1,j+1)
        plt.plot(t,np.abs(x[j,:]-fs[j]))
    plt.show()
# %% 
if __name__=="__main__":
    tsteps=[0.1,0.05,0.01,0.002,0.001]
    fig=plt.figure()
    axes=fig.subplots(2,2)
    for h in tsteps:
        t=np.arange(0,50,h)
        fs=produce_f(t)
        x0=np.array([0.0,0.0,0.0,0.0])
        xdata=[solver(t,x0,d,fs[0]) for solver in [euler1,proper]]
        
        for i,x in enumerate(xdata):
            axes[i,0].plot(t,(x[0,:]-fs[0]),label=f"h={h}")
            axes[i,1].plot(t,np.abs(x[0,:]-fs[0]),label=f"h={h}")
    solvers=["Euler","Proper"]
    for i,ax in enumerate(axes[:,0]):
        ax.set_xlabel("time")
        ax.set_ylabel(f"$z_{0}-f_0$ {solvers[i]}")
    for i,ax in enumerate(axes[:,1]):
        ax.set_xlabel("time")
        ax.set_ylabel(f"$|z_{0}-f_0|$ {solvers[i]}")
        # ax.set_yscale("log")
        ax.set_xlim(10,20)
        ax.set_yscale("log")
    fig.legend(ax.lines, [f"{h}" for h in tsteps], loc='lower center',ncol=5)
    plt.tight_layout()
# %%
