import numpy as np
import matplotlib.pyplot as plt

# ====================== 1. 定义核心参数（与论文PMSM实验一致） ======================
Tp = 0.35          # 预设收敛时间 (s)
lambda_ = 4e5      # 指数衰减系数
Ts = 0.221242      # 分段函数切换时间 (s)
hbar1 = 5.277897e-5 # 第二部分参数
hbar2 = 2.718335    # 第二部分参数

# ====================== 2. 定义Gamma函数（分段函数） ======================
def gamma_function(t):
    """
    计算时变标度函数Γ(t)
    :param t: 时间点/时间数组 (s)
    :return: 对应时间的Γ(t)值
    """
    gamma = np.zeros_like(t)
    # 分段1：t ∈ [0, Ts]，Γ(t) = Tp/(Tp - t)
    mask1 = (t >= 0) & (t <= Ts)
    gamma[mask1] = Tp / (Tp - t[mask1])
    
    # 分段2：t > Ts，Γ(t) = hbar2 - hbar1 * exp(-lambda*(t-Ts))
    mask2 = t > Ts
    gamma[mask2] = hbar2 - hbar1 * np.exp(-lambda_ * (t[mask2] - Ts))
    
    return gamma

# ====================== 3. 生成时间序列 & 计算Γ(t) ======================
t_start = 0          # 时间起始点
t_end = Tp + 0.05    # 时间终点（覆盖Tp后0.05s）
t_step = 0.001       # 时间步长（保证曲线平滑）
t = np.arange(t_start, t_end, t_step)
gamma_t = gamma_function(t)

# ====================== 4. 可视化设置（专业论文风格） ======================
plt.rcParams['font.sans-serif'] = ['SimHei', 'DejaVu Sans']  # 支持中文
plt.rcParams['axes.unicode_minus'] = False                  # 解决负号显示问题
plt.figure(figsize=(10, 6), dpi=100)

# 绘制Γ(t)曲线
plt.plot(t, gamma_t, color='#2E86AB', linewidth=2.5, label=r'$\Gamma(t)$')

# 标注关键时间点（Ts、Tp）
plt.axvline(x=Ts, color='#A23B72', linestyle='--', linewidth=1.5, label=f'切换时间 $T_s={Ts:.4f}$s')
plt.axvline(x=Tp, color='#F18F01', linestyle='--', linewidth=1.5, label=f'预设收敛时间 $T_p={Tp}$s')

# 设置坐标轴
plt.xlabel('时间 $t$ (s)', fontsize=12)
plt.ylabel(r'$\Gamma(t)$', fontsize=12)
plt.xlim(t_start, t_end)
plt.ylim(min(gamma_t)-0.1, max(gamma_t)+0.1)  # 自适应y轴范围

# 其他样式
plt.grid(True, alpha=0.3)
plt.legend(fontsize=10, loc='upper left')
plt.title('时变标度函数 $\Gamma(t)$ 曲线（PMSM伺服系统）', fontsize=14, pad=15)

# 显示/保存图片
plt.tight_layout()  # 自动调整布局
plt.show()
# plt.savefig('gamma_function_curve.png', dpi=300, bbox_inches='tight')  # 保存高清图