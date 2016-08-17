function f = log_likelihood (SS, theta, adj_v, adj_u, Z)
    if nargin < 5
        Z = computeZ(SS, theta, adj_v, adj_u);
    end
    f = theta*SS' - n*log(Z);
end