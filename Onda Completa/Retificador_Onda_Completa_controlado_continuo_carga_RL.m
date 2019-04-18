% Retificador de Onda Completa Controlado Continuo - Carga RL
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor da carga Resistiva
%       L   -> Valor do indutor
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Vo    -> Tensão média na carga
%      Io    -> Corrente média na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Potência ativa na carga
%      S     -> Potência aparente
%      fp    -> Fator de potência

%Parametros de entrada
%CA 120V
Vp = 120*sqrt(2);
fprintf('Vp      = %.3f V \n',Vp);
R = 10;
L = 0.1;
f = 60;
w = 2*pi*f;
alphaG = 60;        %angulo de atraso em Graus
alpha = alphaG*(pi/180);
%fprintf('alpha  = %.3f V \n',alpha);
j = sqrt(-1);
Z = sqrt(R^2 + (w*L)^2);

%Define o modo de condução contínua, se > ?, é contínuo
theta = atan((w*L)/R);
%fprintf('Theta  = %.3f V \n',theta);
if (theta > alpha)
    fprintf('é contínuo\n');
else
    fprintf('não é contínuo\n');
end

tal = L/R;
wtal = w*tal;
%fprintf('wtal   = %.3f V \n',wtal);

Fs = 100000;
n = 6;
t = 0:1/Fs:1;

%Tensao saída
Vo = (2*Vp/pi)*cos(alpha);          %tensao cc na carga
fprintf('Vo     = %.3f V\n',Vo);

%funcoes pra corrente
I0 = Vo/R;                          %corrente media na carga
fprintf('Io     = %.3f A\n',I0);

%an
syms n;
an = (2*Vp/pi)*(((cos(n+1))*alpha)/(n+1) - (((cos(n-1))*alpha)/(n-1)));
n=2;
a2 = (2*Vp/pi)*(((cos(n+1))*alpha)/(n+1) - (((cos(n-1))*alpha)/(n-1)));
n=4;
a4 = (2*Vp/pi)*(((cos(n+1))*alpha)/(n+1) - (((cos(n-1))*alpha)/(n-1)));
n=6;
a6 = (2*Vp/pi)*(((cos(n+1))*alpha)/(n+1) - (((cos(n-1))*alpha)/(n-1)));
n=8;
a8 = (2*Vp/pi)*(((cos(n+1))*alpha)/(n+1) - (((cos(n-1))*alpha)/(n-1)));

%bn
syms n;
bn = (2*Vp/pi)*(((sin(n+1))*alpha)/(n+1) - (((sin(n-1))*alpha)/(n-1)));
n=2;
b2 = (2*Vp/pi)*(((sin(n+1))*alpha)/(n+1) - (((sin(n-1))*alpha)/(n-1)));
n=4;
b4 = (2*Vp/pi)*(((sin(n+1))*alpha)/(n+1) - (((sin(n-1))*alpha)/(n-1)));
n=6;
b6 = (2*Vp/pi)*(((sin(n+1))*alpha)/(n+1) - (((sin(n-1))*alpha)/(n-1)));
n=8;
b8 = (2*Vp/pi)*(((sin(n+1))*alpha)/(n+1) - (((sin(n-1))*alpha)/(n-1)));

%Vn
V2 = sqrt(a2^2 + b2^2);
V4 = sqrt(a4^2 + b4^2);
V6 = sqrt(a6^2 + b6^2);
V8 = sqrt(a8^2 + b8^2);

%Zn
Z0 = abs(R + (j*0*w*L));
Z2 = abs(R + (j*2*w*L));
Z4 = abs(R + (j*4*w*L));
Z6 = abs(R + (j*6*w*L));
Z8 = abs(R + (j*8*w*L));

%In
I2 = V2/Z2;
I4 = V4/Z4;
I6 = V6/Z6;
I8 = V8/Z8;

%Irms
Irms = sqrt(I0^2+(I2/sqrt(2))^2+(I4/sqrt(2))^2+(I6/sqrt(2))^2+(I8/sqrt(2))^2);
fprintf('Irms   = %.3f A\n',Irms);

% Cálculo das Potências
P = (Irms^2)*R;
fprintf('P      = %.3f A\n',P);
S = (Vp/sqrt(2))*Irms;
fprintf('S      = %.3f VA \n', S);
fp = P/S;
fprintf('FP     = %.3f VA \n', fp);

