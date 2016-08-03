

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
    P(t) = exp( sum(u.*x) + sum(sum(w .* (x' * x) .* adj)) );
    
end

P = P./sum(P);
C = cumsum(P);

numSamples = 100;
allSamples = zeros(numSamples, totalFeatures);

for i=1:numSamples
    s = rand;
    allSamples(i,:) = allOutcomes(find(C >= s, 1),:);
end


for i=1:totalFeatures
   for j=i:totalFeatures 
       
   end
end