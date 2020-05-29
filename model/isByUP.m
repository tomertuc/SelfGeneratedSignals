function [ ByUP ] = isByUP( n,State,Transmit,A,RHO,N )
%ISBYUP Check if node activated by unpure signal

    ByUP=0;

    for j=1:1:N
        if Transmit(j)==1 && State(j)~=1 && A(n,j)==1 % transmitting, unpure or inactive, neighbor
            ByUP=ThrowDices(RHO);
            
            if ByUP==1
                break;
            end
        end
    end

end

