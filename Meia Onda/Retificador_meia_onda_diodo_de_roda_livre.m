% Diodo de rola livre com L/R -> infinito
Vp = sqrt(2)*240;
R = 8;
f = 60;
Fs= 10000;

Vo = Vp/pi;
Io = Vo/R;
Irms = Io;
Vrms = Irms*R;
Iin_rms = sqrt((Irms^2)/2);

%Corrente média diodo
Io_diodo = Io/2;

S = (Vp/sqrt(2))*Iin_rms;
P = (Irms^2)*R;
fp = P/S;

% Para achar L
Ip_p = 0.1;         %10%  corrente pico a pico
delta_Io = 0.1*Io;  % Corrente pico a pico máxima
I_l = delta_Io/2;   % amplitude
Z = (Vp/2)/I_l;     % Impedancia
L = Z/(2*pi*f);
%

fprintf('Io      = %.3f A \n', Io);
fprintf('Vo      = %.3f V \n', Vo);
fprintf('Irms    = %.3f A \n', Irms);
fprintf('Vrms    = %.3f V \n', Vrms);
fprintf('Iin_rms = %.3f A \n', Iin_rms);
fprintf('P       = %.3f W \n', P);
fprintf('S       = %.3f VA \n', S);
fprintf('fp      = %.3f A \n', fp);

