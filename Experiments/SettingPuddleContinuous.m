clear all
close all

%% ===================================================================== %%
%  ======================== LOW LEVEL SETTINGS =========================  %
mdp = PuddleworldContinuous;
robj = 1;
dreward = mdp.dreward;
gamma = mdp.gamma;
daction = mdp.daction;

bfs = @(varargin)basis_krbf(4,[0 1; 0 1],0,varargin{:});
% bfs = @(varargin)basis_poly(2,mdp.dstate,0,varargin{:});

A0 = zeros(daction,bfs()+1);
Sigma0 = 1*eye(daction);
policy = GaussianLinearDiag(bfs, daction, A0, Sigma0);
% policy = GaussianLinearChol(bfs, daction, A0, Sigma0);


%% ===================================================================== %%
%  ======================= HIGH LEVEL SETTINGS =========================  %
makeDet = 0; % 1 to learn deterministic low level policies
n_params = policy.dparams*~makeDet + numel(A0)*makeDet;
mu0 = policy.theta(1:n_params);
Sigma0high = 10 * eye(n_params);
Sigma0high = Sigma0high + diag(abs(mu0)).^2;
Sigma0high = nearestSPD(Sigma0high);
policy_high = GaussianConstantChol(n_params, mu0, Sigma0high);
% policy_high = GaussianConstantDiag(n_params, mu0, Sigma0high);


%% ===================================================================== %%
%  ======================== LEARNING SETTINGS ==========================  %
episodes_eval = 1000;
steps_eval = 100;
episodes_learn = 50;
steps_learn = 100;
