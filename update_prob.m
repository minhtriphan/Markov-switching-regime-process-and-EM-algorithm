function[u_prob] = update_prob(filtering_prob, para)
    P = [para(7), 1-para(7); (1-para(8)), para(8)];
    u_prob = P*filtering_prob;
end