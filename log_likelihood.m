function f = log_likelihood (SS, theta, v, u, adj_v, adj_u, d, n, logZ)
    if nargin < 9
        logZ = compute_logZ(theta, v, u, adj_v, adj_u , d);
    end
    f = theta*SS' - n*logZ;
end