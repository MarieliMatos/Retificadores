% Retificador Meia Onda - Carga RLE
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
%       R   -> Valor da carga Resistiva
%       L   -> Valor da carga Indutiva
%       Vcc -> Valor da fonte CC
%       f   -> frequ�ncia de opera��o do circuito
%   Valores calculados:
%      Im    -> Corrente m�dia na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Pot�ncia ativa na carga
%      S     -> Pot�ncia aparente
%      fp    -> Fator de pot�nciaVp = sqrt(2)*120;

Vrms = 120;
Vp = sqrt(2)*Vrms;

R = 2;
L = 0.02;
Vcc = 100;
f = 60;
w = 2*pi*f;

Fs = 10000;
t = 0:(1/Fs):(2*pi)/f;

alpha = asin(Vcc/Vp);
Z = sqrt((R^2) + (w*L)^2);
theta = atan((w*L)/R);
wtal = 2*pi*f*(L/R);
A = (((-Vp/Z)*sin(alpha-theta)) + (Vcc/R))*exp(alpha/(wtal));

%  Encontra o beta %
b = @(b) (Vp/Z)*sin(b-theta)-(Vcc/R) + A*exp(-b/(wtal));
b0 = pi;
beta = fzero(b, b0);

% Corrente M�dia %
syms wt;
i = (Vp/Z)*sin(wt - theta) - (Vcc/R) + A*exp(-wt/(wtal));       %expressao da corrente
Im = (int(i,[alpha beta]))/(2*pi);
Im = vpa(Im);

% Corrente Eficaz %
Irms = sqrt( (int(i^2,[alpha beta]))/(2*pi) );
Irms = vpa(Irms);

% Pot�ncia %
PR = (Irms^2)*R;
PVcc = Im*Vcc;
PT = PR + PVcc;
S = (Vp/sqrt(2))*Irms;

%Fator de Potencia
fp = PT/S;

fprintf('Im     = %.3f A \n',sscanf(char(Im),'%f'));    %corrente M�dia na Carga
fprintf('Irms   = %.3f A \n',sscanf(char(Irms),'%f'));  %corrente eficaz
fprintf('PVcc   = %.3f W \n',sscanf(char(PVcc),'%f'));  %pot�ncia absrovida pela fonte CC
fprintf('PR     = %.3f W \n',sscanf(char(PR),'%f'));    %potencia absorvida pelo resistor
fprintf('PT     = %.3f W \n',sscanf(char(PT),'%f'));    %pot�ncia fornecida pela fonte CA
fprintf('S      = %.3f VA \n',sscanf(char(S),'%f'));    %pot�ncia aparente
fprintf('fp     = %.3f \n',sscanf(char(fp),'%f'));      %fator de pot�ncia
