function [R Th Fi nv]=scancrosNout(A,array,d,n)

load(array)

nv=zeros(360,180);
R=zeros(360,180);
P43=zeros(360,180);
P21=zeros(360,180);
P41=zeros(360,180);
P42=zeros(360,180);
P23=zeros(360,180);
P13=zeros(360,180);

for direct=1:n:180
    P43=P43+max(A(direct:direct+n-1,1)).*sum(ind43(:,:,direct:direct+n-1),3);
    if max(A(direct:direct+n-1,1))>median(A(:,1))*d
       nv=nv+sum(ind43(:,:,direct:direct+n-1),3);
    end
    P21=P21+max(A(direct:direct+n-1,2)).*sum(ind21(:,:,direct:direct+n-1),3);
    if max(A(direct:direct+n-1,2))>median(A(:,2))*d
       nv=nv+sum(ind21(:,:,direct:direct+n-1),3);
    end
    P41=P41+max(A(direct:direct+n-1,3)).*sum(ind41(:,:,direct:direct+n-1),3);
    if max(A(direct:direct+n-1,3))>median(A(:,3))*d
       nv=nv+sum(ind41(:,:,direct:direct+n-1),3);
    end
    P42=P42+max(A(direct:direct+n-1,4)).*sum(ind42(:,:,direct:direct+n-1),3);
    if max(A(direct:direct+n-1,4))>median(A(:,4))*d
       nv=nv+sum(ind42(:,:,direct:direct+n-1),3);
    end
    P23=P23+max(A(direct:direct+n-1,5)).*sum(ind23(:,:,direct:direct+n-1),3);
    if max(A(direct:direct+n-1,5))>median(A(:,5))*d
       nv=nv+sum(ind23(:,:,direct:direct+n-1),3);
    end
    P13=P13+max(A(direct:direct+n-1,6)).*sum(ind13(:,:,direct:direct+n-1),3);
    if max(A(direct:direct+n-1,6))>median(A(:,6))*d
       nv=nv+sum(ind13(:,:,direct:direct+n-1),3);
    end

end
R=P43+P21+P41+P42+P23+P13;
Th=max(R,[],1);
Fi=max(R,[],2);
