%% Shock loading calcs an ddynamic response of the rocket body and parachute system after deployment


%% 
clear
clc
close all

%% Define variables


L = 12;
Es = 2.7e9;
[T, A, P, rho] = atmosisa(10000);
g = 9.81;
D_d = 0.9144;
D_m = 6.096;
A_d = pi/4 * (D_d^2);
A_m = pi/4 * (D_m^2);
A_b = 0.01824;
Cdp = 0.97;
Cdb = 0.54;
mp= 1.47;
mb = 38;
V_0 = 75;
D_sc = 0.;
L_sc = 0.0254;
W_sc = 0.002;
A_sc = L_sc*W_sc;
%A_sc = pi*D_sc^2/4;
k = Es*A_sc/L;

open('POstDeployment_ShockLoad_Calcs.slx');

%%

plot(out.tout, out.ShockLoad, "LineWidth", 1.5)
xlabel("Time, t", "Interpreter","latex", "FontSize", 13)
ylabel("Load on the parachute cords, N", "Interpreter","latex", "FontSize", 13)
set(gca,'FontSize',13, "TickLabelInterpreter", "Latex")
grid on