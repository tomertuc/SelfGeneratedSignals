function [ ModelSetupTimeAndPureTable, ModelSetupTime, ModelSetupPure ] = UpdateModelSetupTable( ns_i,ModelSetupTimeAndPureTable,ModelSetupTime,ModelSetupPure,TimeToComplete,Pure,ai,pi,qi )
%UPDATEMODELSETUPTABLE Summary of this function goes here
%   Detailed explanation goes here

ModelSetupTime(ns_i,1)=mean(TimeToComplete);
ModelSetupPure(ns_i,1)=mean(Pure);
ModelSetupTimeAndPureTable(ai,pi,qi,1)=ModelSetupTime(ns_i,1);
ModelSetupTimeAndPureTable(ai,pi,qi,2)=ModelSetupPure(ns_i,1);

end

