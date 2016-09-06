function [SS] = computeSS(clique, claAdj, X)
    
    claAdj(:,clique) = false;

    union_adj = size(claAdj,1);
    for i=1:size(clique)
        union_adj = union_adj | clique(i);
    end
    
    SS = zeros(size(X,1), length(clique)  + length(clique)*(length(clique) - 1)/2 + sum(sum(claAdj)) + sum(union_adj) + sum(union_adj)*(sum(union_adj)-1)/2);

    % each clique node
    index = 1;
    for i=clique
       SS(:,index) = X(:, i);
       index = index + 1;
    end
    
    % each clique internal edge
    for i=1:size(clique)
        for j=i+1:size(clique)
            SS(:,index) = X(:, clique(i))*X(:, clique(j));
            index = index + 1;
        end
    end
    
    % each node .* adj
    for i=clique
        for j=find(claAdj(i))
            SS(:,index) = X(:, i) .* X(:, j);
            index = index + 1;
        end
    end
    
    % each clique node adjacent
    union_idx = find(union_adj);
    for i=union_idx
        SS(:,index) = X(:, i);
        index = index + 1;
    end
    
    % adj .* adj
    for i=union_idx
        for j=union_idx
            SS(:,index) = X(:,i) .* X(:,j);
            index = index + 1;
        end
    end
    
    SS = sum(SS, 1);
end