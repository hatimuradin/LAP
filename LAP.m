
% digits(100);

graphHeight = 4;
graphWidth = 4;

totalFeatures = graphHeight * graphWidth;


adj = zeros(totalFeatures);
for i=1:totalFeatures
    for j=1:totalFeatures
       if (i+1==j && rem(i,graphWidth)~=0)
           adj(i,j)=1;
       end
       if (i-1==j && rem(j,graphWidth)~=0)
           adj(i,j)=1;
       end
       if i==j+graphHeight || i==j-graphHeight
           adj(i,j)=1;
       end
    end
end


x = zeros(1,totalFeatures);
P = zeros(1,2^totalFeatures);
allOutcomes = zeros(2^totalFeatures,totalFeatures);


w = rand(totalFeatures,totalFeatures);
u = rand(1,totalFeatures);

for t=1:2^totalFeatures
    if ~any(x == 0)
        x = zeros(1,totalFeatures);
        allOutcomes(t,:) = x;
    else
        i = find(x == 0, 1);
        x(1:i-1) = 0;
        x(i) = 1;
        allOutcomes(t,:) = x;
    end 
    P(t) = exp( sum(u.*x) + sum(sum(triu(w .* (x' * x) .* adj))) );
    
end

P = P./sum(P);
C = cumsum(P);

numSamples = 100;
allSamples = zeros(numSamples, totalFeatures);

for i=1:numSamples
    s = rand;
    allSamples(i,:) = allOutcomes(find(C >= s, 1),:);
end


est_w = zeros(totalFeatures, totalFeatures);
est_w_num = zeros(totalFeatures, totalFeatures);
est_u = zeros(1,totalFeatures);
est_u_num = zeros(1,totalFeatures);

cliques = cell(0);

%%%% fill cliques and cliques_params
for i=1:totalFeatures
    for j=i:totalFeatures
       if adj(i,j) == 1
          cliques = [cliques, [i,j]];
       end
    end
end
%%%%


for c=1:length(cliques)
    %%%% Newton
    v = cliques{c}(1);
    u = cliques{c}(2);
    SS = computeSS(v, u, adj(v,:), adj(u,:),allSamples);
    
    theta_0 = zeros(size(SS));
    theta = my_newton(theta_0, SS, size(allSamples, 1), v, u, adj(v,:), adj(u,:),size(allSamples,2));
    est_w(v,u) = est_w(v,u) + theta(1);
    est_w_num(v,u) = est_w_num(v,u)+1;
    est_u(v) = est_u(v) + theta(2);
    est_u_num(v) = est_u_num(v)+1;
    est_u(u) = est_u(u) + theta(3);
    est_u_num(u) = est_u_num(u) + 1;
    %%%%
end
%%%%
%%%% parameter averaging
est_w_num(est_w_num == 0) = 1;
est_u_num(est_u_num == 0) = 1;
est_w = est_w ./ est_w_num;
est_u = est_u ./ est_u_num;