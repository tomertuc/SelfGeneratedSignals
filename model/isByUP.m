function [ ByUP ] = isByUP( n,SN,FN,A,RHO,N )
%ISBYUP Check if node infected by unpure delivery

    ByUP=0;

    for j=1:1:N
        if FN(j)==1 && SN(j)~=1 && A(n,j)==1 % firing, unpure or inactive, neighbor
            ByUP=ThrowDices(RHO);
            
            if ByUP==1
                break;
            end
        end
    end

end

