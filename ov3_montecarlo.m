% montecarlo simulering av maksimal relativ feil:

%max(fvec) og min(fvec) er):
nrand = 1e4;
%c=343;
% uniformt fordelte verdier mellom 0.99 og 1.01 
tauvec = (1 + 2*0.01*( rand(nrand,1) - 0.5 ));
dvec=(1 + 2*0.02*( rand(nrand,1) - 0.5 ));

f=(tauvec)./dvec;
%find variance:
vartau=var(tauvec);
vard=var(dvec);
varf=var(f);

exd=mean(dvec);
extau=mean(tauvec);
exf=mean(f);

disp(['var of the tau-values = ',num2str(vartau),' and var of the d value is ',num2str(vard)])
disp(['var of the f-values = ',num2str(varf)] )

%realative error:
stdd=sqrt(vard);
stdtau=sqrt(vartau);
stdf=sqrt(varf);

disp(['Std.deviation  of the tau-values = ',num2str(stdtau),' and std.deviation   of the d value is ',num2str(stdd)])
disp(['std.deviation  of the f-values = ',num2str(stdf)])

max_error_f=max(max(f)-1,1-min(f));

disp(['The maximum rel. error for f is =',num2str(max_error_f)]);
delta=[];
count=1;
for n=1:length(f)
    if f(n)>1
        delta(count)=acos(f(n));
        count=count+1;
        
    end
    
end
%f vil være en verdi 1+-0.03, dermed vil delta være en verdi
max_error_delta=max(imag(max(delta)),imag(min(delta)));

disp(['The maximum rel. error for delta is =',num2str(max_error_delta)]);



