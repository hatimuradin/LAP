function [ESS, CovSS] = computeESS(theta, u, v, adj_v, adj_u, d, logZ)
    
    ESS = zeros(size(theta));
    CovSS = zeros(length(theta),length(theta));


    adj_v(u) = 0;
    adj_u(v) = 0;
    union_adj = adj_v | adj_u;
    aux_features = union_adj;
    aux_features(v) = 1;
    aux_features(u) = 1;
    aux_features = logical(aux_features);
        
    %%%% compute ESS and CovSS

    x = zeros(1, d);
    y = zeros(1,sum(aux_features));
    for i=1:2^(sum(aux_features))
        if ~any(y == 0)
            y = zeros(size(y));
        else
            j = find(y == 0, 1);
            y(1:j-1) = 0;
            y(j) = 1;
        end 
        x(logical(aux_features)) = y;

        SS_tmp = computeSS(u, v, adj_v, adj_u, x);

        ESS = ESS + exp(theta*SS_tmp' - logZ) * SS_tmp;
        CovSS = CovSS - exp(theta*SS_tmp' - logZ) * (SS_tmp' * SS_tmp);
        
        if sum(isnan(ESS)) > 0
            disp('here');
        end

    end
    
    CovSS = CovSS - ESS'*ESS; 

end
