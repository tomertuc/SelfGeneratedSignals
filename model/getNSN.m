function [ SN,UTN ] = getNSN( SN,UTN,FN,A,RHO,ALPHA,N,Iter )
%GETNSN Calc next state of graph according to firing and state of graph

    NSN=SN;
    for n=1:1:N
        if (SN(n)==0)
            ByP=isByP(n,SN,FN,A,RHO,ALPHA,N);
            if ByP
                NSN(n)=1;
                UTN(n)=Iter;
            end
            ByUP=isByUP(n,SN,FN,A,RHO,N);
            if ByUP % dominant
                NSN(n)=2;
                UTN(n)=Iter;
            end
        end
    end
    
    SN=NSN;

end

