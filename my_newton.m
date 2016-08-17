function theta = my_newton(theta_0,SS,n,v,u,adj_v,adj_u)
    
    adj_v(u) = 0;
    adj_u(v) = 0;
    union_adj = adj_v | adj_u;
    aux_features = union_adj;
    aux_features(v) = 1;
    aux_features(u) = 1;
    aux_features = logical(aux_features);


    MaxIter = 100;

    for iter = 1:MaxIter
        [Z, ESS, H] = computeZ(theta_0, aux_features);

        grad = (SS - n*ESS)';
        delta_theta = -grad/H;
        %%%% check stop criterion
        lambda2 = grad*H^(-1)*grad;
        epsilon = 0.001;
        if (lambda2 <= epsilon * n) 
            return;
        end
        %%%% compute step size
        alpha = 0.49;
        beta = 0.7;

        t = 1;
        current_log_likelihood = log_likelihood(SS, theta, adj_v, adj_u, Z);
        while true
            if log_likelihood(SS, theta + delta_theta, adj_v, adj_u) < current_log_likelihood + alpha*t*grad'*delta_theta
                t = beta*t;
            else
                break;
            end
        end
        gamma = t;
        %%%%
        theta = theta + gamma * delta_theta;
    end    
end