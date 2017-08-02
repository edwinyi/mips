classdef GaussianLinearFixedvar < GaussianLinear
% GAUSSIANLINEARFIXEDVAR Gaussian distribution with linear mean and fixed 
% covariance: N(A*phi,S).
% Parameters: mean A.
    
    methods
        
        %% Constructor
        function obj = GaussianLinearFixedvar(basis, dim, initA, Sigma)
            assert(isscalar(dim) && ...
            	size(initA,2) == basis()+1 && ...
            	size(initA,1) == dim && ...
                size(Sigma,1) == dim && ...
            	size(Sigma,2) == dim, ...
                'Dimensions are not consistent.')
            [initU, p] = chol(Sigma);
            assert(p == 0, 'Covariance must be positive definite.')

            obj.daction = dim;
            obj.theta = initA(:);
            obj.basis = basis;
            obj.Sigma = Sigma;
            obj.dparams = length(obj.theta);
            obj.A = initA;
            obj.U = initU;
        end
        
        %% Derivative of the logarithm of the policy
        function dlpdt = dlogPidtheta(obj, state, action)
            phi = obj.basis1(state);
            dlpdt = mtimescolumn((obj.Sigma) \ (action - obj.A*phi), phi);
        end
        
        %% Hessian matrix of the logarithm of the policy
        function hlpdt = hlogPidtheta(obj, state, action)
            nsamples = size(state,2);
            phi = obj.basis1(state);
            phimat = kron(phi',eye(obj.daction));
            invSigma = inv(obj.Sigma);
            hlpdt = zeros(obj.dparams,obj.dparams,nsamples);
            for i = 1 : nsamples
                idx1 = obj.daction*(i-1)+1;
                idx2 = idx1+obj.daction-1;
                subphimat = phimat(idx1:idx2,:);
                hlpdt(:,:,i) = - subphimat' * invSigma * subphimat;
            end
        end

        %% WML
        function obj = weightedMLUpdate(obj, weights, Action, Phi)
            assert(min(weights)>=0, 'Weights cannot be negative.')
            assert(size(Phi,1) == obj.basis()+1)
            weights = weights / sum(weights);
            PhiW = bsxfun(@times,Phi,weights);
            A = (PhiW * Phi' + 1e-8 * eye(size(Phi,1))) \ PhiW * Action';
            A = A';
            obj = obj.update(A(:));
        end

        %% Update
        function obj = update(obj, theta)
            obj.theta(1:length(theta)) = theta;
            A = vec2mat(obj.theta,obj.daction);
            obj.A = A;
        end

        %% Change stochasticity
        function obj = makeDeterministic(obj)
            obj.Sigma = 0 * obj.Sigma;
            obj.U = 0 * obj.Sigma;
        end
        
        function obj = randomize(obj,varargin)
            warning('This policy cannot be randomized!')
        end
        
    end
    
end
