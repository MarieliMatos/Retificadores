% Retificador Meia Onda controlado - Carga RLE
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       L   -> Valor da carga indutiva
%       R   -> Valor da resistencia
%       f   -> frequência de operação do circuito
%       Vcc -> Valor da fonte de corrente
%   Valores calculados:
%      Im    -> Corrente média na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Potência ativa na carga
%      S     -> Potência aparente
%      fp    -> Fator de potênciaVp = sqrt(2)*120;

Vrms = 120;
Vp = Vrms*sqrt(2);
Vcc = 100;
f = 60;
R = 2;
L = 0.02;
alphaG = 45;          %graus
alpha = deg2rad(alphaG);   %pra radiano

Fs = 10000;
t = 0:1/Fs:(2*pi)/f;
w = 2*pi*f;

%alpha minimo - angulo de atraso minimo
alphamin = asin(Vcc/Vp);
if(alphaG>=alphamin)
    %fprintf('alpham  = %.3f rad - É admissível\n',alphamin);
else
    fprintf('Não é admissível\n');
end

Z  = sqrt((w*L)^2 + R^2);
theta = atan(w*L/R);
tal = L/R;
w = 2*pi*f;
wtal = w*tal;


%  Encontra o beta %
A  = (((-Vp/Z)*sin(alpha-theta))+Vcc/R)*exp(alpha/wtal);
b = @(b) (Vp/Z)*(sin(b-theta)) - (Vcc/R) + A*exp(-b/wtal);
b0 = 2*pi;
beta = fzero(b, b0);                %radianos


%funcoes pra corrente
A  = (((-Vp/Z)*sin(alpha-theta))+Vcc/R)*exp(alpha/wtal);
syms wt;
i = (Vp/Z)*(sin(wt-theta)) - (Vcc/R) + A*exp(-wt/wtal);      %epressao da corrente
im = int(i,[alpha beta])/(2*pi);
Im = vpa(im);
irms = sqrt(int((i)^2,[alpha beta])/(2*pi));
Irms = vpa(irms);

%Potencia
PR = Irms^2*R;                  %absorvida R
Pdc = Im*Vcc;
fprintf('Pdc   = %.3f W\n',sscanf(char(Pdc),'%f'));

S = vpa(Vrms*Irms);
fp = (PR+Pdc)/S;                      %considerando só no resistor

fprintf('Im     = %.3f A\n',sscanf(char(Im),'%f'));
fprintf('Irms   = %.3f A\n',sscanf(char(Irms),'%f'));
fprintf('PR      = %.3f W\n',sscanf(char(PR),'%f'));
fprintf('S      = %.3f VA\n',sscanf(char(S),'%f'));
fprintf('FP     = %.3f \n',sscanf(char(fp),'%f'));
