function [ ] = AddEntriesToTimeAllDecreaseFile( TimeAllDecreaseTable,K_ad,B_ad,A_ad,P_ad,ad_i )
%ADDENTRIESTOTIMEALLDECREASEFILE Summary of this function goes here
%   Detailed explanation goes here

data_folder_path=".\data\";
Q_ONLY_DECREASING_TIME=sprintf("%sQ_ONLY_DECREASING_TIME.csv", data_folder_path);

T=table(K_ad(1:ad_i),B_ad(1:ad_i),A_ad(1:ad_i),P_ad(1:ad_i),TimeAllDecreaseTable(1:ad_i));
T.Properties.VariableNames={'K','Betha','Alpha','P','IsQOnlyDecreasing'};

writetable(T,Q_ONLY_DECREASING_TIME);

end

