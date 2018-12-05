# Markov-switching-regime-process-and-EM-algorithm
- In this section, I perform the Markov switching regime to AR(1) process with homoskedasticity.
- The model is estimated using Maximum Likelihood estimator and EM algorithm to implement optimization.
- Filtering probability is P(s(t) = i|Y(t), parameters) which is the probability of each state at hand given all information until that time.
- Updating probability is P(s(t+1) = i|Y(t), parameters) which is the probability of forecasting states.
- Smoothed probability is P(s(t) = i|Y, parameters) which is the probability of each state given the whole sample.
- The updating probabilities are initialized by the unconditional probabilities, then, update the filtering probabilities by function 'filter_prob'. The updating probability of each regime in the next period is updated using the 'update_prob' function.
- After having filtering and updating probabilities for whole sample, smoothed probabilities are computed using the backward-updating algorithm developed by Kim (1994). This algorithm is realized by the function 'smooth_prob'.
- Parameters are updated iteratively using 'transition_prob', 'variance' and 'AR_coefficient' functions, sequentially.
- Simulation study is designed, detail could be found in the beginning of 'MSAR_and_EM' file.
- Results are visualized by 'Smoothed_and_Filtering_Probabilities' and 'Estimated_and_True_Values' pictures. As we may see, the estimated and true values are pretty close, showing that the algorithm produces very good estimates.
- One more point was revealed is the EM algorithm converges so fast (by looking at the 'Estimated_and_True_Values' pictures).
- Empirical application: DAX log-daily-return is used. Results of filtering and smoothed probabilities are shown in 'DAX' picture.
