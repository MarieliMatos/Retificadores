% Retificador de Onda Completa - Carga R
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
%       R   -> Valor da carga Resistiva
%       f   -> frequ�ncia de opera��o do circuito
%   Valores calculados:
%      Vo    -> Tens�o m�dia na carga
%      Vrms  -> Tens�o eficaz na carga
%      Im    -> Corrente m�dia na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Pot�ncia ativa na carga
%      S     -> Pot�ncia aparente
%      fp    -> Fator de pot�ncia
%      DHT   -> Distor��o Harm�nica Total
%   Gr�ficos:
%      Tens�o vs Corrente da carga
%      Pot�ncia na carga
%      Transformada R�pida de Fourier     

Vp = sqrt(2)*50;
R = 40;
f = 60;
Fs = 100000;
t = 0:1/Fs:4*pi;

% Tens�o M�dia na carga
syms wt;
v = Vp*sin(wt);
vo = (int(v, [0 pi]))/pi;
Vo = vpa(vo);

% Corrente m�dia na carga
Io = Vo/R;
Irms = (Vp/R)/sqrt(2);
Vrms = Irms*R;

% Pot�ncias
P = (Irms^2)*R;             % M�dia entregue a carga
S = (Vp/sqrt(2))*Irms;      % Aperente
fp = P/S;                   % Fator de pot�ncia

% Gr�ficos %
%Tens�o e Corrente de sa�da  
figure();
vo_p = abs(Vp*sin(t));
io_p = abs((Vp*sin(t)/R));
[hAx,hLine1,hLine2] = plotyy(t, vo_p, t, io_p); 
set(hAx(2),'YLim',[0 3])
hLine1.LineWidth = 1.5;
hLine2.LineWidth = 1.5;
title('Tens�o de Sa�da x Corrente de Sa�da');
ylabel(hAx(1),'Tens�o (V)')
ylabel(hAx(2),'Corrente (A)');
xlabel('Frequ�ncia (rad/s)');
grid on;
grid minor;

% Pot�ncia
figure();
po_p = (vo_p.*io_p);
plot(t, po_p,'LineWidth',1.5);
title('Pot�ncia de Sa�da');
xlabel('Frequ�ncia (rad/s)');
ylabel('Pot�ncia (W)');
grid on;
grid minor;

% FFT %
x = abs(Vp*sin(2*pi*f*t));
N = length(x);                      % vari�vel N recebe o tamanho do vetor x
k = 0:N-1;                          % k � um vetor que vai de zero at� N menos 1
T = N/Fs;                           % Vetor de tempo N dividido pela frequ�ncia de amostragem
freq = k/T;
X = fftn(x)/N;                      % X recebe a FFT normalizada do vetor x sobre N
cutOff = ceil(N/f);                 % cutOff ajusta o eixo X
X = X(1:cutOff);
X = X*2;
X(1)=X(1)/2;
figure();
plot(freq(1:cutOff),abs(X), 'LineWidth',1.5);        % Plota a transformada de Fourier e o valor de X em m�dulo
title('Fast Fourier Transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
% Fim FFT%

% C�lculo da DHT da corrente
Iin_rms = (Vp/sqrt(2))/R;
DHT = sqrt(((Irms^2)-(Iin_rms^2))/(Iin_rms^2));

fprintf('Vo     = %.3f A \n',sscanf(char(Vo),'%f'));
fprintf('Io     = %.3f A \n',sscanf(char(Io),'%f'));
fprintf('Vrms   = %.3f A \n', Vrms);
fprintf('Irms   = %.3f A \n', Irms);
fprintf('P      = %.3f W \n', P);
fprintf('S      = %.3f VA \n', S);
fprintf('fp     = %.3f \n', fp);
fprintf('DHT    = %f \n', DHT);
