%Asymmetric mode Lamb wave
clear;
global ct cl d
ct=3.18;%km/s   velocity of transverse wave,
cl=5.79;%km/s   velocity of longitudinal wave,
CP=20;%km/s, the maximum cp we want to search
dev=0.0001;
d=0.001;%thickness of the plate,(m)
k=1;
j=1;
for f=0.1:0.1:10 % f is frequency,(MHz)
    w=f;
    S(k,1)=f;
    x1=0.5;
    x2=x1+0.01;
    while x1<CP
        fy1=fy(x1,w);
        fy2=fy(x2,w);
        if sign(fy1)~=sign(fy2)
            while (x2-x1)>dev
                x3=(x1+x2)/2;
                fy1=fy(x1,w);
                fy3=fy(x3,w);
                if sign(fy1)~=sign(fy3)
                    x2=x3;
                else
                    x1=x3;
                end
            end
            data=(x1+x2)/2;
            j=j+1;
            S(k,j)=data;
            figure(1)
            plot(f,data,'.');hold on
        else
        end
        x1=x2;
        x2=x1+0.01;
    end    
    k=k+1;
    j=1;
end
%Remove the zero point
[m,n]=size(S);
for i=1:m
    for j=1:n
        if S(i,j)==0
            S(i,j)=NaN;
        else
        end
    end
end
figure(1)
plot(S(:,1),S(:,2:end),['r','.'])

