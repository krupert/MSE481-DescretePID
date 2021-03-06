%MSE 481 - Kieran Rupert
clc;
clear all;

%System Parameters
J = 0.01; %kg*m^2
b = 0.1; %N*m*s
K = 0.01; %V/rad*sec
R = 1; %ohm
L = 0.5; % Henry

% Laplace domain
Gs = tf(K, [(J*L) (J*R+b*L) (K^2 + b*R)]);

% Time Domain
% Instructions unclear...this might be unneccessary
[b,a]=residue(Gs.Numerator{1},Gs.Denominator{1});
temp=0;
syms s t
for i=1:numel(a)
temp=temp+(b(i)/(s+a(i)));
end
timeDomain=ilaplace(temp,t);

% Sample period
Ts = 0.05;

% Discrete (Z domain)
Gz = c2d(Gs, Ts, 'zoh');

% PID values
Kp = 1;
Ki = 0;
Kd = 0;
% Controller (s domain)
Cs = tf([Kd Kp Ki],[1 0]);

% Controller (z domain)
Cz = c2d(Cs, Ts, 'zoh');

closed_loop = Gz/(1+Gz*Cz)

% We're told to use "stairs", 
% but I don't know how to use that so...
fig1 = figure(1);
step(closed_loop, 10);

% PID values
Kp = 100;
Ki = 200;
Kd = 10 ;
% Controller (s domain)
Cs = tf([Kd Kp Ki],[1 0]);



% We're told to use "stairs", 
% but I don't know how to use that so...
fig2 = figure(2);
Ts_list = [0.05 0.008];% 0.005 0.002 0.001];

for i=1:length(Ts_list)
    Ts = Ts_list(i)
    Gz = c2d(Gs, Ts, 'zoh');
    Cz = c2d(Cs, Ts, 'Tustin');
    closed_loop = Gz/(1+Gz*Cz);
    subplot(length(Ts_list),1,i)
    title(Ts);
    step(closed_loop, 10);
end
