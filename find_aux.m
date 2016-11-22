function [aux_cliques] = find_aux(cliques, adj)
    % Pairwise 
    aux_cliques = cell();
    potential_functions = cell();
    
    for i=1:length(cliques)
       currentClique = find(cliques(:,i));
       
       oneNH = [];
       for vertex=1:length(currentClique)
           for ii=1:size(adj,1)
               if (   adj(ii, vertex) == 1 && isempty(find(currentClique == ii , 1)) )
                   % adds cliques and potential fucntions with one node in clique and one as 1-neighbourhood 
                   
                   % checks if the clique is not previously added add it
                   % and its pot funcs
                   if ( isempty(find(aux_cliques == [vertex, ii], 1)) && isempty(find(aux_cliques == [ii, vertex], 1)) );
                        aux_cliques = [aux_cliques, [vertex, ii]];
                        potential_func1 = @(vertex, ii, w1, x) w1*x(ii);
                        potential_func2 = @(vertex, ii, w2, x) w2*x(vertex)*x(ii);
                        potential_funcs = [potential_funcs, potential_func1, potential_func2];
                   end
                   % adds cliques and potential functions with both nodes in 1-neighbourhood                   
                   oneNH = [oneNH ii];
                   
               end
           end  % finding 1-neighbour of each node of clique
       end  % entire clique
       
       for jj=1:length(oneNH)
           for kk=jj+1:length(oneNH)
               if ( isempty(find(aux_cliques == [vertex, ii], 1)) && isempty(find(aux_cliques == [ii, vertex], 1)) );
                    arg1 = oneNH(jj);
                    arg2 = oneNH(kk);
                    aux_cliques = [aux_cliques, [arg1, arg2]];
                    potential_func1 = @(arg1, arg2, w1, x) w1*x(ii);
                    potential_func2 = @(arg1, arg2, w2, x) w2*x(arg1)*x(arg2);
                    potential_funcs = [potential_funcs, potential_func1, potential_func2];
               end
           end
       end
       

       
    end  %cliques
    % Dense
    
    
    % Exact

end