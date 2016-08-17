function [SS] = computeSS(v,w, adj_v, adj_w, X)
    adj_v(w) = 0;
    adj_w(v) = 0;
    union_adj = adj_v | adj_w;
    
    SS = zeros(size(X,1), 3 + sum(adj_v) + sum(adj_w) +  sum(union_adj) + sum(union_adj)*(sum(union_adj)-1)/2);
    SS(:,1) = X(:,v).*X(:,w);
    SS(:,2) = X(:,v);
    SS(:,3) = X(:,w);
    index = 4;
    
    SS(:,index:index+sum(adj_v)) = X(:,(adj_v == 1)) .* repmat(X(:,v),1,sum(adj_v));
    index = index + sum(adj_v);
    
    SS(:,index:index+sum(adj_w)) = X(:,(adj_w == 1)) .* repmat(X(:,w),1,sum(adj_w));
    index = index + sum(adj_w);
    
    SS(:, index:index+sum(union_adj)) = X(:,union_adj == 1);
    index = index + sum(union_adj);
    
    f = find(union_adj);
    for i=1:length(f)
       for j=i+1:lengtj(f)
           SS(:, index) = X(:, f(i)).*X(:, f(j));
           index = index + 1;
       end
    end
    
    SS = sum(SS,1);
    
end