function logZ = compute_logZ (theta, clique, clqAdj, d)

    union_adj = zeros(1, size(clqAdj,2));
    for i=1:length(clique)
        union_adj = union_adj | clqAdj(i, :);
    end
    
%     adj_v(u) = 0;
%     adj_u(v) = 0;
%     union_adj = adj_v | adj_u;
%     aux_features = union_adj;
%     aux_features(v) = 1;
%     aux_features(u) = 1;
%     aux_features = logical(aux_features);
    aux_features = union_adj;
    for i=1:length(clique)
        aux_features(i) = 1;
    end
    aux_features = logical(aux_features);
%     %%%% compute Z and ESS and H
% 
    x = zeros(1, d);
    %y = zeros(1,sum(aux_features));
    log_sum_tmp = zeros(1,2^sum(aux_features));
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
%         log_sum_tmp(i) = theta*SS_tmp';
%     end
%     logZ = log_sum_exp(log_sum_tmp, 2);
    for i=1:2^(sum(aux_features))
       y = dec2bin(i,sum(aux_features)) - '0';
       x(find(aux_features)) = y;
       
       SS_tmp = computeSS(clique, clqAdj, x);
       log_sum_tmp(i) = theta*SS_tmp';
    end
    logZ = log_sum_exp(log_sum_tmp, 2);

end