clear all
close all

%% ===================================================================== %%
%  ======================== LOW LEVEL SETTINGS =========================  %
mdp = MCar;
robj = 1;
dreward = mdp.dreward;
gamma = mdp.gamma;
nactions = mdp.actionUB;

bfs = @(varargin)basis_krbf(4,[-1 1;-3 3],0,varargin{:});
% bfs = @(varargin)basis_poly(1,mdp.dstate,0,varargin{:});

policy = Gibbs(bfs, zeros((bfs()+1)*(nactions-1),1), mdp.actionLB:mdp.actionUB);
policy = EGreedy(bfs, zeros((bfs()+1)*nactions,1), mdp.actionLB:mdp.actionUB, 1);


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


%% ===================================================================== %%
%  ======================== LEARNING SETTINGS ==========================  %
episodes_eval = 1;
steps_eval = 50;
episodes_learn = 50;
steps_learn = 500;
