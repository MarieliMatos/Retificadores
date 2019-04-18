R = 100;
L = 0.3;
Vp = sqrt(2)*50;
Fs = 10000;
t = 0:1/Fs:4*pi;
f = 60;

%Tensões de entrada
va = Vp*sin(t);
vb = Vp*sin(t+(-2*pi)/3);
vc = Vp*sin(t+(2*pi)/3);

%Plot tensão de entrada
figure();
plot(t, va, t, vb, t, vc);
title('Tensão de entrada');
xlabel('Frequency (rad/s)');
ylabel('Amplitude (V)');

vcna = vc.*(t>deg2rad(0) & t<deg2rad(30));
van = va.*(t>deg2rad(30) & t<deg2rad(150));
vbn = vb.*(t>deg2rad(150) & t<deg2rad(270));
vcn = vc.*(t>deg2rad(270) & t<deg2rad(360));

% Plot da tensão de saída

vop = van + vbn + vcn + vcna;
figure();
plot(t, vop);
title('Tensão de saída');
xlabel('Frequency (rad/s)');
ylabel('Amplitude (V)');
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
X = X*2;                            % precisa multiplicar por 2 pois o comando da linha 81 tira 50% da info do sinal. Ver Fig(3 e 4)     
X(1)=X(1)/2; 
figure();
plot(freq(1:cutOff),abs(X), 'LineWidth',1.5);        % Plota a transformada de Fourier e o valor de X em módulo
title('Fast Fourier Transform');
xlabel('Frequency (rad/s)');
ylabel('Amplitude');
% Fim FFT%

% Cálculo das impedâncias
XL = 2*pi*f*L;
XLR = complex(R,L); 
Z = abs(XLR);

% %Tensão média
syms wt;
vo = Vp*sin(wt);
Vo = (int(vo, [deg2rad(30) deg2rad(150)]))/deg2rad(120);
Vo = vpa(Vo);
%Corrente média
Io = Vo/Z;

%Tensão RMS
vrms = sqrt((int(vo^2, [deg2rad(30) deg2rad(150)]))/deg2rad(120));
Vrms = vpa(vrms);
%Corrente RMS
Irms = Vrms/R;
Irms_fonte = (sqrt(2/3))*Irms;
Irms_fonte = vpa(Irms_fonte);

%Potências
P = (Vrms^2)/R;
S = sqrt(3)*(Vp/sqrt(2))*Irms_fonte;
fp = P/S;

% Corrente de entrada
ia = (2*sqrt(3)/pi)*Io*(cos(t)-(1/5)*cos(5*t)+(1/7)*cos(7*t)-(1/11)*cos(11*t)+(1/13)*cos(13*t));
ib = (2*sqrt(3)/pi)*Io*(cos(t-2*pi/3)-(1/5)*cos(5*(t-2*pi/3))+(1/7)*cos(7*(t-2*pi/3))-(1/11)*cos(11*(t-2*pi/3))+(1/13)*cos(13*(t-2*pi/3)));
ic = (2*sqrt(3)/pi)*Io*(cos(t+2*pi/3)-(1/5)*cos(5*(t+2*pi/3))+(1/7)*cos(7*(t+2*pi/3))-(1/11)*cos(11*(t+2*pi/3))+(1/13)*cos(13*(t+2*pi/3)));
figure();
plot(t, ia.*(t>deg2rad(0) & t<deg2rad(60)), t, ib.*(t>deg2rad(60) & t<deg2rad(180)), t, ic.*(t>deg2rad(180) & t<deg2rad(300)));
title('Corrente de entrada');
xlabel('Frequency (rad/s)');
ylabel('Amplitude (A)');

%Corrente de saída
io = ia.*(t>deg2rad(0) & t<deg2rad(60)) + ib.*(t>deg2rad(60) & t<deg2rad(180)) + ic.*(t>deg2rad(180) & t<deg2rad(300)) ;

figure();
plot(t, io);
title('Corrente de saída');
xlabel('Frequency (rad/s)');
ylabel('Amplitude (A)');

fprintf('Vo   = %.3f V \n',sscanf(char(Vo),'%f'));
fprintf('Io   = %.3f A \n',sscanf(char(Io),'%f'));
fprintf('Vrms = %.3f V \n',sscanf(char(Vrms),'%f'));
fprintf('Irms = %.3f A \n',sscanf(char(Irms),'%f'));
fprintf('P    = %.3f W \n',sscanf(char(P),'%f'));
fprintf('S    = %.3f VA \n',sscanf(char(S),'%f'));
fprintf('fp   = %.3f  \n',sscanf(char(fp),'%f'));
