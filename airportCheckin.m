clear all; close all;

% Simulation
nsim = 1500;            % number of repeated simulations

lam   = 1/100;        % the expected number of incoming passengers   
ab    = [1/60 5/60];  % lower and upper limits for the uniform distribution    
topen = 0;            % time when check-in is open
ndesk = 6;            % number of desks             
passengers = 140;     % number of passengers with tickets
 
nwaits = zeros(1,nsim); % how many had to wait
avgwaits = nwaits;      % average waiting times
narrs = nwaits;         % how many came
tcloses = nwaits;       % check-in closing times

for i=1:nsim % go trough the number of simulations    
    [tarr, twait, tclose] = airport_f(lam, ab, topen, ndesk, passengers);
    nwaits(i)  = sum(twait > 0);
    avgwaits(i) = mean(twait);
    tcloses(i) = tclose;   
end

% Draw the plots
figure(1)
histogram(tcloses,35)   % plot the histogram of closing times of check-in desks
title('Distribution of the overall service time of the check-in')
figure(2) 
histogram(avgwaits*60,35) % plot the histogram of average waiting times of passengers (in minutes).
title('Average waiting times (minutes)')


% Answers
% Find how long time (in hours) the check-in should be opened, so that all the passengers get served  
tclose95 = quantile(tcloses, 0.95) 

% Find how long time before the departure (in hours) the check-in should be opened, so that all the passengers get served 20 minutes before the departure? 
time_before_departure = 20/60 + tclose95