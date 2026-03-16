#import "../lib/lib.typ":ode45,get_signal,op,sig
#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": plot, chart
  #import cetz.draw: *

= Homogeneity 

Homogeneous control laws appear as solutions to many control problems such as a minimum time feedback control for the chain of integrators or the high-order sliding mode design. The homogeneity allows some time constraints in control systems to be fulﬁlled by means of a proper selection of the so-called homogeneity degree. Similar to the linear case, an asymptotic stability of a homogeneous system implies its robustness (input-to-state stability) with respect to a certain class of parametric uncertainties and exogenous perturbations.

Many lliteratures like @polyakov_generalized_2020 
@马诺诺2010齐次性理论在非线性系统稳定性分析及控制设计中的应用 
@shtesselSlidingModeControl2014 talks about homogeneity.

*Corollary 6.1* The global uniform ﬁnite-time stability of homogeneous differential equations (Filippov inclusions) with negative homogeneity degree is *robust with respect to locally small homogeneous perturbations*. 

#pagebreak()

== Homogeneity of  coordinate, function and vector field

#columns(2)[
  Assign a weight(the *homogeneity degree*) of each coordinate $x_i in RR, i=1,dots,n$, where $m_i>0$. We will write 
  $
  "deg"(x_i)=m_i.
  $
  The corresponding simple linear transformation
  $
  d_k: (x_1,x_2,dots, x_n) arrow.r.bar (kappa^(m_1)x_1,kappa^(m_2)x_2,dots,kappa^(m_n)x_n)
  $
  is called *homogeneity dilation*, and $kappa>0$ is called its parameter.

  A *function* $f: RR^n arrow RR$ is called homogeneous of the degree
  (weight) $q in RR$ with the above homogeneity dilation and written as $"deg"(f)=q$,
  if for any $kappa>0$,
  the identity $f(d_k x)=kappa^q f(x)$ holds.

  A *vector field* $f: RR^n arrow RR^n$, $f=(f_1,dots,f_n)^T$,
  is called homogeneous of degree $q in RR$ with the above dilation and written as $"deg"(f)=q$,
  if all its componenets $f_i$ are homogeneous and the identities
  $
  "deg" f_i="deg" x_i + "deg" f ="deg" x_i +q, i=1,2,dots,n
  $
  #colbreak()
  Let $A$ and $B$ be two homogeneous functions of $x in RR^n$ different from identical zero, and let $lambda$ be a real number;
  then 
  1. The sum of A and B is a homogeneous function only if $"deg" A ="deg" B$
  2. $forall lambda != 0$, we have $"deg"lambda =0$
  3. $"deg" A B ="deg" A +"deg" B$
  4. $"deg" A/B="deg" A -"deg" B$
  5. $"deg" lambda A ="deg" A$
  6. $"deg" partial/(partial x_i) A  ="deg" A -"deg" x_i$ if $partial/(partial x_i) A$ is not identical zero
  To verify the last equality it can be seen that 
  $
  partial/(partial kappa^m_i x_i) A(d_k x)&=
  kappa^(-m_i) partial/(partial  x_i) kappa^("deg" A) A(x)\ 
  &=
  kappa^("deg" A -m_i) partial/(partial  x_i) A(x)
  $

  The last equality tells that for a systme $dot(x)=f(x)$, we have $dot(x)_i=f_i(x)$.
  Then,
  $
  "deg" dot(x)_i="deg" f_i="deg" x_i-"deg"t
  $
]
#pagebreak()

