function [ FN ] = calcFNbySN( SN,P,Q,N )
%CALCFNBYSN calculate fire according to state
    FN=zeros(1,N);
    for n=1:1:N
        if (SN(n) > 0)
            FN(n)=ThrowDices(P);
        else
            FN(n)=ThrowDices(Q);
        end
    end

end

