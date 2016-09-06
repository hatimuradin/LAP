function f = log_likelihood (SS, theta, clique, clqAdj, d, n, logZ)
    if nargin < 9
        logZ = compute_logZ(theta, clique, clqAdj, d);
    end
    f = theta*SS' - n*logZ;
end