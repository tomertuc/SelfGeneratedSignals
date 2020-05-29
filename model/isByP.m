function [ ByP ] = isByP( n,State,Transmit,A,RHO,ALPHA,N )
%ISBYP Check if node activated by pure signal

    ByP = 0;

    for j=1:1:N
        if Transmit(j)==1 && State(j)==1 && A(n,j)==1 % transmissing, pure, neighbor
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

