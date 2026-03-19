import numpy as np
from scipy.integrate import solve_ivp
import matplotlib.pyplot as plt

# --------------------------
# 1. 系统与参数定义
# --------------------------
class PrescribedTimeSystem:
    def __init__(self, T: float, b_func, f_func, psi_func, mu_func, mu_dot_func):
        """
        初始化预设时间稳定控制系统
        :param T: 预设稳定时间 (prescribed time)
        :param b_func: 控制系数函数 b(x,t)
        :param f_func: 扰动函数 f(x,t)
        :param psi_func: 已知上界函数 ψ(x)
        :param mu_func: 状态缩放函数 μ(t) (满足 μ(0)=1, μ(T)=0)
        :param mu_dot_func: μ(t) 的导数 dμ/dt
        """
        self.T = T
        self.b_func = b_func
        self.f_func = f_func
        self.psi_func = psi_func
        self.mu_func = mu_func
        self.mu_dot_func = mu_dot_func
        
        # 控制增益 (论文中 k>0, θ>0)
        self.k = 2.0
        self.theta = 1.0

    def control_law(self, x: float, t: float) -> float:
        """
        论文公式 (10) 控制律
        u = -k(μx) - θ(μx) * (ψ + |μ̇ μ⁻²(μx)|)²
        这里简化为常数 k, θ (若要自适应可扩展为自适应律)
        """
        mu = self.mu_func(t)
        mu_dot = self.mu_dot_func(t)
        z = mu * x  # 缩放状态 z = μ(t)x(t)
        
        psi = self.psi_func(x)
        # 计算 |μ̇ μ⁻² (μx)| = |μ̇ μ⁻¹ x| = |(μ̇/μ) x|
        term_mu = np.abs(mu_dot / mu * x)
        # 控制律
        u = -self.k * z - self.theta * z * (psi + term_mu) ** 2
        return u

    def system_dynamics(self, t: float, x: float) -> float:
        """
        系统闭环动力学 (9): ẋ = b(x,t)u + f(x,t)
        """
        u = self.control_law(x, t)
        b = self.b_func(x, t)
        f = self.f_func(x, t)
        dxdt = b * u + f
        return dxdt

# --------------------------
# 2. 示例函数定义 (可替换为你的实际函数)
# --------------------------
def example_b(x: float, t: float) -> float:
    """
    示例控制系数 b(x,t): 未知下界 b̲>0, 远离0
    这里取 b(x,t) = 1 + 0.2*sin(t) (满足 b>0.8>0)
    """
    return 1.0 + 0.2 * np.sin(t)

def example_f(x: float, t: float) -> float:
    """
    示例扰动 f(x,t): 满足 |f(x,t)| ≤ d(t)ψ(x)
    d(t) 是有界未知扰动, 这里取 d(t)=0.5*cos(t), ψ(x)=|x|
    """
    d_t = 0.5 * np.cos(t)  # 有界未知扰动
    psi = np.abs(x)
    return d_t * psi  # 满足 |f| ≤ |d(t)|ψ(x)

def example_psi(x: float) -> float:
    """
    已知可计算函数 ψ(x) (Assumption 1)
    这里取 ψ(x) = |x| (Lipschitz 型上界)
    """
    return np.abs(x)

def example_mu(t: float, T: float) -> float:
    """
    状态缩放函数 μ(t): 满足 μ(0)=1, μ(T)=0, 光滑单调递减
    常用多项式形式: μ(t) = (1 - t/T)^p (p>1 保证光滑)
    这里取 p=2: μ(t) = (1 - t/T)²
    """
    return (1 - t / T) ** 2

def example_mu_dot(t: float, T: float) -> float:
    """μ(t) 的导数 dμ/dt"""
    return -2 * (1 - t / T) / T

# --------------------------
# 3. 仿真主程序
# --------------------------
if __name__ == "__main__":
    # 预设稳定时间
    T = 5.0
    
    # 封装缩放函数 (固定 T)
    mu_func = lambda t: example_mu(t, T)
    mu_dot_func = lambda t: example_mu_dot(t, T)
    
    # 初始化系统
    system = PrescribedTimeSystem(
        T=T,
        b_func=example_b,
        f_func=example_f,
        psi_func=example_psi,
        mu_func=mu_func,
        mu_dot_func=mu_dot_func
    )
    
    # 初始状态
    x0 = 1.0
    # 仿真时间区间 [0, T]
    t_span = (0.0, T)
    t_eval = np.linspace(0.0, T, 500)  # 采样点
    
    # 求解 ODE
    sol = solve_ivp(
        fun=system.system_dynamics,
        t_span=t_span,
        y0=[x0],
        t_eval=t_eval,
        method='RK45'
    )
    
    # 提取结果
    t = sol.t
    x = sol.y[0]
    u = np.array([system.control_law(xi, ti) for xi, ti in zip(x, t)])
    mu = np.array([mu_func(ti) for ti in t])
    z = mu * x  # 缩放状态 z=μx
    
    # --------------------------
    # 4. 结果可视化
    # --------------------------
    plt.figure(figsize=(12, 8))
    
    plt.subplot(2, 2, 1)
    plt.plot(t, x, label='x(t)')
    plt.axvline(x=T, color='r', linestyle='--', label='Prescribed Time T')
    plt.xlabel('Time t')
    plt.ylabel('State x(t)')
    plt.title('State Evolution')
    plt.legend()
    plt.grid(True)
    
    plt.subplot(2, 2, 2)
    plt.plot(t, z, label='z(t)=μ(t)x(t)')
    plt.axvline(x=T, color='r', linestyle='--')
    plt.xlabel('Time t')
    plt.ylabel('Scaled State z(t)')
    plt.title('Scaled State Evolution')
    plt.legend()
    plt.grid(True)
    
    plt.subplot(2, 2, 3)
    plt.plot(t, u, label='u(t)')
    plt.axvline(x=T, color='r', linestyle='--')
    plt.xlabel('Time t')
    plt.ylabel('Control Input u(t)')
    plt.title('Control Input Evolution')
    plt.legend()
    plt.grid(True)
    
    plt.subplot(2, 2, 4)
    plt.plot(t, mu, label='μ(t)')
    plt.axvline(x=T, color='r', linestyle='--')
    plt.xlabel('Time t')
    plt.ylabel('Scaling Function μ(t)')
    plt.title('Scaling Function Evolution')
    plt.legend()
    plt.grid(True)
    
    plt.tight_layout()
    plt.show()