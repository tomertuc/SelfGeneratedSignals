function [ PureTable,K_pure,B_pure,A_pure,P_pure,Q_pure,pure_i ] = UpdatePureTable( PureTable,pure_i,ModelSetupTable,ai,pi,qi,K_pure,B_pure,A_pure,P_pure,Q_pure,K,B,ALPHA,P,Q )
%UPDATEPURETABLE Summary of this function goes here
%   Detailed explanation goes here

pure_i=pure_i+1;
K_pure(pure_i)=K;
B_pure(pure_i)=B;
A_pure(pure_i)=ALPHA;
P_pure(pure_i)=P;
Q_pure(pure_i)=Q;
PureTable(pure_i)=ModelSetupTable(ai,pi,qi,2);

end

