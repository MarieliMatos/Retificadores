% Retificador Meia Onda - Carga R
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
%       R   -> Valor da carga
%       f   -> frequ�ncia de opera��o do circuito
%   Valores calculados:
%      Vm    -> Tens�o m�dia de sa�da
%      Im    -> Corrente m�dia na carga
%      Vrms  -> Tens�o eficaz na carga
%      Irms  -> Corrente eficaz na carga
%      P     -> Pot�ncia ativa na carga
%      S     -> Pot�ncia aparente
%      fp    -> Fator de pot�nciaVp = sqrt(2)*120;

% Valores de entrada
Vp = sqrt(2)*120;
f = 60;
R = 5;

Fs = 10000;                       % Frequ�ncia de Amostragem
t = 0:1/Fs:(2*pi);  

Vi = Vp*sin(2*pi*f*t);
Vo = Vi.*(Vi >= 0);
Io = Vo./R;

figure();
plot(t, Vo, t, Io);
xlim([0 (2/f)])
title('Tens�o e Corrente de sa�da');
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
% fim FFT

% Mostra na tela
fprintf('Vm   = %0.4f V\n',Vm);
fprintf('Im   = %0.4f A\n',Im);
fprintf('Vrms = %0.4f V\n',Vrms);
fprintf('Irms = %0.4f A\n',Irms);
fprintf('P    = %0.4f W\n',P);
fprintf('S    = %0.4f VA\n',S);
fprintf('fp   = %0.4f\n',fp);


