function f = likelihood (SS, theta, adj_v, adj_u)
    Z = computeZ(SS, theta, adj_v, adj_u);
    f = n/Z*exp(sum(theta*SS',1));
end