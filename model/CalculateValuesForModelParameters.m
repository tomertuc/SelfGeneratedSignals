function [ IterationsUntilNow, TimeToComplete, Pure ] = CalculateValuesForModelParameters( Betha,K,ALPHA,P,Q,SIMS_NO,A,N,IterationsUntilNow,TOTAL_ITERATIONS,data_folder_path )
%CALCULATEVALUESFORMODELPARAMETERS Summary of this function goes here
%   Detailed explanation goes here

fprintf('Calculate values for - Betha=%.6f, K=%.6f, Alpha=%.6f, P=%.6f, Q=%.6f\n', Betha, K, ALPHA, P, Q);

write_path = sprintf("%s/simulations/", data_folder_path);

% write location of data to file
Time_PATH=sprintf("%sB%.6f-K%.6f-Q%.6f-P%.6f-A%.6f-Time.csv", write_path, Betha, K, Q, P, ALPHA);
Pure_PATH=sprintf("%sB%.6f-K%.6f-Q%.6f-P%.6f-A%.6f-Pure.csv", write_path, Betha, K, Q, P, ALPHA);

calc=0;

if exist(Time_PATH,'file') ~= 0
    TimeToComplete=transpose(csvread(Time_PATH));
    if(size(TimeToComplete,1) ~= SIMS_NO || size(TimeToComplete,2) ~= 1)
        calc=1;
    end
else
    calc=1;
end

if calc==0
    if exist(Pure_PATH,'file') ~= 0
        Pure=transpose(csvread(Pure_PATH));
        if(size(Pure,1) ~= SIMS_NO || size(Pure,2) ~= 1)
            calc=1;
        end
    else
        calc=1;
    end
end

if calc==0
    IterationsUntilNow = IterationsUntilNow + SIMS_NO;
    CalcTimeEst( IterationsUntilNow, TOTAL_ITERATIONS );
end

if calc==1
    % starting simulations
    TimeToComplete = zeros(SIMS_NO,1);
    Pure = zeros(SIMS_NO,1);
    
    % RHO calculation (trust factor)
    if (P==0 && Q==0)
        RHO=0;
    else
        RHO=P/(P+Q);
    end

    for s=1:1:SIMS_NO % simulation
        fprintf('Betha=%.6f, K=%.6f, Alpha=%.6f, P=%.6f, Q=%.6f: simulation %d of %d\n', Betha, K, ALPHA, P, Q, s, SIMS_NO);

        State=zeros(1,N);
        i=0;
        while(length(find(State)) < 0.95 * N) % iteration
            i=i+1;
            Transmit=CalcTransmitByState(State,P,Q,N);
            [State]=GetNextState(State,Transmit,A,RHO,ALPHA,N);
        end
        TimeToComplete(s) = i;
        Pure(s) = CalcPureLevel(State);

        IterationsUntilNow = IterationsUntilNow + 1;
        CalcTimeEst( IterationsUntilNow, TOTAL_ITERATIONS );
    end

    % write data to file
    csvwrite(Time_PATH,transpose(TimeToComplete));
    csvwrite(Pure_PATH,transpose(Pure));

end

end

