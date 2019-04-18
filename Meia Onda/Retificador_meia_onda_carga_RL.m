Vp = sqrt(2)*100;
f = 60;
R = 100;
L = 0.6;
Fs = 10000;                       % Frequência de Amostragem
phase = 0;                        % Defasagem 

t = 0:1/Fs:(pi);

Z  = sqrt((2*pi*f*L)^2 + R^2);
theta = atan((2*pi*f*L)/R);
tal = L/R;

%  Encontra o beta %
b = @(b) (Vp/(Z))*(sin(b-theta)+sin(theta)*exp(-b/(2*pi*f*tal)));
b0 = pi;
beta = fzero(b, b0);

% Corrente Média %
syms wt;
i = (Vp/Z)*(sin(wt-theta)+(sin(theta)*exp(-wt/(0.337))));
im = (int(i,[0 beta]))/(2*pi);
Im = vpa(im);

Vm = Im*Z;

irms = sqrt((int(i^2,[0 beta]))/(2*pi));
Irms = vpa(irms);
Vrms = Irms*Z;

P = (Irms^2)*R;
S = (Vp/sqrt(2))*Irms;
fp = P/S;

fprintf('Vm     = %.3f V\n',sscanf(char(Vm),'%f'));
fprintf('Im     = %.3f A\n',sscanf(char(Im),'%f'));
fprintf('Vrms   = %.3f V\n',sscanf(char(Vrms),'%f'));
fprintf('Irms   = %.3f A\n',sscanf(char(Irms),'%f'));
fprintf('P      = %.3f W\n',sscanf(char(P),'%f'));
fprintf('S      = %.3f VA\n',sscanf(char(S),'%f'));
fprintf('fp     = %.3f \n',sscanf(char(fp),'%f'));

Vi = Vp*sin(2*pi*f*t);
Vo = Vi.*(2*pi*f*t>= 0 & 2*pi*f*t<=beta);
Ii = (Vp/Z)*(sin(2*pi*f*t - theta) + (sin(theta)*exp(-(2*pi*f*t)/(2*pi*f*tal))));
Io = Ii.*(2*pi*f*t >= 0 & 2*pi*f*t<=beta);

figure();
ax1 = subplot(2,1,1); % top subplot
plot(t, Vo);
grid on;
grid minor;
xlim([0 (1/f)])
title('Tensão');
xlabel('Tempo (s)'); 
ylabel('Amplitude (V)');
ax2 = subplot(2,1,2); % bottom subplot

plot(t, Io);
xlim([0 (1/f)])
title('Corrente');
xlabel('Tempo (s)'); 
ylabel('Amplitude (A)');
grid on;
grid minor;
