function [  ] = CalcTimeEst( IterationsUntilNow, TOTAL_ITERATIONS )
%CALCTIMEEST Summary of this function goes here
%   Detailed explanation goes here

TimeUntilNowSecs = toc;
RemainingIters = TOTAL_ITERATIONS - IterationsUntilNow;

IterAvgTime = TimeUntilNowSecs / IterationsUntilNow;
TimeRemaining = RemainingIters * IterAvgTime;
PercentCompleted = (100 * IterationsUntilNow) / TOTAL_ITERATIONS;
DurationStrRemaining=datestr(datenum(0,0,0,0,0,TimeRemaining),'DD:HH:MM:SS');
DurationStrPast=datestr(datenum(0,0,0,0,0,TimeUntilNowSecs),'DD:HH:MM:SS');
fprintf("Time remaining: %s, Time passed: %s, Percent completed: %.5f%%\n", DurationStrRemaining, DurationStrPast, PercentCompleted);

end

