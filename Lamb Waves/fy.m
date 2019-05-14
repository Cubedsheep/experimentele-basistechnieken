function f=fy(cp,fd)
global ct cl d  
if cp<ct
    f=4*sinh(qe(cp)*2*pi*fd)*cosh(pe(cp)*2*pi*fd)*pe(cp)*qe(cp)*(ct.^2).^2*cp.^2-sinh(pe(cp)*2*pi*fd)*cosh(qe(cp)*2*pi*fd)*(2*ct.^2-cp.^2).^2;
     
else if ct<cp<cl
        f=4*sin(qe(cp)*2*pi*fd)*cosh(pe(cp)*2*pi*fd)*pe(cp)*qe(cp)*(ct.^2).^2*cp.^2+sinh(pe(cp)*2*pi*fd)*cos(qe(cp)*2*pi*fd)*(cp.^2-2*ct.^2).^2;
    end 
end
 if cp>cl
    f=4*sin(qe(cp)*2*pi*fd)*cos(pe(cp)*2*pi*fd)*pe(cp)*qe(cp)*(ct.^2).^2*cp.^2+sin(pe(cp)*2*pi*fd)*cos(qe(cp)*2*pi*fd)*(cp.^2-2*ct.^2).^2;        
    
 end
         

function q=qe(cp)
global ct  
q=sqrt(abs(1/ct.^2-1/cp.^2));


function p=pe(cp)
global cl  
p=sqrt(abs(1/cl.^2-1/cp.^2));
