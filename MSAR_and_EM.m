%%
% Simulation
% Transition probabilities
p11 = 0.9;
p22 = 0.7;

P = [p11, 1-p11; 1-p22, p22];

% Parameters of 2 regimes
a = [0.7; -0.5];
b = [0.6; 0.6];
sig = [1; 4];

% Initial probabilities
p1 = (1-p11)/(2-p11-p22);
p2 = (1-p22)/(2-p11-p22);

T = 500;
y = zeros(T,1);
y(1) = normrnd(0,50);
s = zeros(T,1);

if rand <= p1
    s(1) = 1;
else
    s(1) = 2;
end

for t = 2:T
    if rand <= P(s(t-1),s(t-1))
        s(t) = s(t-1);
    else
        s(t) = 3-s(t-1);
    end
    y(t) = a(s(t)) + b(s(t))*y(t-1) + normrnd(0,sig(s(t)));
end

y = y(100:end);
figure;
plot(y);
%%
y = log(Value(2:end)./Value(1:end-1));

% Estimation
S = 50;    % number of iterations
para = zeros(8,S);
f_prob = zeros(2,length(y)-1);
u_prob = zeros(2,length(y));

% Initialization
u_prob(:,1) = [0.5; 0.5];
para(:,1) = [1; -1; 0.5; -0.5; 1; 3; 0.5; 0.5];

for s = 2:S
    for t = 1:length(y)-1
        y_used = [y(t); y(t+1)];
        f_prob(:,t) = filter_prob(y_used, u_prob(:,t), para(:,s-1));
        u_prob(:,t+1) = update_prob(f_prob(:,t), para(:,s-1));
    end
    s_prob = smooth_prob(f_prob, u_prob(:,1:end-1), para(:,s-1));
    para(7:8,s) = transition_prob(s_prob, f_prob, u_prob, para(:,s-1));
    para(5:6,s) = variance(y, para(:,s-1), s_prob);
    coef = AR_coefficient(y, s_prob)';
    para(3:4,s) = coef(:,2);
    para(1:2,s) = coef(:,1);
    u_prob(:,1) = s_prob(:,1);
end

% Visualisation
% The smoothed and filtering probabilities
figure;
subplot(2,1,1);
plot(s_prob(1,:));
xlim([0,length(s_prob(1,:))]);
ylim([0,1]);
title('smoothed probabilites');
subplot(2,1,2);
plot(f_prob(1,:));
xlim([0,length(s_prob(1,:))]);
ylim([0,1]);
title('filtering probabilities');
%%
% Final parameters
final_para = para(:,end);
fprintf('True intercepts of 2 regimes: %2.1f (1st regime), and %2.1f (2nd regime)\n', a);
fprintf('Estimated intercepts of 2 regimes: %2.3f (1st regime), and %2.3f (2nd regime)\n', final_para(1:2));
fprintf('True slopes of 2 regimes: %2.1f (1st regime), and %2.1f (2nd regime)\n', b);
fprintf('Estimated slopes of 2 regimes: %2.3f (1st regime), and %2.3f (2nd regime)\n', final_para(3:4));
fprintf('True standard deviations of 2 regimes: %2.1f (1st regime), and %2.1f (2nd regime)\n', sig);
fprintf('Estimated standard deviations of 2 regimes: %2.3f (1st regime), and %2.3f (2nd regime)\n', final_para(5:6));
fprintf('Transition probabilities: %2.1f (stay in 1st regime), and %2.1f (stay in 2nd regime)\n', [p11; p22]);
fprintf(['Estimated transition probabilities: %2.3f (stay in 1st regime), and %2.3f (stay in 2nd regime)\n'], final_para(7:8));

figure;
subplot(4,2,1);
plot(1:S, para(1,:), 'Linewidth', 1.5); hold on
plot(1:S, repmat(a(1),[1,S]), 'r-', 'Linewidth', 1.5);
title('Intercept, regime 1');

subplot(4,2,2);
plot(1:S, para(2,:), 'Linewidth', 1.5); hold on
plot(1:S, repmat(a(2),[1,S]), 'r-', 'Linewidth', 1.5);
title('Intercept, regime 2');

subplot(4,2,3);
plot(1:S, para(3,:), 'Linewidth', 1.5); hold on
plot(1:S, repmat(b(1),[1,S]), 'r-', 'Linewidth', 1.5);
title('Slope, regime 1');

subplot(4,2,4);
plot(1:S, para(4,:), 'Linewidth', 1.5); hold on
plot(1:S, repmat(b(2),[1,S]), 'r-', 'Linewidth', 1.5);
title('Slope, regime 2');

subplot(4,2,5);
plot(1:S, para(5,:), 'Linewidth', 1.5); hold on
plot(1:S, repmat(sig(1),[1,S]), 'r-', 'Linewidth', 1.5);
title('Standard Deviation, regime 1');

subplot(4,2,6);
plot(1:S, para(6,:), 'Linewidth', 1.5); hold on
plot(1:S, repmat(sig(2),[1,S]), 'r-', 'Linewidth', 1.5);
title('Standard Deviation, regime 2');

subplot(4,2,7);
plot(1:S, para(7,:), 'Linewidth', 1.5); hold on
plot(1:S, repmat(p11,[1,S]), 'r-', 'Linewidth', 1.5);
title('Transition probability from state 1 to state 1');

subplot(4,2,8);
plot(1:S, para(7,:), 'Linewidth', 1.5); hold on
plot(1:S, repmat(p22,[1,S]), 'r-', 'Linewidth', 1.5);
title('Transition probability from state 2 to state 2');
legend('Estimated value', 'True value');