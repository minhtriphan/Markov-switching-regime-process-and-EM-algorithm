function[P] = transition_prob(smoothing_prob, filtering_prob, updating_prob, para)
    num1 = sum((smoothing_prob(1,2:end).*filtering_prob(1,1:end-1))./updating_prob(1,2:end-1))*para(7);
    num2 = sum((smoothing_prob(2,2:end).*filtering_prob(2,1:end-1))./updating_prob(2,2:end-1))*para(8);
    de1 = sum(smoothing_prob(1,1:end-1));
    de2 = sum(smoothing_prob(2,1:end-1));
    p00 = num1/de1;
    p11 = num2/de2;
    P = [p00; p11];
end