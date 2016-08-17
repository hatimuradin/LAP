function f = log_likelihood (SS, theta, u, v, adj_v, adj_u, d, n, Z)
    if nargin < 9
        Z = computeZ(theta, u, v, adj_v, adj_u , d);
    end
    f = theta*SS' - n*log(Z);
end