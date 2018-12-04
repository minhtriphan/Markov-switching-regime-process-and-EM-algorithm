function[AR_coef] = AR_coefficient(y, smoothing_prob)
    yt = y(2:end);
    zt = [ones(length(yt),1) y(1:end-1)];
    % For the regime 1
    yt1 = yt.*sqrt(smoothing_prob(1,:)');
    zt1 = zt.*repmat(sqrt(smoothing_prob(1,:))',[1,2]);
    beta1 = (zt1'*zt1)^(-1)*zt1'*yt1;
    % For the regime 2
    yt2 = yt.*sqrt(smoothing_prob(2,:)');
    zt2 = zt.*repmat(sqrt(smoothing_prob(2,:))',[1,2]);
    beta2 = (zt2'*zt2)^(-1)*zt2'*yt2;
    AR_coef = [beta1, beta2];
end