function fy=fx(cp,fd)
global ct cl  
if cp<=ct
    fy=sinh(qe(cp)*pi*2*fd)*cosh(pe(cp)*pi*2*fd)*(2*ct.^2-cp.^2).^2-4*sinh(pe(cp)*2*pi*fd)*cosh(qe(cp)*2*pi*fd)*pe(cp)*qe(cp)*((ct.^2).^2)*cp.^2;
else  if ct<cp<=cl
        fy=sin(qe(cp)*pi*2*fd)*cosh(pe(cp)*pi*2*fd)*(cp.^2-2*ct.^2).^2-4*sinh(pe(cp)*2*pi*fd)*cos(qe(cp)*2*pi*fd)*pe(cp)*qe(cp)*((ct.^2).^2)*cp.^2;
    end
end
if cp>cl 
        fy=sin(sqrt(abs(1/ct.^2-1/cp.^2))*2*pi*fd)*cos(sqrt(abs(1/cl.^2-1/cp.^2))*2*pi*fd)*(cp.^2-2*ct.^2).^2+4*sin(sqrt(abs(1/cl.^2-1/cp.^2))*2*pi*fd)*cos(sqrt(abs(1/ct.^2-1/cp.^2))*2*pi*fd)*sqrt(abs(1/cl.^2-1/cp.^2))*sqrt(abs(1/ct.^2-1/cp.^2))*((ct.^2).^2)*cp.^2;
end
    
      

function q=qe(cp)
global ct  
q=sqrt(abs(1/ct.^2-1/cp.^2));


function p=pe(cp)
global cl  
p=sqrt(abs(1/cl.^2-1/cp.^2));
