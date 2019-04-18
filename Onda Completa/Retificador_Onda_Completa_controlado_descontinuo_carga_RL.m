% Retificador de Onda Completa Controlado descontinuo - Carga RL
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
%       R   -> Valor da carga Resistiva
%       L   -> Valor do indutor
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
fprintf('Vp      = %.3f V \n',Vp);
R = 10;
L = 0.02;
f = 60;
w = 2*pi*f;
alphaG = 60;        %angulo de atraso em Graus
alpha = alphaG*(pi/180);

%Define o modo de condu��o cont�nua, se > ?, � cont�nuo
theta = atan((w*L)/R);
if (theta > alpha)
    fprintf('� cont�nuo\n');
else
    fprintf('n�o � cont�nuo\n');
end

Z = sqrt(R^2 + (w*L)^2);
tal = L/R;
wtal = w*tal;

Fs = 100000;
n = 6;
t = 0:1/Fs:1;

b = @(b) (sin(b-theta) - sin(alpha-theta)*exp(-(b-alpha)/wtal));
b0 = pi;
beta = fzero(b, b0);                %radianos
fprintf('beta   = %.3f radianos\n',beta);

%funcoes pra corrente
syms wt;
i = (Vp/Z)*(sin(wt-theta) - sin(alpha-theta)*exp(-(wt-alpha)/wtal));      %epressao da corrente
im = (int(i,[alpha beta]))/(pi);
Im = vpa(im);
fprintf('Im     = %.3f A \n',sscanf(char(Im),'%f'));
irms = sqrt(int((i)^2,[alpha beta])/pi);
Irms = vpa(irms);
fprintf('Irms   = %.3f A \n',sscanf(char(Irms),'%f'));

% C�lculo das Pot�ncias
P = (Irms^2)*R;
S = (Vp/sqrt(2))*Irms;
fp = P/S;

fprintf('P      = %.3f W \n', sscanf(char(P),'%f'));
fprintf('S      = %.3f VA \n', sscanf(char(S),'%f'));
fprintf('fp     = %.3f \n', sscanf(char(fp),'%f'));

