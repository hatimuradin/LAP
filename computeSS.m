function [SS] = computeSS(v,u, adj_v, adj_u, X)
    adj_v(u) = 0;
    adj_u(v) = 0;
    union_adj = adj_v | adj_u;
    
    SS = zeros(size(X,1), 3 + sum(adj_v) + sum(adj_u) +  sum(union_adj) + sum(union_adj)*(sum(union_adj)-1)/2);
    SS(:,1) = X(:,v).*X(:,u);
    SS(:,2) = X(:,v);
    SS(:,3) = X(:,u);
    index = 4;
    
    SS(:,index:index+sum(adj_v) - 1) = X(:,(adj_v == 1)) .* repmat(X(:,v),1,sum(adj_v));
    index = index + sum(adj_v);
    
    SS(:,index:index+sum(adj_u) - 1) = X(:,(adj_u == 1)) .* repmat(X(:,u),1,sum(adj_u));
    index = index + sum(adj_u);
    
    SS(:, index:index+sum(union_adj) - 1) = X(:,union_adj == 1);
    index = index + sum(union_adj);
    
    f = find(union_adj);
    for i=1:length(f)
       for j=i+1:length(f)
           SS(:, index) = X(:, f(i)).*X(:, f(j));
           index = index + 1;
       end
    end
    
    SS = sum(SS,1);
    
end