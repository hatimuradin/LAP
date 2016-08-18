function theta = my_newton(theta_0,SS,n,v,u,adj_v,adj_u,d)
    
    MaxIter = 100;
    theta = theta_0;
    
    for iter = 1:MaxIter
        iter
        logZ = compute_logZ(theta, u, v, adj_u, adj_v, length(adj_v));
        [ESS, CovSS] = computeESS(theta, u, v, adj_v, adj_u, d, logZ);
        grad = (SS - n*ESS)';
        H = -n*CovSS;
%         vpa(H);
        delta_theta = -grad'/H;
        %%%% check stop criterion
        lambda2 = -grad'*H^(-1)*grad;
        epsilon = 0.001;
        if (lambda2 <= epsilon * n) 
            return;
        end
        %%%% compute step size
        alpha = 0.49;
        beta = 0.7;

        t = 1;
        current_log_likelihood = log_likelihood(SS, theta, u, v, adj_v, adj_u, d, n, logZ);
        while true
            if log_likelihood(SS, theta + delta_theta,u, v, adj_v, adj_u, d, n, logZ) < current_log_likelihood + alpha*t*grad'*delta_theta'
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