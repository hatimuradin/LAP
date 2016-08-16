function theta = my_newton(theta_0,SS,n,v,u,adj_v,adj_u)
    
    [Z, ESS, H] = computeZ(SS, theta, adj_v, adj_u);  
    
    grad = (SS - n*ESS)';
    delta_theta = -grad/H;
    %%%% check stop criterion
    lambda2 = grad*H^(-1)*grad;
    epsilon = 0.001;
    if (lambda2 <= epsilon) 
        return;
    end
    %%%% compute step size
    alpha = rand()/2;
    betha = rand();
    
    t = 1;
    while (likelihood(SS, theta + delta_theta, adj_v, adj_u) < likelihood(SS, theta, adj_v, adj_u) + alpha*t*grad'*delta_theta)
        t = betha*t;
    end
    gamma = t;
    %%%%
    theta = theta + gamma * delta_theta;
    
end