import numpy as np
import matplotlib.pyplot as plt
import cbor2
from typing import Dict
from scipy.integrate import solve_ivp
from functools import partial


def prescribed_time_controller(t, x, params=dict()):
    """
    预置时间控制器（统一格式：(t, x, params)）
    参数:
        t: 当前时间
        x: 当前状态（标量）
        params: 参数字典，需包含 'k', 'T', 'mu_bar'
    返回:
        u: 控制输入
    """
    # 从参数字典提取参数，设置默认值
    k = params.get('k', 1.0)
    T = params.get('T', 1.0)
    mu_bar = params.get('mu_bar', 100.0)
    
    if t < T:
        mu = 1 / (T - t)
        # 限制mu的幅值，防止数值爆炸
        if np.abs(mu) > mu_bar:
            mu = np.sign(mu) * mu_bar
        u = -k * mu * x
    else:
        u = 0.0
    return u + np.sin(t)

def simulate_system(controller:callable,params:Dict,x0, t_max=5, dt=0.1,):
    """
    仿真一阶系统 \\dot{x} = u
    参数:
        x0: 初始状态
        controller: 控制器
        params: 控制器参数
        t_max: 仿真时长
        dt: 时间步长
    返回:
        t_list: 时间序列
        x_list: 状态序列
    """
    t_list = np.arange(0, t_max, dt)
    x_list = np.zeros_like(t_list)
    x_list[0] = x0  # 初始状态
    
    sol=solve_ivp(partial(controller,params=params),[0,t_max],np.array([x0]),t_eval=t_list)
    
    return sol.t, sol.y[0]

# ===================== 仿真参数设置 =====================
profiles=[
    ("prescribed",prescribed_time_controller,dict(mubar=100,T=1,k=1))
]

t_max = 5
dt = 0.01
x0_list = [5, 10, -3]  # 测试不同初始状态
color_list = ['#1f77b4', '#ff7f0e', '#2ca02c']  # 专业配色

# ===================== 执行仿真 =====================
data = {"data":__file__}

for (title,controller,params) in profiles:
    for i, x0 in enumerate(x0_list):
        t, x = simulate_system(controller,params,x0, t_max, dt)
        if title not in data:
            data[title]=[]
        data[title].append({"t":t[::10].tolist(),"x":x[::10].tolist()})

with open("data/time_critical.cbor","wb") as f:
    # 数据序列化
    serialized = cbor2.dump(data,f)
    print(serialized) # 输出二进制数据


plt.figure()

for i,(title,controller,params) in enumerate(profiles):
    plt.subplot(3,1,i+1)

    for i, x0 in enumerate(x0_list):
        t=data[title][i]["t"]
        x=data[title][i]["x"]
        plt.plot(t,x)
    # ===================== 绘图美化 =====================
    plt.xlabel('Time (s)')
    plt.ylabel('State $x(t)$')
    plt.title(title+r' time Control of $\dot{x} = u$')
    plt.grid(True, alpha=0.3)
plt.tight_layout()  # 自动调整布局
plt.show()
