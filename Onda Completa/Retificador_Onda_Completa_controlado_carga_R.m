% Retificador de Onda Completa Controlado - Carga R
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
%       R   -> Valor da carga Resistiva
%       f   -> frequ�ncia de opera��o do circuito
%   Valores calculados:
%      Vo    -> Tens�o m�dia na carga
%      Io    -> Corrente m�dia na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Pot�ncia ativa na carga
%      S     -> Pot�ncia aparente
%      fp    -> Fator de pot�ncia 

%Parametros de entrada
%CA 120V
Vp = 120*sqrt(2);
R = 20;
f = 60;
w = 2*pi*f;
alphaG = 40;        %angulo de atraso em Graus
alpha = deg2rad(alphaG);

Fs = 100000;
n = 6;
t = 0:1/Fs:1;

%Tensao sa�da
syms wt;
v = Vp*sin(wt);
vo = (int(v, [alpha pi]))/pi;
Vo = vpa(vo);
fprintf('Vo     = %.3f V \n',sscanf(char(Vo),'%f'));

%Corrente nas sa�da
Io = Vo/R;
fprintf('Io     = %.3f A \n',sscanf(char(Io),'%f'));
syms wt;
irms = sqrt((int(((Vp/R)*sin(wt))^2,[alpha pi]))/pi);
Irms = vpa(irms);
fprintf('Irms   = %.3f A \n',sscanf(char(Irms),'%f'));

% C�lculo das Pot�ncias
P = (Irms^2)*R;
S = (Vp/sqrt(2))*Irms;
fp = P/S;

fprintf('P      = %.3f W \n', sscanf(char(P),'%f'));
fprintf('S      = %.3f VA \n', sscanf(char(S),'%f'));
fprintf('fp     = %.3f \n', sscanf(char(fp),'%f'));


