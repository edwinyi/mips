% Compatible Off-Policy Deterministic Actor-Critic.
% You can use a Q-learning critic or a Gradient Q-learning critic.
% Both the policy and the Q-function approximation are linear in the
% parameters.
%
% This version is modified such that all gradients normalized.
%
% =========================================================================
% REFERENCE
% D Silver, G Lever, N Heess, T Degris, D Wierstra, M Riedmiller
% Deterministic Policy Gradient Algorithms (2014)

clear all
close all

rng(1)

showplots = 1;
J_history = [];

mdp = MCarContinuous; sigma = 4; maxsteps = 100;
mdp = CartPoleContinuous; sigma = 10; maxsteps = 1000;
% mdp = PuddleworldContinuous; sigma = 1; maxsteps = 100;
% mdp = Pendulum; sigma = 2; maxsteps = 50;
% mdp = LQR(2); sigma = 5; maxsteps = 150;
steps_eval = 150;

robj = 1;
gamma = 0.99;
mdp.gamma = gamma;
noise = @() (rand(mdp.daction,1) - 0.5) * 2 * sigma;
lrate_theta = 0.001;
lrate_v = 0.001;
lrate_w = 0.001;
totsteps = 1;
eval_every = 1000;


%% Setup actor and critic
% Policy
tmp_policy.drawAction = @(x)mymvnrnd(zeros(mdp.daction,1), sigma^2*eye(mdp.daction), size(x,2));
ds = collect_samples(mdp, 100, 100, tmp_policy);
B = avg_pairwise_dist([ds.s]);
bfs = @(varargin) basis_fourier(100, mdp.dstate, B, 0, varargin{:});

bfsPi = bfs;
bfsV = bfs;

% bfsPi = @(varargin)basis_poly(1,mdp.dstate,0,varargin{:});
% bfsV = @(varargin)basis_poly(2,mdp.dstate,0,varargin{:});

theta = zeros(bfsPi()*mdp.daction,1);
mu = @(s,theta) reshape(theta,bfsPi(),mdp.daction)' * bfsPi(s);
d_policy = @(s) kron(eye(mdp.daction),bfsPi(s));

% V-function
v = zeros(bfsV(),1);
Vfun = @(s,v) v'*bfsV(s);

% Q-function (with compatible function approximation)
w = zeros(size(theta));
bfs_q = @(s,a,theta) d_policy(s) * (a - mu(s,theta));
Qfun = @(s,a,w,v,theta) bfs_q(s,a,theta)' * w + Vfun(s,v);

u = zeros(size(w));
lrate_u = lrate_v;

% Update rules
natural = true;
gradient = true;

%% Prepare plots
if showplots
    if mdp.dstate == 2
        npoints_plot = 10;
        Xnodes = linspace(mdp.stateLB(1),mdp.stateUB(1),npoints_plot);
        Ynodes = linspace(mdp.stateLB(2),mdp.stateUB(2),npoints_plot);
        [X, Y] = meshgrid(Xnodes,Ynodes);
        XY = [X(:)';Y(:)'];
        S = XY;
    elseif mdp.dstate == 1
        npoints_plot = 10;
        S = linspace(mdp.stateLB(1),mdp.stateUB(1),npoints_plot);
        figure; hP = plot(S,zeros(1,npoints_plot)); title 'Policy';
        figure; hQ = plot(S,zeros(1,npoints_plot)); title 'V-function - Q(s,pi(s))';
    end
%     mdp.showplot
end


%% Learn
while totsteps < 3000000
    
    state = mdp.initstate(1);
    terminal = 0;
    step = 0;
    
    while (step < maxsteps) && ~terminal
        step = step + 1;
    
        action = mu(state,theta) + noise();
        [nextstate, reward, terminal] = mdp.simulator(state, action);
        Qn = Qfun(nextstate, mu(nextstate,theta), w, v, theta);
        Q = Qfun(state, action, w, v, theta);

        % Actor and critic update
        delta = reward(robj) + gamma * Qn * ~terminal - Q;
        
        theta_old = theta;

        if natural % Natural
            g_theta = w;
        else % Vanilla
            g_theta = d_policy(state) * (d_policy(state)' * w);
        end
        theta = theta + lrate_theta * g_theta / max(norm(g_theta),1); % Normalize gradient

        if gradient % Gradient Q-learning critic
            g_w = max(norm(delta),1) * delta * bfs_q(state,action,theta_old) ...
                - gamma * bfs_q(nextstate,mu(nextstate,theta_old),theta_old) * (bfs_q(state,action,theta_old)' * u);
            g_v = delta * bfsV(state) ...
                - gamma * bfsV(nextstate) * (bfs_q(state,action,theta_old)' * u);
            g_u = (delta - (bfs_q(state,action,theta_old)' * u)) * bfs_q(state,action,theta_old);
        else % Q-learning critic
            g_w = delta * bfs_q(state,action,theta_old);
            g_v = delta * bfsV(state);
        end
        
        % Normalize gradients
        w = w + lrate_w / max(1,norm(g_w)) * g_w;
        v = v + lrate_v / max(1,norm(g_v)) * g_v;
        if gradient
            u = u + lrate_u / max(1,norm(g_u)) * g_u;
        end
        
        if any(isnan(theta)) || any(isnan(w)) || any(isnan(v)) || ...
                any(isinf(theta)) || any(isinf(w)) || any(isinf(v))
            error('Inf or NaN.')
        end
        
        state = nextstate;
        totsteps = totsteps + 1;
        
        if mod(totsteps, eval_every) == 0
            policy_eval.drawAction = @(s) mu(s,theta);
            J_history(end+1) = evaluate_policies(mdp, 100, steps_eval, policy_eval);
            if showplots, updateplot('Return',totsteps,J_history(end)); end
        end

        %% Plot
        if showplots && mod(totsteps,50) == 0
            if mdp.dstate == 1
                P = mu(S,theta);
                for i = 1 : size(S,2)
                    Q(:,i) = Qfun(S(:,i),P(:,i),w,v,theta);
                end
                hP.YData = P;
                hQ.YData = Q;
                drawnow limitrate
            elseif mdp.dstate == 2
                P = mu(S,theta);
                for i = 1 : size(S,2)
                    Q(:,i) = Qfun(S(:,i),P(:,i),w,v,theta);
                end
                subimagesc('Policy',Xnodes,Ynodes,P,1)
                subimagesc('V-function',Xnodes,Ynodes,Vfun(S,v))
            end
            updateplot('MSTDE',totsteps,delta^2)
            updateplot('Action',totsteps,action)
            if totsteps < 3, autolayout, end
        end
        
    end
    
end


%% Show
policy_eval.drawAction = @(s) mu(s,theta);
show_simulation(mdp, policy_eval, 100, 0.01)
