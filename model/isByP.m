function [ ByP ] = isByP( n,SN,FN,A,RHO,ALPHA,N )
%ISBYP Check if node infected by pure delivery

    ByP = 0;

    for j=1:1:N
        if FN(j)==1 && SN(j)==1 && A(n,j)==1 % firing, pure, neighbor
            ByP=ThrowDices(RHO);
            
            if ByP==1
                break;
            end
        end
    end

    if ByP==0
        ByP=ThrowDices(ALPHA);
    end

end

