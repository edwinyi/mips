classdef (Abstract) GaussianConstant < Gaussian
% GAUSSIANCONSTANT Generic class for Gaussian policies. Its parameters do 
% not depend on any features, i.e., Action = N(mu, Sigma).
    
    properties(GetAccess = 'public', SetAccess = 'protected')
        mu
        Sigma
        U     % Cholesky decomposition
    end
    
    methods
        
        %% LOG(PDF)
        function logprob = logpdf(obj, Actions)
            Actions = bsxfun(@minus, Actions, obj.mu);
            d = size(Actions,1);
            Q = obj.U' \ Actions;
            q = dot(Q,Q,1); % quadratic term (M distance)
            c = d * log(2*pi) + 2 * sum(log(diag(obj.U))); % normalization constant
            logprob = -(c+q)/2;
        end

        %% MVNPDF
        function probability = evaluate(obj, Actions)
            probability = exp(obj.logpdf(Actions));
        end

        %% MVNRND
        function Actions = drawAction(obj, N)
            if nargin == 1, N = 1; end
            Actions = bsxfun(@plus, obj.U'*randn(obj.daction,N), obj.mu);
        end
        
        %% PLOT PDF
        function fig = plot(obj, actionLB, actionUB)
        % Plot N(mu(i),Sigma(i,i)) for each dimension i (NORMPDF)
            if nargin < 3, actionUB = inf; end
            if nargin < 2, actionLB = -inf; end

            fig = figure(); hold all
            xlabel 'x'
            ylabel 'pdf(x)'
            range = ndlinspace(obj.mu - 3*diag(obj.Sigma), obj.mu + 3*diag(obj.Sigma), 100);
            
            norm = bsxfun(@times, exp(-0.5 * bsxfun(@times, ...
                bsxfun(@minus,range,obj.mu), 1./diag(obj.Sigma)).^2), ... 
                1./(sqrt(2*pi) .* diag(obj.Sigma)));

            norm = bsxfun(@max, bsxfun(@min, norm, actionUB), actionLB);

            plot(range', norm')
            legend show
        end

    end

end
