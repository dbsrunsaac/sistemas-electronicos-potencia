% ===============================================================
% Generación de señales trifásica y hexafásica
% ===============================================================

clc; clear; close all;

% Parámetros generales
f = 60;             % Frecuencia (Hz)
A = 1;              % Amplitud
t = 0:1e-4:0.05;    % Tiempo (0 a 50 ms)

%% -------------------- Señal Trifásica --------------------
% Definición de los ángulos de fase en grados
fase_trifasica = [0, -120, 120];

% Generación de las tres señales
s1 = A * sin(2*pi*f*t + deg2rad(fase_trifasica(1)));
s2 = A * sin(2*pi*f*t + deg2rad(fase_trifasica(2)));
s3 = A * sin(2*pi*f*t + deg2rad(fase_trifasica(3)));

% Gráfica de las señales trifásicas
figure('Name', 'Señal Trifásica');
plot(t, s1, 'r', 'LineWidth', 1.5); hold on;
plot(t, s2, 'g', 'LineWidth', 1.5);
plot(t, s3, 'b', 'LineWidth', 1.5);
grid on;
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Sistema Trifásico (60 Hz)');
legend('Fase A', 'Fase B', 'Fase C', 'Location', 'best');
axis([0 0.05 -1.2 1.2]);

%% -------------------- Señal Hexafásica --------------------
% Definición de los ángulos de fase separados 30°
fase_hexafasica = 0:60:300;   % Seis fases: 0°, 30°, 60°, 90°, 120°, 150°

% Generación de las seis señales
hexafasica = zeros(length(fase_hexafasica), length(t));
for k = 1:length(fase_hexafasica)
    hexafasica(k,:) = A * sin(2*pi*f*t + deg2rad(fase_hexafasica(k)));
end

% Gráfica de las señales hexafásicas
figure('Name', 'Señal Hexafásica');
hold on;
colores = lines(6); % Colores distintos para cada señal
for k = 1:6
    plot(t, hexafasica(k,:), 'Color', colores(k,:), 'LineWidth', 1.5);
end
grid on;
xlabel('Tiempo [s]');
ylabel('Amplitud');
title('Sistema Hexafásico (60 Hz, separación 30°)');
legend('0°','30°','60°','90°','120°','150°', 'Location', 'best');
axis([0 0.05 -1.2 1.2]);
