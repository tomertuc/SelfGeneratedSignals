function [ TimeAllDecreaseTable,K_ad,B_ad,A_ad,P_ad,ad_i ] = UpdateTimeAllDecrease( TimeAllDecreaseTable,ad_i,ModelSetupTable,Qs,ai,pi,K_ad,B_ad,A_ad,P_ad,K,B,ALPHA,P)
%UPDATETIMEALLDECREASE Summary of this function goes here
%   Detailed explanation goes here

ad_i=ad_i+1;
K_ad(ad_i)=K;
B_ad(ad_i)=B;
A_ad(ad_i)=ALPHA;
P_ad(ad_i)=P;
TimeAllDecreaseTable(ad_i)=1;

qi1=0;
for Q1=Qs
    qi1=qi1+1;
    qi2=0;
    for Q2=Qs
        qi2=qi2+1;
        if Q2>Q1
            TQ1=ModelSetupTable(ai,pi,qi1,1);
            TQ2=ModelSetupTable(ai,pi,qi2,1);
			if (ALPHA==0 && Q1 == 0)
				continue;
			end
			if (ALPHA==0 && Q2 == 0)
				continue;
			end
            if TQ2-TQ1>1
                TimeAllDecreaseTable(ad_i)=0;
                return;
            end
        end
    end
end

end

