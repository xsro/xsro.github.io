#pagebreak(weak: true)
= Mechanics 机械

== Underactuator system 欠驱动系统

- Russ Tedrake. Underactuated Robotics: Algorithms for Walking, Running,Swimming, Flying, and Manipulation (Course Notes for MIT 6.832). Downloaded from http://underactuated.mit.edu/


According to Newton,
the dynamics of mechanical systems are second order($F=m a$).
Their state is geiven by a vector of positions,
$bold(q)$ (also known as the configuration vector),
and a vector of velocities, $dot(bold(q))$,
and (possibly) time.
The general form for a second-order control dynamical systems is 
$
dot.double(bold(q))=f(bold(q),dot(bold(q)),bold(u),t)
$
where $bold(u)$ is the control vector.

The second-order control differential equation 
$dot.double(bold(q))=f(bold(q),dot(bold(q)),bold(u),t)$
is *fully actuate* in state $bold(x)=(bold(q),dot(bold(q)))$ and time $t$ if the resulting map $f$ is surjective(满射):
for every $dot.double(bold(q))$ there exists a $bold(u)$ which produces the desired response.
Otherwise it is *underactuated*(in $bold(x)$ at time t)

== Homonomic Systems and Nonholonomic Systems 完整约束与非完整约束系统

- https://www.zhihu.com/question/26411115
- https://physics.stackexchange.com/questions/409951/what-are-holonomic-and-non-holonomic-constraints

Consider a mechanical system with $n$ generalized coordinates $q$ subject to $m$ bilateral(双边的) constraints whose equations of motion are described by 
$
M(q) dot.double(q) + V(q,dot(q))=E(q) tau - A^T(q) lambda
$
where $M(q)$ is the $n times n$ inertia matrix,
$V(q,dot(q))$ is the vector of position and velocity dependent forces,
$E(q)$ is the $n times r$ input transformation matrix,
$tau$ is the $r$-dimensional inpyt vector, $Q(q)$ is the $m times n$ Jacobian matrix,
and $lambda$ is the vector of constraint forces.
The $m$ constraint equations of the mechanical system can be written in the form 
$
C(q,dot(q))=0
$
If a constraint equation is in the form $C_i(q)=0$, or can be integrated into this form, 
it is a holonomic constraint.
Otherwise it is a kinematix(not geometric) constaint and is termed *nonholonomic*.

“完整”和“非完整”是分析力学的重要概念。
完整约束就是指可以表示为以广义坐标和时间为变参数的代数方程式的约束，否则就是非完整约束。