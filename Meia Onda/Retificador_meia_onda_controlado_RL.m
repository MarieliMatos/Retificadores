% Retificador Meia Onda controlado - Carga RL
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       L   -> Valor da carga indutiva
%       R   -> Valor da resistencia
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Idp   -> Corrente de pico
%      Vrp   -> Tensão de Ripple pico à pico

Vrms = 120;
Vp = Vrms*sqrt(2);
f = 60;
R = 20;
L = 0.04;

alphaG = 45;                %graus
alpha = deg2rad(alphaG);    %pra radiano

Fs = 10000;
t = 0:1/Fs:(2*pi)/f;

w = 2*pi*f;
Z  = sqrt((w*L)^2 + R^2);
theta = atan(w*L/R);
tal = L/R;
wtal = w*tal;

%  Encontra o beta %
b = @(b) (sin(b-theta) - sin(alpha-theta)*exp((alpha-b)/wtal));
b0 = pi;
beta = fzero(b, b0);                %radianos
fprintf('beta   = %.3f radianos\n',beta);

%funcoes pra corrente
syms wt;
i = (Vp/Z)*(sin(wt-theta) - (sin(alpha-theta)*exp((alpha-wt)/wtal)));      %epressao da corrente
im = (int(i,[alpha beta]))/(2*pi);
Im = vpa(im);
irms = sqrt(int((i)^2,[alpha beta])/(2*pi));
Irms = vpa(irms);

%Potencia
PR = Irms^2*R;
S = vpa(Vrms*Irms);
fp = PR/S;

fprintf('Im     = %.3f A\n',sscanf(char(Im),'%f'));
fprintf('Irms   = %.3f A\n',sscanf(char(Irms),'%f'));
fprintf('PR      = %.3f W\n',sscanf(char(PR),'%f'));
fprintf('S      = %.3f VA\n',sscanf(char(S),'%f'));
fprintf('FP     = %.3f \n',sscanf(char(fp),'%f'));
