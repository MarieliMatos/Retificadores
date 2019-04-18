% Retificador de Onda Completa - Carga R
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor da carga Resistiva
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Vo    -> Tensão média na carga
%      Vrms  -> Tensão eficaz na carga
%      Im    -> Corrente média na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Potência ativa na carga
%      S     -> Potência aparente
%      fp    -> Fator de potência
%      DHT   -> Distorção Harmônica Total
%   Gráficos:
%      Tensão vs Corrente da carga
%      Potência na carga
%      Transformada Rápida de Fourier     

Vp = sqrt(2)*50;
R = 40;
f = 60;
Fs = 100000;
t = 0:1/Fs:4*pi;

% Tensão Média na carga
syms wt;
v = Vp*sin(wt);
vo = (int(v, [0 pi]))/pi;
Vo = vpa(vo);

% Corrente média na carga
Io = Vo/R;
Irms = (Vp/R)/sqrt(2);
Vrms = Irms*R;

% Potências
P = (Irms^2)*R;             % Média entregue a carga
S = (Vp/sqrt(2))*Irms;      % Aperente
fp = P/S;                   % Fator de potência

% Gráficos %
%Tensão e Corrente de saída  
figure();
vo_p = abs(Vp*sin(t));
io_p = abs((Vp*sin(t)/R));
[hAx,hLine1,hLine2] = plotyy(t, vo_p, t, io_p); 
set(hAx(2),'YLim',[0 3])
hLine1.LineWidth = 1.5;
hLine2.LineWidth = 1.5;
title('Tensão de Saída x Corrente de Saída');
ylabel(hAx(1),'Tensão (V)')
ylabel(hAx(2),'Corrente (A)');
xlabel('Frequência (rad/s)');
grid on;
grid minor;

% Potência
figure();
po_p = (vo_p.*io_p);
plot(t, po_p,'LineWidth',1.5);
title('Potência de Saída');
xlabel('Frequência (rad/s)');
ylabel('Potência (W)');
grid on;
grid minor;

% FFT %
x = abs(Vp*sin(2*pi*f*t));
N = length(x);                      % variável N recebe o tamanho do vetor x
k = 0:N-1;                          % k é um vetor que vai de zero até N menos 1
T = N/Fs;                           % Vetor de tempo N dividido pela frequência de amostragem
freq = k/T;
X = fftn(x)/N;                      % X recebe a FFT normalizada do vetor x sobre N
cutOff = ceil(N/f);                 % cutOff ajusta o eixo X
X = X(1:cutOff);
X = X*2;
X(1)=X(1)/2;
figure();
plot(freq(1:cutOff),abs(X), 'LineWidth',1.5);        % Plota a transformada de Fourier e o valor de X em módulo
title('Fast Fourier Transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
% Fim FFT%

% Cálculo da DHT da corrente
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
