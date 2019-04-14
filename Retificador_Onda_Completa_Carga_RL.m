% Retificador de Onda Completa - Carga RL
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor da carga Resistiva
%       L   -> Valor da carga indutiva
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Vo    -> Tensão média na carga
%      Vrms  -> Tensão eficaz na carga
%      Io    -> Corrente média na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Potência ativa na carga
%      S     -> Potência aparente
%      fp    -> Fator de potência
%      DHT   -> Distorção Harmônica Total
%   Gráficos:
%      Tensão vs Corrente da carga
%      Potência na carga
%      Transformada Rápida de Fourier  

%Parametros de entrada
Vp = sqrt(2)*50;
R = 40;
L = 300e-3;
f = 60;

Fs = 100000;
w = 2*pi*f;
n = 6;
t = 0:1/Fs:1;

% Cálculo das impedâncias
XL = w*L;
XLR = complex(R,L); 
Z = abs(XLR);

% FFT
x = abs(Vp*sin(w*t));
N = length(x);                      % variável N recebe o tamanho do vetor x
k = 0:N-1;                          % k é um vetor que vai de zero até N menos 1
T = N/Fs;                           % Vetor de tempo N dividido pela frequência de amostragem
freq = k/T;
X = fftn(x)/N;                      % X recebe a FFT normalizada do vetor x sobre N
cutOff = ceil(N/20);                 % cutOff ajusta o eixo X
X = X(1:cutOff);
X = X*2;
X(1)=X(1)/2;
xa = abs(X);
figure();
plot(freq(1:cutOff),xa);        % Plota a transformada de Fourier e o valor de X em módulo
title('Fast Fourier Transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
%Fim FFT

% Impedância para harmônica
Zh2 = abs(complex(R,2*XL));
Zh4 = abs(complex(R,4*XL));
% Vetor começa em 1.
iout = xa(1)/Z + (2*xa((2*f)+1))*sin(w*t)/Zh2 + (2*xa((4*f)+1))*cos(w*t)/Zh4;

figure()
[hAx,hLine1,hLine2] = plotyy(t, x, t, iout); 
set(hAx(2),'YLim',[0.9 1.5])
hLine1.LineWidth = 1.5;
hLine2.LineWidth = 1.5;
title('Tensão de Saída x Corrente de Saída');
ylabel(hAx(1),'Tensão (V)')
ylabel(hAx(2),'Corrente (A)');
xlabel('Frequência (rad/s)');
grid on;
grid minor;

%Tensão média de saída
syms wt;
v = Vp*sin(wt);
vo = (int(v, [0 pi]))/pi;
Vo = vpa(vo);

%Corrente média de saída
Io = Vo/R;

%Tensão de saída eficaz
vrms = sqrt((int(v^2, [0 pi]))/pi);
Vrms = vpa(vrms);

%Cálculo Irms utilizando duas harmônicas
V2 = ((2*Vp)/pi)*((1/(2-1))-(1/(2+1)));
V4 = ((2*Vp)/pi)*((1/(4-1))-(1/(4+1)));
I2 = V2/Zh2;
I4 = V4/Zh4;
Irms = sqrt(Io^2 + (I2^2/sqrt(2)) + (I4^2/sqrt(2)));

% Cálculo das Potências
P = (Irms^2)*R;
S = (Vp/sqrt(2))*Irms;
fp = P/S;

% Cálculo da DHT da corrente
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


