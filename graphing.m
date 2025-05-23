%%%%%%%%%%%%%%%%%%% Power & Current Plot Generator for Grid-tied Inverter Simulation %%%%%%%%%%%%%%%%%%%
%% To be ran after the model "GridTiedInverterNew.slx" has successfully outputted results.
%
%% Created by Geping Wang 11053446
%
%% Description: This script plots the Power and Current graphs used in the report
%  The creation of part of this script involved the use of generative AI tools including ChatGPT and Deepseek.

%% Data Extration
% Power
time_pq = out.PQ.time;                          % Time axis of PQ
pq_system_d = out.PQ.signals(1).values(:,1);    % Output Active Power
pq_system_q = out.PQ.signals(1).values(:,2);    % Output Reactive Power
pq_target_d = out.PQ.signals(2).values(:,1);    % Target Active Power
pq_target_q = out.PQ.signals(2).values(:,2);    % Target Reactive Power

% Current
time_idq = out.Idq.time;                        % Time axis of current
idq_system_d = out.Idq.signals(1).values(:,1);  % Output Current on d axis
idq_system_q = out.Idq.signals(1).values(:,2);  % Output Current on q axis
idq_target_d = out.Idq.signals(2).values(:,1);  % Target Current on d axis
idq_target_q = out.Idq.signals(2).values(:,2);  % Target Current on q axis

% Target Power
time_target = out.PQ_Target.time;                   % Time axis of target
target_d = out.PQ_Target.signals(1).values(:,1);    % Target Active Power
target_q = out.PQ_Target.signals(1).values(:,2);    % Target Reactive Power


%% Image Generation
% Plot Power
figure(1);
set(gcf, 'Color', 'white', 'Position', [100 100 800 400]);
plot(time_pq, pq_system_d, 'r', 'LineWidth', 1);
hold on;
plot(time_pq, pq_target_d, 'm--', 'LineWidth', 0.5);
plot(time_pq, pq_system_q, 'b', 'LineWidth', 1);
plot(time_pq, pq_target_q, 'c--', 'LineWidth', 0.5);
hold off;
xlabel('Time (s)', 'FontSize', 11, 'Interpreter', 'latex');
ylabel('Power (VA)', 'FontSize', 11, 'Interpreter', 'latex');
title('Output Power vs. Time', 'FontSize', 12, 'Interpreter', 'latex');
legend('Output Active Power', 'Output Reactive Power', 'Target Active Power', 'Target Reactive Power', 'Interpreter', 'latex', 'Location', 'best');
grid on;
set(gcf, 'Color', 'white');
set(gca, 'FontSize', 10);
%ylim([-1500, 3000])

exportgraphics(gcf, 'LaTeX\Results\pq.pdf', 'ContentType', 'vector');

% Plot Current
figure(2);
set(gcf, 'Color', 'white', 'Position', [100 100 800 400]);
plot(time_idq, idq_system_d, 'r', 'LineWidth', 1);
hold on;
plot(time_idq, idq_target_d, 'm--', 'LineWidth', 0.5);
plot(time_idq, idq_system_q, 'b', 'LineWidth', 1);
plot(time_idq, idq_target_q, 'c--', 'LineWidth', 0.5);
hold off;
xlabel('Time (s)', 'FontSize', 11, 'Interpreter', 'latex');
ylabel('Current (A)', 'FontSize', 11, 'Interpreter', 'latex');
title('Output Current vs. Time', 'FontSize', 12, 'Interpreter', 'latex');
legend('Output Current Id', 'Output Current Iq', 'Reference Current Id', 'Reference Current Iq', 'Interpreter', 'latex', 'Location', 'best');
grid on;
set(gcf, 'Color', 'white');
set(gca, 'FontSize', 10);
%ylim([-1, 6])

exportgraphics(gcf, 'LaTeX\Results\idq.pdf', 'ContentType', 'vector');

% Plot Target Profile
figure(3);
set(gcf, 'Color', 'white', 'Position', [100 100 800 400]);
plot(time_target, target_d, 'Color', [0.95, 0.2, 0.1], 'LineStyle', '-', 'LineWidth', 2);
hold on;
plot(time_target, target_q, 'Color', [0.1, 0.25, 0.84], 'LineStyle', '-', 'LineWidth', 2);
hold off;
xlabel('Time (s)', 'FontSize', 11, 'Interpreter', 'latex');
ylabel('Power (VA)', 'FontSize', 11, 'Interpreter', 'latex');
title('Target Output Power Profile', 'FontSize', 12, 'Interpreter', 'latex');
legend('Target Active Power', 'Target Reactive Power', 'Interpreter', 'latex', 'Location', 'best');
grid on;
set(gcf, 'Color', 'white');
set(gca, 'FontSize', 10);
ylim([-1500, 3000])

exportgraphics(gcf, 'LaTeX\Results\target.pdf', 'ContentType', 'vector');
