function [ PureLevel ] = CalcPureLevel ( State )
%CALCPURELEVEL Summary of this function goes here
%   Detailed explanation goes here

PURE_INFORMED=length(find(State==1));
UNPURE_INFORMED=length(find(State==2));
PureLevel=100*PURE_INFORMED/(PURE_INFORMED+UNPURE_INFORMED);

end

