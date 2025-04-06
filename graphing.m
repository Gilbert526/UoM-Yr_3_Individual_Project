% Data Extration
time_pq = out.PQ.time;
pq_system_d = out.PQ.signals(1).values(:,1);  % 第一路信号的X分量
pq_system_q = out.PQ.signals(1).values(:,2);  % 第一路信号的Y分量
pq_target_d = out.PQ.signals(2).values(:,1);  % 第二路信号的X分量
pq_target_q = out.PQ.signals(2).values(:,2);  % 第二路信号的Y分量

time_idq = out.Idq.time;
idq_system_d = out.Idq.signals(1).values(:,1);  % 第一路信号的X分量
idq_system_q = out.Idq.signals(1).values(:,2);  % 第一路信号的Y分量
idq_target_d = out.Idq.signals(2).values(:,1);  % 第二路信号的X分量
idq_target_q = out.Idq.signals(2).values(:,2);  % 第二路信号的Y分量

time_target = out.PQ_Target.time;
target_d = out.PQ_Target.signals(1).values(:,1);  % 第一路信号的X分量
target_q = out.PQ_Target.signals(1).values(:,2);  % 第一路信号的Y分量


% Image Generation
figure(1);
set(gcf, 'Color', 'white', 'Position', [100 100 800 400]); % 调整画布尺寸
plot(time_pq, pq_system_d, 'r', 'LineWidth', 1); % 第一路X分量（蓝色实线）
hold on;
plot(time_pq, pq_target_d, 'm--', 'LineWidth', 0.5); % 第二路X分量（红色虚线）
plot(time_pq, pq_system_q, 'b', 'LineWidth', 1); % 第一路X分量（蓝色实线）
plot(time_pq, pq_target_q, 'c--', 'LineWidth', 0.5); % 第二路X分量（红色虚线）
hold off;
xlabel('Time (s)', 'FontSize', 11, 'Interpreter', 'latex');
ylabel('Power (VA)', 'FontSize', 11, 'Interpreter', 'latex');
title('Output Power vs. Time', 'FontSize', 12, 'Interpreter', 'latex');
legend('Output Active Power', 'Output Reactive Power', 'Target Active Power', 'Target Reactive Power', 'Interpreter', 'latex', 'Location', 'best');
grid on;
set(gcf, 'Color', 'white'); % 设置背景为白色
set(gca, 'FontSize', 10);   % 调整坐标轴字体
%ylim([-1500, 3000])

exportgraphics(gcf, 'LaTeX\Results\pq.pdf', 'ContentType', 'vector');

figure(2);
set(gcf, 'Color', 'white', 'Position', [100 100 800 400]); % 调整画布尺寸
plot(time_idq, idq_system_d, 'r', 'LineWidth', 1); % 第一路X分量（蓝色实线）
hold on;
plot(time_idq, idq_target_d, 'm--', 'LineWidth', 0.5); % 第二路X分量（红色虚线）
plot(time_idq, idq_system_q, 'b', 'LineWidth', 1); % 第一路X分量（蓝色实线）
plot(time_idq, idq_target_q, 'c--', 'LineWidth', 0.5); % 第二路X分量（红色虚线）
hold off;
xlabel('Time (s)', 'FontSize', 11, 'Interpreter', 'latex');
ylabel('Current (A)', 'FontSize', 11, 'Interpreter', 'latex');
title('Output Current vs. Time', 'FontSize', 12, 'Interpreter', 'latex');
legend('Output Current Id', 'Output Current Iq', 'Reference Current Id', 'Reference Current Iq', 'Interpreter', 'latex', 'Location', 'best');
grid on;
set(gcf, 'Color', 'white'); % 设置背景为白色
set(gca, 'FontSize', 10);   % 调整坐标轴字体
%ylim([-1, 6])

exportgraphics(gcf, 'LaTeX\Results\idq.pdf', 'ContentType', 'vector');

figure(3);
set(gcf, 'Color', 'white', 'Position', [100 100 800 400]); % 调整画布尺寸
plot(time_target, target_d, 'Color', [0.95, 0.2, 0.1], 'LineStyle', '-', 'LineWidth', 2); % 第一路X分量（蓝色实线）
hold on;
plot(time_target, target_q, 'Color', [0.1, 0.25, 0.84], 'LineStyle', '-', 'LineWidth', 2); % 第二路X分量（红色虚线）
hold off;
xlabel('Time (s)', 'FontSize', 11, 'Interpreter', 'latex');
ylabel('Power (VA)', 'FontSize', 11, 'Interpreter', 'latex');
title('Target Output Power Profile', 'FontSize', 12, 'Interpreter', 'latex');
legend('Target Active Power', 'Target Reactive Power', 'Interpreter', 'latex', 'Location', 'best');
grid on;
set(gcf, 'Color', 'white'); % 设置背景为白色
set(gca, 'FontSize', 10);   % 调整坐标轴字体
ylim([-1500, 3000])

exportgraphics(gcf, 'LaTeX\Results\target.pdf', 'ContentType', 'vector');
