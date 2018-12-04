function[s] = smooth_prob(filtering_prob, updating_prob, para)
    T = length(filtering_prob(1,:));
    s = zeros(2,T);
    s(:,end) = filtering_prob(:,end);
    P = [para(7), (1-para(7)); (1-para(8)), para(8)];
    for t = T:-1:2
        s(:,t-1) = filtering_prob(:,t-1).*(P'*(s(:,t)./updating_prob(:,t)));
    end
end