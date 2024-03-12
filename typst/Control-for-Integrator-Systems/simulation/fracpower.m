power=[-1/3,-1/2,-1,-2,-3];
x=linspace(-2,2,100);
figure(1);
for i=1:length(power)
    v=power(i);
    subplot(2,1,1);hold on;grid on;
    [t,x]=ode15s(@(t,x)(-frac(x,v)),[0 1],1);
    plot(t,x)
end



function dxdt=frac(x,v)
    if x==0
        dxdt=0;
    else
        dxdt=sign(x)*abs(x)^(v);
    end
end