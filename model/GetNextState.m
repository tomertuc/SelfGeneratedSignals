function [ State ] = GetNextState( State,FN,A,RHO,ALPHA,N )
%GETNEXTSTATE Calc next state of graph according to transmission and state of graph

    % Possible states:
    % 0 - non-informed
    % 1 - pure informed
    % 2 - non-pure informed

    NewState=State;
    for n=1:1:N
        if (State(n)==0)
            ByP=isByP(n,State,FN,A,RHO,ALPHA,N);
            if ByP
                NewState(n)=1;
            end
            ByUP=isByUP(n,State,FN,A,RHO,N);
            if ByUP % dominant
                NewState(n)=2;
            end
        end
    end
    
    State=NewState;

end

