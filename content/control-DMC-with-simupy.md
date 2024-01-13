+++
title = "Simulate Dynamic Matrix Control with Simupy"
date = 2021-12-28
[taxonomies]
tags = ["Control Theory"]
categories = ["控制仿真"]
+++

# Simulate Dynamic Matrix Control with Simupy

I wrote some [code][mycode] about the symulation of Dynamic Matirx Control with [simupy][simupy].

> SimuPy is a framework for simulating interconnected dynamical system models and
> provides an open source, python-based tool that can be used in model- and system- based design and simulation workflows.

DMC or Dynamic Matrix Control is a typical Model Predictive Control (MPC) method using the prediction of future steps to control the system.
It usually applies in process control for its requirement for matrix operation in controller.

## Design Controller

Use the $N$ steps of Finite Step Response(FSR) from the given process $G_p$,
we can prodict the response in future $P$ steps,
and apply the first $M$ step's result to the system.

Usually, $M\le P \le N$ and $M=1$.

```python
def ModelPredictiveControl(delta_t,N,P,M):

    T=np.arange(N)*delta_t
    (T,S)=control.step_response(Gp,T)
    Sf=np.zeros((P,M))
    for i in range(P):
        for j in range(M):
            if i+j>=min(M,P):
                Sf[i,j]=S[i+j-min(M,P)+1]

    Q=np.diagflat(np.ones((1,P)))
    R=np.zeros((M,M))

    a=(np.dot(np.dot(Sf.T,Q),Sf)+R)
    K=np.dot(np.linalg.inv(a),np.dot(Sf.T,Q))
    K1=K[0,:]


    h=0.5*np.ones(N)
    h[0]=1

    def MPC(t,input):
        global lastU,y0,lastT
        [y,r]=input
        yr=np.ones((P))*r
        if t==0:
            lastT=0
            lastU=0
            y0=np.zeros((N))
        elif t>=lastT and t<lastT+delta_t:
            lastT=lastT+delta_t
            d_hat=y-y0[0]
            y0=y0+h*d_hat
            y0[0:-1]=y0[1:]
            e=yr-y0[0:P]
            du=np.dot(K1,e.T)
            lastU=lastU+du
            y0=y0+S*du

        return np.array(lastU)
    return MPC
```

use the function returned as a callable in **simupy**. then we can connect this Block with others.

```python
controller=simupy.systems.SystemFromCallable(
        ModelPredictiveControl(delta_t,N,P,M),
        2,1)
```

## Simulate the result

By running the Code, we can know that
in this case, the more steps $P$ we predict,
the better performance we will get.

![](/images/DMC_simlation_with_simupy.png)

## References

- Siang Lim.February 2020.[Implementing Dynamic Matrix Control in Python](https://github.com/csianglim/DMC/blob/master/DMC.ipynb)
- Matlab.[Dynamic Matrix Control Tutorial](https://www.mathworks.com/matlabcentral/mlc-downloads/downloads/submissions/19479/versions/1/previews/html/dmctutorial.html)

[mycode]: https://github.com/xsro/university-learning-code/blob/develop/7预测控制/DynamicMatrixControl/Danamic-Matrix-Control.ipynb
[simupy]: https://simupy.readthedocs.io
