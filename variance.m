function[SIG] = variance(y, para, smoothing_prob)
    de = sum(smoothing_prob, 2);
    num1 = sum(((y(2:end)-para(1) - para(3)*y(1:end-1)).^2).*smoothing_prob(1,:)');
    num2 = sum(((y(2:end)-para(2) - para(4)*y(1:end-1)).^2).*smoothing_prob(2,:)');
    sig1 = num1/de(1);
    sig2 = num2/de(2);
    SIG = sqrt([sig1; sig2]);
end