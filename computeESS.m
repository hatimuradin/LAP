function [ESS, CovSS] = computeESS(theta, clique, adj, d, logZ)
    
    ESS = zeros(size(theta));
    CovSS = zeros(length(theta),length(theta));

    union_adj = size(adj,1);
    for i=1:size(clique)
        union_adj = union_adj | clique(i);
    end
    
%     adj_v(u) = 0;
%     adj_u(v) = 0;
%     union_adj = adj_v | adj_u;
%     aux_features = union_adj;
%     aux_features(v) = 1;
%     aux_features(u) = 1;
%     aux_features = logical(aux_features);
    aux_features = union_adj;
    for i=1:size(clique)
        aux_features(i) = 1;
    end
    aux_features = logical(aux_features);
    %%%% compute ESS and CovSS

    x = zeros(1, d);
    y = zeros(1,sum(aux_features));
%     for i=1:2^(sum(aux_features))
%         if ~any(y == 0)
%             y = zeros(size(y));
%         else
%             j = find(y == 0, 1);
%             y(1:j-1) = 0;
%             y(j) = 1;
%         end 
%         x(logical(aux_features)) = y;
% 
%         SS_tmp = computeSS(v, u, adj_v, adj_u, x);
% 
%         ESS = ESS + exp(theta*SS_tmp' - logZ) * SS_tmp;
%         CovSS = CovSS + exp(theta*SS_tmp' - logZ) * (SS_tmp' * SS_tmp);
% 
%     end
    for i=1:2^(sum(aux_features))
       y = dec2bin(i, sum(aux_features)) - '0';
       x(logical(aux_features)) = y;
       
       SS_tmp = computeSS(clique, adj, x);
       ESS = ESS + exp(theta*SS_tmp' - logZ) * SS_tmp;
       CovSS = CovSS + exp(theta*SS_tmp' - logZ) * (SS_tmp' * SS_tmp);
    end
    
    CovSS = CovSS - ESS'*ESS; 

end
