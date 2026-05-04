
% =============================
% MUTATION STEP (DIFFUSION)
% =============================
function S_new = mutation_step(S, mu)
    N = length(S);
    S_new = S;

    for i = 2:N-1
        lap = S(i+1) - 2*S(i) + S(i-1);

        % Adaptive mutation (optional enhancement)
        mu_local = mu * (1 + abs(lap)/3);

        if rand < mu_local
            S_new(i) = mod(S(i) + sign(lap), 4);
        end
    end
end