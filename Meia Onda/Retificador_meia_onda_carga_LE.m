% Retificador Meia Onda - Carga LE
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
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
fprintf('Vm     = %.3f V \n',Vp);
L = 0.05;
Vcc = 72;
f = 60;
w = 2*pi*f;

Fs = 10000;
t = 0:(1/Fs):(2*pi)/f;

alpha = asin(Vcc/Vp);
fprintf('Alpha  = %.3f rad \n',alpha);

%  Encontra o beta %
b = @(b) Vp/(w*L)*(cos(alpha)-cos(b))+Vcc/(w*L)*(alpha-b);  %b = beta
b0 = [pi 2*pi];
beta = fzero(b, b0);
fprintf('Beta   = %.3f rad \n',beta);

% Corrente Média %
syms wt;
i = (Vp/(w*L))*(cos(alpha) - cos(wt)) + (Vcc/(w*L))*(alpha-wt);    %Expressão da corrente no circuito
Im = (int(i,[alpha beta]))/(2*pi);
Im = vpa(Im);

% Corrente Eficaz %
Irms = sqrt((int(i^2,[alpha beta]))/(2*pi) );
Irms = vpa(Irms);

% Potência %
PVcc = Im*Vcc;
PT = PVcc;

% Potência Aparente %
S = Vrms*Irms;

%Fator de Potencia
fp = PVcc/S;

fprintf('Im     = %.3f A \n',sscanf(char(Im),'%f'));    %corrente Média na Carga
fprintf('Irms   = %.3f A \n',sscanf(char(Irms),'%f'));  %corrente eficaz
fprintf('PVcc   = %.3f W \n',sscanf(char(PVcc),'%f'));  %potência absrovida pela fonte CC
fprintf('PT     = %.3f W \n',sscanf(char(PT),'%f'));    %potência fornecida pela fonte CA
fprintf('S      = %.3f VA \n',sscanf(char(S),'%f'));    %potência aparente
fprintf('fp     = %.3f \n',sscanf(char(fp),'%f'));      %fator de potência
