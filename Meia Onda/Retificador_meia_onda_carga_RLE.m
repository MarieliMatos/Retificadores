% Retificador Meia Onda - Carga RLE
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor da carga Resistiva
%       L   -> Valor da carga Indutiva
%       Vcc -> Valor da fonte CC
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Im    -> Corrente média na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Potência ativa na carga
%      S     -> Potência aparente
%      fp    -> Fator de potênciaVp = sqrt(2)*120;

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

% Corrente Média %
syms wt;
i = (Vp/Z)*sin(wt - theta) - (Vcc/R) + A*exp(-wt/(wtal));       %expressao da corrente
Im = (int(i,[alpha beta]))/(2*pi);
Im = vpa(Im);

% Corrente Eficaz %
Irms = sqrt( (int(i^2,[alpha beta]))/(2*pi) );
Irms = vpa(Irms);

% Potência %
PR = (Irms^2)*R;
PVcc = Im*Vcc;
PT = PR + PVcc;
S = (Vp/sqrt(2))*Irms;

%Fator de Potencia
fp = PT/S;

fprintf('Im     = %.3f A \n',sscanf(char(Im),'%f'));    %corrente Média na Carga
fprintf('Irms   = %.3f A \n',sscanf(char(Irms),'%f'));  %corrente eficaz
fprintf('PVcc   = %.3f W \n',sscanf(char(PVcc),'%f'));  %potência absrovida pela fonte CC
fprintf('PR     = %.3f W \n',sscanf(char(PR),'%f'));    %potencia absorvida pelo resistor
fprintf('PT     = %.3f W \n',sscanf(char(PT),'%f'));    %potência fornecida pela fonte CA
fprintf('S      = %.3f VA \n',sscanf(char(S),'%f'));    %potência aparente
fprintf('fp     = %.3f \n',sscanf(char(fp),'%f'));      %fator de potência
