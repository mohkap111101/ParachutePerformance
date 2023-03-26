clear
clc
close all

load ParachuteData.mat
load ParachuteDataCoeffs.mat

p = polyfit(ReefingLineRatio, ReefingRatio, 7);

x1 = linspace(ReefingLineRatio(1), ReefingLineRatio(end), 1000);
y1 = polyval(p, x1);

figure()
plot(ReefingLineRatio, ReefingRatio, "o")
hold on
plot(x1, y1)

Cd_p = 0.97;
D_0 = 6.096;
A_p = (D_0^2)/4 * pi;

DragArea_dis = Cd_p*A_p;

DryMass = 46;
Desc_V = 35;

D = DryMass*9.81;

DragArea_reefed = D/(0.5 * 1.2 * Desc_V^2);

ReefingRatio = DragArea_reefed./DragArea_dis;

f = @(x) p(1)*x^7 + p(2)*x^6 + p(3)*x^5 + p(4)*x^4 + p(5)*x^3 + p(6)*x^2 + p(7)*x^1 + p(8)*x^0 - ReefingRatio;

tau = fzero(f, 0.4);

D_r = tau*D_0;

Area_reefed = D_r^2/4 * pi;

Cd_r = DragArea_reefed./Area_reefed;

n = 2.5;
V_r = 70;
V_d = Desc_V;

t_f1 = n*D_0/V_r * (DragArea_reefed/DragArea_dis)^0.5;
t_f2 = n*D_0/V_r * ((DragArea_dis - DragArea_reefed)/DragArea_dis)^0.5;


ti = 0.5*D_0/V_d;
DragArea_i = DragArea_reefed;

eta = (0./DragArea_reefed)^0.5;

t = linspace(0, t_f1, 1000);

DragArea = DragArea_reefed.*((1-eta).*(t./(t_f1 - 0)).^3 + eta ).^2;

figure()
plot(t, DragArea)
xlabel("t")
ylabel("Drag Area until reefing")
grid on 
grid minor


DragArea_i = DragArea_reefed;

eta = (DragArea_i./DragArea_dis)^0.5;

t = linspace(t_f1, t_f2, 1000);

DragArea = DragArea_dis.*((1-eta).*(t./(t_f2 - 0)).^3 + eta ).^2;
figure()
plot(t, DragArea)
xlabel("t")
ylabel("Drag Area until fully open")
grid on 
grid minor