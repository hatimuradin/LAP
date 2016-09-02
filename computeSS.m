function [SS] = computeSS(clique, adj, X)
    
    SS = zeros(size(X,1), size(clique)  +  sum(union_adj) + sum(union_adj)*(sum(union_adj)-1)/2);

    % each clique node
    index = 1;
    for i=1:size(clique)
       SS(:,index) = X(:, i);
       index = index + 1;
    end
    
    % each clique node adjacent
    for i=1:size(clique)
        for j=1:size(find(adj(i)))
            SS(:,index) = X(:, j);
            index = index + 1;
        end
    end
    
    % each node .* adj
    for i=1:size(clique)
        for j=1:size(find(adj(i)))
            SS(:,index) = X(:, i) .* X(:, j);
            index = index + 1;
        end
    end
    
    % adj .* adj
    union_adj = size(adj,1);
    for i=1:size(clique)
        union_adj = union_adj | clique(i);
    end
    
    union_idx = find(union_adj);
    for i=1:size(union_idx)
        for j=i+1:size(union_idx)
            SS(:,index) = X(:,union_idx(i)) .* X(:,union_idx(j));
        end
    end
    
    SS = sum(SS, 1);
end