%% Extract data
time_pq = out.PQ.time;
pq_system_d = out.PQ.signals(1).values(:,1);
pq_system_q = out.PQ.signals(1).values(:,2);
pq_target_d = out.PQ.signals(2).values(:,1);
pq_target_q = out.PQ.signals(2).values(:,2);

time_thd = out.thd.time;
thd_a = out.thd.signals(1).values(:,1);
thd_b = out.thd.signals(1).values(:,2);
thd_c = out.thd.signals(1).values(:,3);

%% 1. Steady-state error
ss_window = (time_pq > 0.25) & (time_pq < 0.55);
ss_p_system = pq_system_d(ss_window);
ss_p_target = pq_target_d(ss_window);

mean_actual = mean(ss_p_system);
mean_target = mean(ss_p_target);
ss_error = mean_actual - mean_target;

fprintf('Steady-state error (0.25s–0.55s): %.4f W\n', ss_error);

%% 2. Response time
dP_ref = diff(pq_target_d);
change_indices_d = find(abs(dP_ref) > 1);
response_times_d = [];

for i = 1:length(change_indices_d)
    idx = change_indices_d(i);
    t_change = time_pq(idx);
    new_target = pq_target_d(idx + 1);
    tolerance = 0.05 * abs(new_target); % 2% band

    for j = idx+1:length(time_pq)
        if all(abs(pq_system_d(j:end) - new_target) < tolerance)
            t_settle = time_pq(j);
            response_times_d(end+1) = t_settle - t_change;
            break;
        end
    end
end

fprintf('Mean response time: %.2f ms\n', mean(response_times_d) * 1000);

%% 3. Total harmonic distortion
thd_window = (time_thd > 0.25) & (time_thd < 0.55);
thd_a_window = thd_a(thd_window);
thd_b_window = thd_b(thd_window);
thd_c_window = thd_c(thd_window);

mean_thd = (mean(thd_a_window) + mean(thd_b_window)+ mean(thd_c_window)) / 3;

fprintf('Total harmonic distortion (0.25s–0.55s): %.4f \n', mean_thd);