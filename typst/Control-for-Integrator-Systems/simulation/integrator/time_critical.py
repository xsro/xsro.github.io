import numpy as np
import matplotlib.pyplot as plt
import cbor2
from typing import Dict

def finite_time_controller(t, x, params):
    """
    有限时间控制器（统一格式：(t, x, params)）
    参数:
        t: 当前时间
        x: 当前状态（标量）
        params: 参数字典，需包含 'k'
    返回:
        u: 控制输入
    """
    # 从参数字典提取参数，设置默认值防止KeyError
    k = params.get('k', 1.0)
    u = -k * np.sign(x) if x != 0 else 0
    return u


def fixed_time_params(params):
    # 从参数字典提取参数，设置默认值
    k1 = params.get('k1', 1.0)
    k2 = params.get('k2', 1.0)
    alpha = params.get('alpha', 0.5)
    beta = params.get('beta', 2.0)
    return k1,k2,alpha,beta
    

def fixed_time_controller(t, x, params):
    """
    Fixed-time 控制器（统一格式：(t, x, params)）
    参数:
        t: 当前时间
        x: 当前状态（标量）
        params: 参数字典，需包含 'k1', 'k2', 'alpha', 'beta'
    返回:
        u: 控制输入
    """
    k1,k2,alpha,beta=fixed_time_params(params)
    
    # 处理符号问题：sign(x)*|x|^gamma 替代 x^gamma（避免负数开方）
    sign_x = np.sign(x) if x != 0 else 0
    u = -k1 * sign_x * np.abs(x)**alpha - k2 * sign_x * np.abs(x)**beta
    return u

def compute_fixed_Tmax(params):
    # ===================== 计算并标注收敛时间上界 =====================
    # 代入公式 T_max = 2^((1-α)/2)/(k1*(1-α)) + 2^((β-1)/2)/(k2*(β-1))
    k1,k2,alpha,beta=fixed_time_params(params)
    T_max = (2**((1-alpha)/2))/(k1*(1-alpha)) + (2**((beta-1)/2))/(k2*(beta-1))
    return T_max


def prescribed_time_controller(t, x, params):
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
    return u

def simulate_system(controller:callable,params:Dict,x0, t_max=5, dt=0.01,):
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
    
    # 欧拉法更新状态
    for i in range(1, len(t_list)):
        u = controller(t_list[i-1],x_list[i-1], params)
        x_list[i] = x_list[i-1] + u * dt
    
    return t_list, x_list

# ===================== 仿真参数设置 =====================
profiles=[
    ("finite",finite_time_controller,dict(k=3)),
    ("fixed",fixed_time_controller,dict(k1 = 1.0,k2 = 1.0,alpha = 0.5,beta = 2.0)),
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

    if title=="fixed":
        T_max=compute_fixed_Tmax(params)
        plt.axvline(x=T_max, color='k', linestyle='--', linewidth=1, label=f'$T_{{max}} = {T_max:.2f}$ s')

    # ===================== 绘图美化 =====================
    plt.xlabel('Time (s)')
    plt.ylabel('State $x(t)$')
    plt.title(title+r' time Control of $\dot{x} = u$')
    plt.grid(True, alpha=0.3)
plt.tight_layout()  # 自动调整布局
plt.show()
