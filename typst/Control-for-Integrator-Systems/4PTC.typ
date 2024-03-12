= Prescribed Time Stabiliztion of Single Integrator Systems by Time-varying Gain

Generally prescribed/preassigned/pre-appointed time stability is 
reached by time-varying gain (time-varying scaling function, time-base generator).
Following table gives the basic example, we see that
the solution for the first case is the same as $dot(x)=-"sign"(x)$.
@songPrescribedtimeControlIts2023 .

The system is:
$
dot(x)=-mu(t) x
,
mu(t)=cases(
  k_1/(T-t)^h quad 0<t<T,
  0 quad t>=T),
$ with $T> 1$ to be prescribed and $k_1>0,k_2>0,h=1$.\
The analytical solution with $h=1$ can be found easily as:
$
x(t)=x(0)((T- t)/T)^k_1, t in [0,T) \
x(t)=0, t in [T,infinity)
$.

#import "homogenetity/timevaryinggain.typ": main_tvg,main_tvg2
#main_tvg
#pagebreak()

= Discussion: Time-varying Gain with different power

The analytical solution with $h!=1$ can be found easily as:
$
x(t)=x(0)exp(-k_1/(-h+1)(T^(-h+1)-(T-t)^(-h+1)))\
x(t)=x(0)exp(-k_1/(-h+1) T^(-h+1)), t in [T,infinity)
$.
These system can be nearly stable but we can always observe some error.
#main_tvg2
#pagebreak()