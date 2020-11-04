%clear all;
close all;
clc;
img1=imread('i1.tif');
img2=imread('i2.tif');
img3=imread('i3.tif');
X=zeros(614*1848,220);
for ci=1:1:220
    col=img1(:,:,ci);
    C=col(:);
    X(:,ci)=C;
end
CV=cov(X);
[V,D]=eigs(CV,220);
S=sum(sum(D));
S1=sum(D);
S2=0;
for ci=1:1:220
    S2=S2+S1(ci);
    p=100*(S2/S);
    if(p>99.99)
        break;
    end
end
disp('Required Bands:'),disp(ci);
disp('Information retained:'),disp(p);
P=V(:,1:ci);
N=X*P;
dp=sum(X(1,:).*X(2,:));
pp1=sqrt(sum(X(1,:).^2));
pp2=sqrt(sum(X(2,:).^2));
ap=acos(dp/(pp1*pp2));
dn=sum(N(1,:).*N(2,:));
np1=sqrt(sum(N(1,:).^2));
np2=sqrt(sum(N(2,:).^2));
an=acos(dn/(np1*np2));
disp('ANGLES:'),disp(rad2deg(ap)),disp(rad2deg(an));
a=linspace(1,220,220);
subplot(2,1,1);
plot(a,X(1,:));
b=linspace(1,111,111);
subplot(2,1,2);
plot(b,N(1,:));