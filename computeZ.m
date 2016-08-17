function [Z, ESS, H] = computeZ (theta, aux_features)

    %%%% compute Z and ESS and H
    Z = 0;
    ESS = zeros(size(theta));
    H = zeros(length(theta),length(theta));
    x = zeros(1, n);
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

        SS_tmp = computeSS(x);
        Z = Z + exp(theta*SS_tmp');
        ESS = ESS + exp(theta*SS_tmp') * SS_tmp;
        H = H - exp(theta*SS_tmp') * (SS_tmp' * SS_tmp);
    end
    ESS = ESS / Z;
    H = H / Z;
    H = H - ESS'*ESS; 
    
end