% =============================
% Entropy
% =============================
function H = entropy_calc(S)
    counts = histcounts(S, 0:4);
    probs = counts / sum(counts);
    probs = probs(probs > 0);
    H = -sum(probs .* log(probs));
end