% Retificador Meia Onda controlado - Carga R
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor do resistor
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Idp   -> Corrente de pico
%      Vrp   -> Tensão de Ripple pico à pico

Vo = 40;                %PRODUZIR 40V NA CARGA
Vrms = 120;
Vp = Vrms*sqrt(2);
f = 60;
R = 100;
Fs = 10000;
t = 0:1/Fs:(2*pi)/f;
w = 2*pi*f;

Vin = Vp*sin(w*t);
alpha  =  acos((Vo*(2*pi/Vp))-1);
fprintf('alpha   = %.3f radianos\n',alpha);

%Tensao na carga
Vcrms = ((sqrt(2)*Vrms)/2)*sqrt(1-(alpha/pi)+(sin(2*alpha)/(2*pi)));
fprintf('Vcrms   = %.3f V\n',Vcrms);

Irms = Vcrms/R;
fprintf('Irms    = %.3f A\n',Irms);

%Potencia
PR = Vcrms^2/R;
fprintf('PR      = %.3f W\n',PR);
S = Vrms*Irms;
fprintf('S       = %.3f VA\n',S);

%Fator de Potencia
fp = PR/S;
fprintf('FP       = %.3f\n',fp);