clear, clear global
close all

%% ===================================================================== %%
%  ======================== LOW LEVEL SETTINGS =========================  %
mdp = Gridworld;
robj = 1;

% bfs = @(varargin)basis_poly(1,mdp.dstate,0,varargin{:});
bfs = @(varargin)basis_krbf(7, [mdp.stateLB, mdp.stateUB], 0, varargin{:});
bfs = @(varargin)basis_tiles(7, [mdp.stateLB, mdp.stateUB], 0, varargin{:});

policy = Gibbs(bfs, zeros((bfs()+1)*(mdp.actionUB-1),1), mdp.actionLB:mdp.actionUB);


%% ===================================================================== %%
%  ======================= HIGH LEVEL SETTINGS =========================  %
makeDet = 0; % 1 to learn deterministic low level policies
n_params = policy.dparams;
mu0 = policy.theta(1:n_params);
Sigma0high = 10 * eye(n_params);
Sigma0high = Sigma0high + diag(abs(mu0)).^2;
Sigma0high = nearestSPD(Sigma0high);
policy_high = GaussianConstantChol(n_params, mu0, Sigma0high);
% policy_high = GaussianConstantDiag(n_params, mu0, Sigma0high);
% policy_high = GmmConstant(mu0,Sigma0high,5);


%% ===================================================================== %%
%  ======================== LEARNING SETTINGS ==========================  %
episodes_eval = 1000;
steps_eval = 20;
episodes_learn = 500;
steps_learn = 150;
