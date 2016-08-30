function S = mexMetric_hv(J, AU, U, N)
% MEXMETRIC_HV Scalarizes a set of solution for multi-objective problem 
% (i.e., an approximate Pareto frontier). A solution is ranked according to 
% its contribution to the hypervolume of the frontier.
%
% See also MEXHYPERVOLUMECONTRIBUTION.
%
%    INPUT
%     - J  : [N x M] matrix of samples to evaluate, where N is the number of
%            samples and M the number of objectives
%     - AU : antiutopia point
%     - U  : utopia point
%     - N  : number of samples for the approximation
%
%    OUT
%     - S  : [N x 1] vector of the non-dominance-based metric value for each
%            sample

[uniqueJ, ~, idx] = unique(J,'rows'); % Ignore duplicates
[front, ~, idx2] = pareto(uniqueJ); % Dominated solutions have 0 contribution

hvContrib = mexHypervolumeContribution(front,AU,U,N);

hvUnique = zeros(size(uniqueJ,1),1);
hvUnique(idx2) = hvContrib;
S = hvUnique(idx); % Map back to duplicates
S = max(0,S); % The contribution estimation might be negative using a Monte Carlo approx of the hypervolume
S(S==0) = -0.001; % Penalty for dominated solutions
