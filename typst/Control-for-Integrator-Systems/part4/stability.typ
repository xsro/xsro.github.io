= Stability Definitions in Control Theory

// 稳定性定义列表（带编号+加粗标题）
#let a=[
  (
    name: "Asymptotic Stability",
    zh: "渐近稳定性",
    def: "A system is asymptotically stable if all trajectories starting near the equilibrium converge to it as time goes to infinity.",
    feature: "Converges to equilibrium, but the convergence time is infinite (no finite-time guarantee)."
  ),
  (
    name: "Exponential Stability",
    zh: "指数稳定性",
    def: "A system is exponentially stable if the equilibrium is asymptotically stable and the system state decays to zero at an exponential rate.",
    feature: "Faster convergence than asymptotic stability, but still requires infinite time (error decays exponentially)."
  ),
  (
    name: "Finite-time Stability",
    zh: "有限时间稳定性",
    def: "A system is finite-time stable if the system state reaches the equilibrium exactly at some finite settling time and remains there afterward.",
    feature: "Converges to zero in finite time, but the settling time depends on initial conditions."
  ),
  (
    name: "Fixed-time Stability",
    zh: "固定时间稳定性",
    def: "A system is fixed-time stable if it is finite-time stable and the settling time is bounded by a constant, independent of initial conditions.",
    feature: "Upgraded version of finite-time stability; settling time has an upper bound and is independent of initial values."
  ),
  (
    name: "Prescribed-time Stability",
    zh: "预置时间稳定性",
    def: "A system is prescribed-time stable if the settling time can be arbitrarily preassigned by the designer in advance, regardless of initial conditions.",
    feature: "Settling time can be manually specified in advance by the designer, independent of the system and initial values."
  )
]

#list(
  "Asymptotic / Exponential: Infinite-time convergence",
  "Finite-time: Finite convergence time (depends on initial conditions)",
  "Fixed-time: Finite convergence time (upper bounded, independent of initial conditions)",
  "Prescribed-time: Convergence time can be preassigned arbitrarily"
)

#pagebreak()