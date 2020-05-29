%SYNTHETICNETWORKMAIN run analysis for Watts-Strogatz graphs
addpath('model');
addpath('handletables');
addpath('handlefiles');

data_folder_path=".\data\";

UPDATE_RATE = 10;

SIMS_NO=20;
N=500;

Ks=[3,5,8,10,15,20];
Bs=[0.5,0.8,1];

K_LENGTH=length(Ks);
B_LENGTH=length(Bs);

Ps=0.01:0.01:0.1; % size 11
As=0:0.005:0.1; % size 21

Q_P_HOP_RATIO=10;
Q_LENGTH=Q_P_HOP_RATIO+1;
P_LENGTH=length(Ps);
A_LENGTH=length(As);

% TimeAllDecreaseTable is a table containing the answers to the
% question - is there a turning point? If TimeAllDecreaseTable is false, then
% on the same k-b-a-p setup, there are two values q1 < q2 where
% the time to complete for q2 is higher, hence a turning point (suspicion
% becomes dominant)

% can't have a=0, p=0 (but p != 0)
TimeAllDecreaseTableLength=P_LENGTH*A_LENGTH*B_LENGTH*K_LENGTH;
K_ad=zeros(TimeAllDecreaseTableLength,1);
B_ad=zeros(TimeAllDecreaseTableLength,1);
A_ad=zeros(TimeAllDecreaseTableLength,1);
P_ad=zeros(TimeAllDecreaseTableLength,1);
TimeAllDecreaseTable=ones(TimeAllDecreaseTableLength,1);
ad_i=0;

% PureTable is a table containing the pure percents
% at the end of the run, for a setup of k-b-a-p-q

% can't have a=0, p=0 (but p != 0) or a=0, q=0
PureTableLength=P_LENGTH*(A_LENGTH*Q_LENGTH-1)*B_LENGTH*K_LENGTH;
K_pure=zeros(PureTableLength,1);
B_pure=zeros(PureTableLength,1);
A_pure=zeros(PureTableLength,1);
P_pure=zeros(PureTableLength,1);
Q_pure=zeros(PureTableLength,1);
PureTable=zeros(PureTableLength,1);
pure_i=0;

% start time count
tic;
IterationsUntilNow = 0;
% can't have a=0, p=0 (but p!=0) or a=0, q=0
TOTAL_ITERATIONS = P_LENGTH*(A_LENGTH*Q_LENGTH-1)*B_LENGTH*K_LENGTH*SIMS_NO;

for K=Ks
    for Betha=Bs
        G=WattsStrogatz(N,K,Betha);
        fprintf('Artificial social network created\n');

        % Call analysis
        A=adjacency(G);
        N=numnodes(G);
        
        % ModelSetupTimeAndPure enables access to time and pure
        % values given a,p,q
        
        % can't have a=0, p=0 (but p != 0) or a=0, q=0
        ModelSetupTimeAndPureLength=P_LENGTH*(A_LENGTH*Q_LENGTH-1);
        ModelSetupTimeAndPure=(-1)*ones(A_LENGTH,P_LENGTH,Q_LENGTH,2);
        A_n=zeros(ModelSetupTimeAndPureLength,1);
        P_n=zeros(ModelSetupTimeAndPureLength,1);
        Q_n=zeros(ModelSetupTimeAndPureLength,1);
        % ModelSetupTime and ModelSetupPure are one-dimensional
        % tables containing time and pure values, with corresponding
        % sizes to A_n,P_n,Q_n, enabling to print the values
        % to a csv file alongside them
        ModelSetupTime=zeros(ModelSetupTimeAndPureLength,1);
        ModelSetupPure=zeros(ModelSetupTimeAndPureLength,1);
        ns_i=0;

        ai=0;
        for ALPHA=As
            ai=ai+1;
            pi=0;
            for P=Ps
                pi=pi+1;
                if (P==0 && ALPHA==0)
                    continue;
                end
                Q_HOP=P/Q_P_HOP_RATIO;
                Qs=0:Q_HOP:P;
                qi=0;
                for Q=Qs
                    qi=qi+1;
                    if (Q==0 && ALPHA==0)
                        continue;
                    end
                    
                    [ IterationsUntilNow, TimeToComplete, Pure ] = CalculateValuesForModelParameters( Betha,K,ALPHA,P,Q,SIMS_NO,A,N,IterationsUntilNow,TOTAL_ITERATIONS,data_folder_path );
                    
                    % NetworkSetupTimeAndPure values
                    ns_i=ns_i+1;
                    A_n(ns_i)=ALPHA;
                    P_n(ns_i)=P;
                    Q_n(ns_i)=Q;
                    [ ModelSetupTimeAndPure, ModelSetupTime, ModelSetupPure ] = UpdateModelSetupTable( ns_i,ModelSetupTimeAndPure,ModelSetupTime,ModelSetupPure,TimeToComplete,Pure,ai,pi,qi );
                    
                    % calc pure table
                    [ PureTable,K_pure,B_pure,A_pure,P_pure,Q_pure,pure_i ] = UpdatePureTable( PureTable,pure_i,ModelSetupTimeAndPure,ai,pi,qi,K_pure,B_pure,A_pure,P_pure,Q_pure,K,Betha,ALPHA,P,Q );

                    if mod(pure_i, UPDATE_RATE) == 0
                        AddEntriesToPureFile( PureTable,K_pure,B_pure,A_pure,P_pure,Q_pure,pure_i);
                    end
                end
                
                % calc time all decrease table
                [ TimeAllDecreaseTable,K_ad,B_ad,A_ad,P_ad,ad_i ] = UpdateTimeAllDecrease( TimeAllDecreaseTable,ad_i,ModelSetupTimeAndPure,Qs,ai,pi,K_ad,B_ad,A_ad,P_ad,K,Betha,ALPHA,P);
                
                if mod(ad_i, UPDATE_RATE) == 0
                    AddEntriesToTimeAllDecreaseFile( TimeAllDecreaseTable,K_ad,B_ad,A_ad,P_ad,ad_i);
                end
            end
        end
        
        T=table(A_n,P_n,Q_n,ModelSetupTime(:,1),ModelSetupPure(:,1));
        T.Properties.VariableNames={'Alpha','P','Q','TimeToComplete','Pure'};
        TIMES_AND_PURES_PATH=sprintf("%sB%.6f-K%.6f-TIMES_AND_PURES.csv", data_folder_path, Betha, K);
        writetable(T,TIMES_AND_PURES_PATH);
    end
end