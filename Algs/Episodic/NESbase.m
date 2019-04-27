function [nat_grad, stepsize] = NESbase(policy_high, data, epsilon, W)
% Natural Evolution Strategy with optimal baseline.
% It supports Importance Sampling (IS).
% NAT_GRAD is a [D x R] matrix, where D is the length of the gradient and R
% is the number of immediate rewards received at each time step.
%
% =========================================================================
% REFERENCE
% D Wierstra, T Schaul, T Glasmachers, Y Sun, J Peters, J Schmidhuber 
% Natural Evolution Strategy (2014)

if nargin < 4, W = ones(1, size(data.J,2)); end % IS weights

dlogPidtheta = policy_high.dlogPidtheta(data.Theta);
data.J = permute(data.J,[3 2 1]);

den = sum( bsxfun(@times, dlogPidtheta.^2, W.^2), 2 );
num = sum( bsxfun(@times, dlogPidtheta.^2, bsxfun(@times, data.J, W.^2)), 2 );
b = bsxfun(@times, num, 1./den);
b(isnan(b)) = 0;
diff = bsxfun(@times, bsxfun(@minus,data.J,b), W);
grad = permute( sum(bsxfun(@times, dlogPidtheta, diff), 2), [1 3 2] );

N = length(W); % unbiased
% N = sum(W); % lower variance

grad = grad / N;

% If we can compute the FIM in closed form, we use it
if ismethod(policy_high,'fisher')
    F = policy_high.fisher;
else
    F = dlogPidtheta * bsxfun(@times, dlogPidtheta, W)';
    F = F / N;
end

% If we can compute the FIM inverse in closed form, we use it
if ismethod(policy_high,'inverseFisher')
    invF = policy_high.inverseFisher;
    nat_grad = invF * grad;
elseif rank(F) == size(F,1)
    nat_grad = F \ grad;
else
%     warning('Fisher matrix is lower rank (%d instead of %d).', rank(F), size(F,1));
    nat_grad = pinv(F) * grad;
end

if nargin > 2
    lambda = sqrt(diag(grad' * nat_grad) / (8 * epsilon))';
    lambda = max(lambda,1e-8); % to avoid numerical problems
    stepsize = 1 ./ (2 * lambda);
end

end