
clc; clear; close all;

% -----------------------------
% PARAMETERS
% -----------------------------
N = 100;          % DNA length
steps = 200;      % number of time steps
mu = 0.2;         % mutation strength
dt = 0.1;         % time step
time = (0:steps-1)*dt;

% -----------------------------
% INITIAL DNA
% -----------------------------
S = randi([0,3], 1, N);

% Store history
hist = zeros(steps, N);

% -----------------------------
% EVOLUTION LOOP
% -----------------------------
for step = 1:steps
    S_new = mutation_step(S, mu);
    S = selection(S, S_new);
    hist(step, :) = S;
end

% -----------------------------
% ENTROPY & GC CONTENT
% -----------------------------
ent = zeros(steps,1);
gc_vals = zeros(steps,1);

for i = 1:steps
    ent(i) = entropy_calc(hist(i,:));
    gc_vals(i) = gc_content(hist(i,:));
end

% -----------------------------
% CONVERGENCE ERROR
% -----------------------------
error_vals = zeros(steps-1,1);
for i = 1:steps-1
    error_vals(i) = norm(hist(i+1,:) - hist(i,:), 2);
end

% -----------------------------
% PLOT 1: ENTROPY vs TIME
% -----------------------------
figure;
plot(time, ent, 'LineWidth', 1.5);
xlabel('Time'); ylabel('Entropy');
title('Entropy Decay Over Time');
grid on;

% -----------------------------
% PLOT 2: GC CONTENT
% -----------------------------
figure;
plot(time, gc_vals, 'LineWidth', 1.5); hold on;
yline(0.4,'--'); yline(0.6,'--');
xlabel('Time'); ylabel('GC Content');
title('GC Content Evolution');
grid on;

% -----------------------------
% PLOT 3: DNA HEATMAP
% -----------------------------
figure;
imagesc(hist);
xlabel('Position'); ylabel('Time Step');
title('DNA Evolution Heatmap');
colorbar;

% -----------------------------
% PLOT 4: SURFACE PLOT
% -----------------------------
figure;
[X,Y] = meshgrid(1:N, time);
surf(X, Y, hist);
xlabel('Position'); ylabel('Time'); zlabel('Base Value');
title('Surface Plot of DNA Evolution');
shading interp; view(45,30); colorbar;

% -----------------------------
% PLOT 5: SMOOTHED SURFACE
% -----------------------------
hist_smooth = movmean(hist, 5, 2);

figure;
surf(X, Y, hist_smooth);
xlabel('Position'); ylabel('Time'); zlabel('Smoothed Value');
title('Smoothed Surface Plot');
shading interp; view(45,30); colorbar;

% -----------------------------
% PLOT 6: CONVERGENCE ERROR
% -----------------------------
figure;
semilogy(time(1:end-1), error_vals, 'LineWidth', 1.5);
xlabel('Time'); ylabel('Error (log scale)');
title('Convergence to Steady State');
grid on;

% -----------------------------
% STEADY STATE TIME
% -----------------------------
tol = 1e-3;
idx = find(error_vals < tol, 1);

if ~isempty(idx)
    fprintf('Steady state reached at time = %.4f\n', time(idx));
else
    fprintf('Steady state not reached within given steps.\n');
end






