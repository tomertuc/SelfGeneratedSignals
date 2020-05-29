function [ Transmit ] = CalcTransmitByState( State,P,Q,N )
%CALCTRANSMITBYSTATE calculate transmission according to state
    Transmit=zeros(1,N);
    for n=1:1:N
        if (State(n) > 0)
            Transmit(n)=ThrowDices(P);
        else
            Transmit(n)=ThrowDices(Q);
        end
    end

end

