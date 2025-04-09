%%%%%%%%%%%%%%%%%%% Frequency Plot Generator for Grid-tied Inverter Simulation %%%%%%%%%%%%%%%%%%%
%% To be ran after the model "GridTiedInverterNew.slx" has successfully outputted results.
%
%% Created by Geping Wang 11053446
%
%% Description: This script plots the Frequency analysis graphs used in the report
%  The creation of part of this script involved the use of generative AI tools including ChatGPT and Deepseek.

%% Data Extration
time_i = out.Iout.time;
i_out_a = out.Iout.signals(1).values(:,1);
i_out_b = out.Iout.signals(1).values(:,2);
i_out_c = out.Iout.signals(1).values(:,3);

%% Set Time Window
t_start = 0.25;
t_end = 0.55;

idx = time_i >= t_start & time_i <= t_end;

time_trim = time_i(idx);
i_trim_a = i_out_a(idx);
i_trim_b = i_out_b(idx);
i_trim_c = i_out_c(idx);

%% Image Generation
% Up to 1 kHz
figure(1);
%plot(time_trim, i_trim_b, 'r', 'LineWidth', 1);
thd(i_trim_b, f_sample);
%set(gca, 'XScale', 'log');
%set(gca, 'YScale', 'linear');
set(gcf, 'Color', 'white', 'Position', [100 100 800 400]);
xlabel('Frequency (kHz)', 'FontSize', 11, 'Interpreter', 'latex');
ylabel('Power (dB)', 'FontSize', 11, 'Interpreter', 'latex');
title('Total Haromnic Distortion', 'FontSize', 12, 'Interpreter', 'latex');
legend('Fundamental', 'Harmonics', 'Others', 'Interpreter', 'latex', 'Location', 'best');
grid on;
set(gcf, 'Color', 'white');
set(gca, 'FontSize', 10);
xlim([0, 1]);
ylim([-100, 15]);

x = [0.3 0.18];
y = [0.9 0.9];
annotation('textarrow',x,y,'String','Fundamental at 50 Hz ', 'FontSize', 11, 'Interpreter', 'latex')

exportgraphics(gcf, 'LaTeX\Results\thdlow.pdf', 'ContentType', 'vector');

% Up to 20 kHz
figure(2);
%plot(time_trim, i_trim_b, 'r', 'LineWidth', 1);
thd(i_trim_b, f_sample);
set(gca, 'XScale', 'log');
%set(gca, 'YScale', 'linear');
set(gcf, 'Color', 'white', 'Position', [100 100 800 400]);
xlabel('Frequency (kHz)', 'FontSize', 11, 'Interpreter', 'latex');
ylabel('Power (dB)', 'FontSize', 11, 'Interpreter', 'latex');
title('Total Haromnic Distortion', 'FontSize', 12, 'Interpreter', 'latex');
legend('Fundamental', 'Harmonics', 'Others', 'Interpreter', 'latex', 'Location', 'best');
grid on;
set(gcf, 'Color', 'white');
set(gca, 'FontSize', 10);
xlim([0, 20]);
ylim([-100, 15]);

exportgraphics(gcf, 'LaTeX\Results\thdhigh.pdf', 'ContentType', 'vector');