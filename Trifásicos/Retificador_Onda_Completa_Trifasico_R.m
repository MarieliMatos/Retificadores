
R = 100;
Vp = sqrt(2)*50;
Fs = 10000;
t = 0:1/1000:7;
f = 60;
%Tensões de entrada
va = Vp*sin(t);
vb = Vp*sin(t+(-2*pi)/3);
vc = Vp*sin(t+(2*pi)/3);

%Tensões de linha
vcbb = (vc-vb).*(t>0 & t<(pi/6));
vab = (va-vb).*(t>(pi/6) & t<((pi/2)));
vac = (va-vc).*(t>(pi/2) & t<((5*pi/6)));
vbc = (vb-vc).*((t>(5*pi)/6) & t<(7*pi/6));
vba = (vb-va).*(t>(7*pi/6) & t<(3*pi/2));
vca = (vc-va).*(t>(3*pi/2) & t<(11*pi/6));
vcb = (vc-vb).*(t>(11*pi/6) & t<((13*pi/6)));

% Plot da tensão de saída
vop = vab + vac + vba + vbc + vca + vcb + vcbb;
figure();
plot(t, vop);
grid on;
grid minor;

% FFT %
x = vop;
N = length(x);                      % variável N recebe o tamanho do vetor x
k = 0:N-1;                          % k é um vetor que vai de zero até N menos 1
T = N/Fs;                           % Vetor de tempo N dividido pela frequência de amostragem
freq = k/T;
X = fftn(x)/N;                      % X recebe a FFT normalizada do vetor x sobre N
cutOff = ceil(N/60);                 % cutOff ajusta o eixo X
X = X(1:cutOff);
figure();
plot(freq(1:cutOff),abs(X), 'LineWidth',1.5);        % Plota a transformada de Fourier e o valor de X em módulo
title('Fast Fourier Transform');
xlabel('Frequency (Hz)');
ylabel('Amplitude');
% Fim FFT%

%Tensão média
syms wt;
vo = Vp*sin(wt);
Vo = (int(vo, [(pi/3) ((2*pi)/3)]))/(pi/3);
Vo = vpa(Vo);
% Corrente média
Io = Vo/R;

%Tensão RMS
vrms = sqrt((int(vo^2, [(pi/3) ((2*pi)/3)]))/(pi/3));
Vrms = vpa(vrms);
%Corrente RMS
Irms = Vrms/R;
Irms_fonte = (sqrt(2/3))*Irms;
Irms_fonte = vpa(Irms_fonte);

%Potências
P = (Vrms^2)/R;
S = sqrt(3)*(Vp/sqrt(2))*Irms_fonte;
fp = P/S;

fprintf('Vo   = %.3f V \n',sscanf(char(Vo),'%f'));
fprintf('Io   = %.3f A \n',sscanf(char(Io),'%f'));
fprintf('Vrms = %.3f V \n',sscanf(char(Vrms),'%f'));
fprintf('Irms = %.3f A \n',sscanf(char(Irms),'%f'));
fprintf('P    = %.3f W \n',sscanf(char(P),'%f'));
fprintf('S    = %.3f VA \n',sscanf(char(S),'%f'));
fprintf('fp   = %.3f  \n',sscanf(char(fp),'%f'));

