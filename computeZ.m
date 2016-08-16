function [Z, ESS, H] = computeZ (SS, theta, adj_v, adj_u)
    adj_v(u) = 0;
    adj_u(v) = 0;
    union_adj = adj_v | adj_u;
    aux_features = union_adj;
    aux_features(v) = 1;
    aux_features(u) = 1;
    aux_features = find(aux_features);

    MaxIter = 100;

    for iter = 1:MaxIter
        %%%% compute Z and ESS and H
        Z = 0;
        ESS = zeros(size(SS));
        H = zeros(length(SS),length(SS));
        x = zeros(1, length(adj_v));
        y = zeros(1,2+sum(union_adj));
        for i=1:2^(2+sum(union_adj))
            if ~any(y == 0)
                y = zeros(size(y));
            else
                j = find(y == 0, 1);
                y(1:j-1) = 0;
                x(j) = 1;
            end 
            x(aux_features) = y;
            
            SS_tmp = computeSS(x);
            Z = Z + exp(theta*SS_tmp');
            ESS = ESS + exp(theta*SS_tmp') * SS_tmp;
            H = H - exp(theta*SS_tmp') * (SS_tmp' * SS_tmp);
        end
        ESS = ESS / Z;
        H = H / Z;
        H = H - ESS'*ESS; 
    end
    
end