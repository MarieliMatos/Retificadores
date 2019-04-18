% Retificador Meia Onda - Carga LE
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
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

% Corrente M�dia %
syms wt;
i = (Vp/(w*L))*(cos(alpha) - cos(wt)) + (Vcc/(w*L))*(alpha-wt);    %Express�o da corrente no circuito
Im = (int(i,[alpha beta]))/(2*pi);
Im = vpa(Im);

% Corrente Eficaz %
Irms = sqrt((int(i^2,[alpha beta]))/(2*pi) );
Irms = vpa(Irms);

% Pot�ncia %
PVcc = Im*Vcc;
PT = PVcc;

% Pot�ncia Aparente %
S = Vrms*Irms;

%Fator de Potencia
fp = PVcc/S;

fprintf('Im     = %.3f A \n',sscanf(char(Im),'%f'));    %corrente M�dia na Carga
fprintf('Irms   = %.3f A \n',sscanf(char(Irms),'%f'));  %corrente eficaz
fprintf('PVcc   = %.3f W \n',sscanf(char(PVcc),'%f'));  %pot�ncia absrovida pela fonte CC
fprintf('PT     = %.3f W \n',sscanf(char(PT),'%f'));    %pot�ncia fornecida pela fonte CA
fprintf('S      = %.3f VA \n',sscanf(char(S),'%f'));    %pot�ncia aparente
fprintf('fp     = %.3f \n',sscanf(char(fp),'%f'));      %fator de pot�ncia
