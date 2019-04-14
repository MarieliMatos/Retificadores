% Retificador de Onda Completa - Carga RL
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
%       R   -> Valor da carga Resistiva
%       L   -> Valor da carga indutiva
%       f   -> frequ�ncia de opera��o do circuito
%   Valores calculados:
%      Vo    -> Tens�o m�dia na carga
%      Vrms  -> Tens�o eficaz na carga
%      Io    -> Corrente m�dia na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Pot�ncia ativa na carga
%      S     -> Pot�ncia aparente
%      fp    -> Fator de pot�ncia
%      DHT   -> Distor��o Harm�nica Total
%   Gr�ficos:
%      Tens�o vs Corrente da carga
%      Pot�ncia na carga
%      Transformada R�pida de Fourier  

%Parametros de entrada
Vp = sqrt(2)*50;
R = 40;
L = 300e-3;
f = 60;

Fs = 100000;
w = 2*pi*f;
n = 6;
t = 0:1/Fs:1;

% C�lculo das imped�ncias
XL = w*L;
XLR = complex(R,L); 
Z = abs(XLR);

% FFT
x = abs(Vp*sin(w*t));
N = length(x);                      % vari�vel N recebe o tamanho do vetor x
k = 0:N-1;                          % k � um vetor que vai de zero at� N menos 1
T = N/Fs;                           % Vetor de tempo N dividido pela frequ�ncia de amostragem
freq = k/T;
X = fftn(x)/N;                      % X recebe a FFT normalizada do vetor x sobre N
cutOff = ceil(N/20);                 % cutOff ajusta o eixo X
X = X(1:cutOff);
X = X*2;
X(1)=X(1)/2;
xa = abs(X);
figure();
plot(freq(1:cutOff),xa);        % Plota a transformada de Fourier e o valor de X em m�dulo
title('Fast Fourier Transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%Fim FFT

% Imped�ncia para harm�nica
Zh2 = abs(complex(R,2*XL));
Zh4 = abs(complex(R,4*XL));
% Vetor come�a em 1.
iout = xa(1)/Z + (2*xa((2*f)+1))*sin(w*t)/Zh2 + (2*xa((4*f)+1))*cos(w*t)/Zh4;

figure()
[hAx,hLine1,hLine2] = plotyy(t, x, t, iout); 
set(hAx(2),'YLim',[0.9 1.5])
hLine1.LineWidth = 1.5;
hLine2.LineWidth = 1.5;
title('Tens�o de Sa�da x Corrente de Sa�da');
ylabel(hAx(1),'Tens�o (V)')
ylabel(hAx(2),'Corrente (A)');
xlabel('Frequ�ncia (rad/s)');
grid on;
grid minor;

%Tens�o m�dia de sa�da
syms wt;
v = Vp*sin(wt);
vo = (int(v, [0 pi]))/pi;
Vo = vpa(vo);

%Corrente m�dia de sa�da
Io = Vo/R;

%Tens�o de sa�da eficaz
vrms = sqrt((int(v^2, [0 pi]))/pi);
Vrms = vpa(vrms);

%C�lculo Irms utilizando duas harm�nicas
V2 = ((2*Vp)/pi)*((1/(2-1))-(1/(2+1)));
V4 = ((2*Vp)/pi)*((1/(4-1))-(1/(4+1)));
I2 = V2/Zh2;
I4 = V4/Zh4;
Irms = sqrt(Io^2 + (I2^2/sqrt(2)) + (I4^2/sqrt(2)));

% C�lculo das Pot�ncias
P = (Irms^2)*R;
S = (Vp/sqrt(2))*Irms;
fp = P/S;

% C�lculo da DHT da corrente
Iin_rms = (Vp/sqrt(2))/Z;
DHT = sqrt(((Irms^2)-(Iin_rms^2))/(Iin_rms^2));

fprintf('Vo     = %.3f V \n',sscanf(char(Vo),'%f'));
fprintf('Io     = %.3f A \n',sscanf(char(Io),'%f'));
fprintf('Vrms   = %.3f V \n', sscanf(char(Vrms),'%f'));
fprintf('Irms   = %.3f A \n', sscanf(char(Irms),'%f'));
fprintf('P      = %.3f W \n', sscanf(char(P),'%f'));
fprintf('S      = %.3f VA \n', sscanf(char(S),'%f'));
fprintf('fp     = %.3f \n', sscanf(char(fp),'%f'));
fprintf('DHT    = %.3f \n', sscanf(char(DHT),'%f'));


