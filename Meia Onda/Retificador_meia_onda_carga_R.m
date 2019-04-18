% Retificador Meia Onda - Carga R
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor da carga
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Vm    -> Tensão média de saída
%      Im    -> Corrente média na carga
%      Vrms  -> Tensão eficaz na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Potência ativa na carga
%      S     -> Potência aparente
%      fp    -> Fator de potênciaVp = sqrt(2)*120;

% Valores de entrada
Vp = sqrt(2)*120;
f = 60;
R = 5;

Fs = 10000;                       % Frequência de Amostragem
t = 0:1/Fs:(2*pi);  

Vi = Vp*sin(2*pi*f*t);
Vo = Vi.*(Vi >= 0);
Io = Vo./R;

figure();
plot(t, Vo, t, Io);
xlim([0 (2/f)])
title('Tensão e Corrente de saída');
xlabel('Tempo (s)'); 
ylabel('Amplitude');
legend({'Vo','Io'})

Vm = trapz(t,Vo)/(2*pi);
Im = Vm/R;

Vrms = sqrt(trapz(t,(Vo.^2))/(2*pi));
Irms = Vrms/R;

P = (Vrms^2)/R;
S = (Vp/sqrt(2))*Irms;
fp = P/S;

% FFT 
x = Vo;
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
% fim FFT

% Mostra na tela
fprintf('Vm   = %0.4f V\n',Vm);
fprintf('Im   = %0.4f A\n',Im);
fprintf('Vrms = %0.4f V\n',Vrms);
fprintf('Irms = %0.4f A\n',Irms);
fprintf('P    = %0.4f W\n',P);
fprintf('S    = %0.4f VA\n',S);
fprintf('fp   = %0.4f\n',fp);