== Homogeneity of differential equations and inclusions
#columns(2)[
  Take the one dimension system $dot(x)=f(x)=x^2$ into cosideration,
  let $"deg" x=1$, then the homogeneity degree of *function* $f$ is $"deg" f=2$ and the homogeneity degree of *vector field* $f$ is 
  $"deg" f = "deg" f_i -"deg" x_i =1$.
  _The ambiguity disappears if we speak aout the homogeneity of the differential equation $dot(x)=f(x)$._


  We call differential equation $dot(bold(x))=f(bold(x))$ homogeneous with degree $q$, if the system is invariant with respect to the linear time-coorinate transformation
  $
  G_k:(t,bold(x)) arrow.bar (kappa^(-1)t,d_k x), kappa>0.
  $<Gk>
  Then we have 
  $
  f(x)=kappa^(-1) d_k^(-1) f(d_k x)
  $.
  The homogeneity degree of the system is 
  $"deg" t="deg" f_i-"deg" x_i="deg" bold(f)$
  .
  $
  f_i(d_k x)=kappa^("deg" f_i) f_i(x)=kappa^("deg" x_i+"deg" f) f_i(x)\
  bold(f)(d_k x)=d_k kappa^("deg" f) bold(f)(x)
  $

  *Note*: The nonzero homogeneity degree $q$ of  a vector field can always be scaled to $plus.minus 1 $ by an appropriate proportional change to the weights of the coordinates and time.

  *Definition 6.6* A vector-set field $F(x) subset RR^n, x in RR^n$, and the differential inclusion 
  $
  dot(x) in F(x)
  $
  are called homogeneous of the degree $q in RR$ with the dialtion, which is writen as $"deg" F=q$,
  if the DI is invariant with respect to the time-coordinate transformation @Gk
]


#pagebreak()

== Convergence Rates of Homogeneous Algorithms

#columns(2)[
  === Finite-Time and Fixed-Time Stabilization
  Consider simplest scalar first order system
  $
  dot(x)=u
  $
  - The classical approach fives the standard _linear_ proportional feedback
  $
  u_"linear"(x)=-x
  $
  which guarantees an asymptotic(exponential) convergence to the origin of any trajectory of the closed-loop system: $abs(x(t))=e^(-t)abs(x_0)$.
  - The *globally homogeneous* feedback is 
  $
  u_"FT"(x)=-sqrt(abs(x))"sgn"(x).
  $
  This algorithm stabilizes the system at the origin in a _finite time_:
  $
  x(t)=0, "for" t>= T(x_0)=2sqrt(abs(x_0))
  $
  - The _fixed-time_ stabilizing controller can be selected *locally homogeneous* in the  form:
  $
  u_"FxT"(x)=cases(
    -sig( x )^(1/2)quad& abs(x)<=1,
    -sig( x )^(3/2)quad& abs(x)>1,
  ). 
  $
  The system will be stabilized within 4 second, that is $x(t)=0,forall space t>=4 space forall x_0 in RR$

  #for x0 in (0.5,10){
    let rhs(t,x)={
    let k=1
    let dxfxt=-op.sig(x.xfxt,1/2)
    if calc.abs(x.xfxt)>1 {
      dxfxt=-op.sig(x.xfxt,3/2)
    }
    let dx=(
      xlinear:-k*x.xlinear,
      xft:-k*op.sig(x.xft,1/2),
      xfxt:k*dxfxt
    )
    dx
  }
    let (xout,dxout)=ode45(rhs,6,(xlinear:x0,xft:x0,xfxt:x0),0.005,record_step:0.02)
    cetz.canvas({
        plot.plot(
          size: (8,2),
          axis-style: "school-book", 
          x-tick-step: 1, y-tick-step:x0,
          {
            plot.add(get_signal(xout,"xlinear"),label:$dot(x)=u_"linear"$)
            plot.add(get_signal(xout,"xft"),label:$dot(x)=u_"FT"$)
            plot.add(get_signal(xout,"xfxt"),label:$dot(x)=u_"Fxt"$)
          },
          y-label:"value",
          x-label:"time",
          )
      })
  }

  // === Finite-Time and Fixed-Time Estimation

]
#pagebreak()

  === Robustness

  === Elimination of an Unbounded “Peaking” Effect

  #pagebreak()