K=[ -1.986 5.24 5.984;
    0.00204 -0.33 2.38;
    0.374 -11.3 -9.811];

T=[ 66.67 400 14.29;
    7.14 2.38 1.43;
    22.22 21.74 11.36];

L=[ 0.71 60 2.24;
    0.59 0.68 0.42;
    7.75 3.79 1.59];

O=[ 1 1 1;
    2 2 2;
    1 2 1];

KNorm=K./(T+L);

RGA=K.*transpose(inv(K))
p_gii=1;
for i=1:3
    p_gii=K(i,i)*p_gii;
end
NI=double(det(K)/p_gii)

RNGA=KNorm.*transpose(inv(KNorm))

RART=RNGA./RGA

%%%%% pairing
[K(3,:),K(2,:)]=deal(K(2,:),K(3,:));
[T(3,:),T(2,:)]=deal(T(2,:),T(3,:));
[L(3,:),L(2,:)]=deal(L(2,:),L(3,:));
[O(3,:),O(2,:)]=deal(O(2,:),O(3,:));

Zeta=[1 1 1;
      1 1 1;
      1 1 1];
  
wn=1./T;

KNorm=K./(T+L);

RGA=K.*transpose(inv(K))
p_gii=1;
for i=1:3
    p_gii=K(i,i)*p_gii;
end
NI=double(det(K)/p_gii)

RNGA=KNorm.*transpose(inv(KNorm))

RART=RNGA./RGA


