%MSE 481 - Kieran Rupert

%System Parameters
J = 0.01; %kg*m^2
b = 0.1; %N*m*s
K = 0.01; %V/rad*sec
R = 1; %ohm
L = 0.5; % Henry

% Laplace domain
G = tf(K, [(J*L) (J*R+b*L) (K^2 + b*R)])

% Time Domain
% Instructions unclear...this might be unneccessary
[b,a]=residue(G.Numerator{1},G.Denominator{1});
temp=0;
syms s t
for i=1:numel(a)
temp=temp+(b(i)/(s+a(i)));
end
timeDomain=ilaplace(temp,t)

% Sample period
Ts = 0.05;

% Discrete (Z domain)
Gz = c2d(G, Ts, 'zoh')