function [  ] = AddEntriesToPureFile( PureTable,K_pure,B_pure,A_pure,P_pure,Q_pure,pure_i )
%ADDENTRIESTOPUREFILE Summary of this function goes here
%   Detailed explanation goes here

data_folder_path=".\data\";
PURE_VALUES=sprintf("%sPURE_PERCENTS.csv", data_folder_path);

T=table(K_pure(1:pure_i),B_pure(1:pure_i),A_pure(1:pure_i),P_pure(1:pure_i),Q_pure(1:pure_i),PureTable(1:pure_i));
T.Properties.VariableNames={'K','Betha','Alpha','P','Q','PurePercent'};
writetable(T,PURE_VALUES);

end

