function[f_prob] = filter_prob(y, updating_prob, para)
    % The likelihood given each regime
    f1 = normpdf(y(2)-para(1)-para(3)*y(1),0,para(5));
    f2 = normpdf(y(2)-para(2)-para(4)*y(1),0,para(6));
    eta = [f1; f2];
    % The filtering probabilities
    f_prob = (updating_prob.*eta)/(ones(1,2)*(updating_prob.*eta));
end