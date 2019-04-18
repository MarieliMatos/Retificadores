Vp = 100;
R = 2;
L = 0.025;
f = 60;
Fs= 10000;

t = 0:1/Fs:4/f;

%Tensão média
Vo = Vp/pi;

%Corrente média
Io = Vo/R;

%Componentes CA de tensão 
V1 = Vp/2;
V2 = (2*Vp)/((2^2 - 1)*pi);
V4 = (2*Vp)/((4^2 - 1)*pi);
V6 = (2*Vp)/((6^2 - 1)*pi);
V8 = (2*Vp)/((8^2 - 1)*pi);
V10 = (2*Vp)/((10^2 - 1)*pi);

%Componentes CA de corrente 
I1 = V1/abs(complex(R,2*pi*f*L));
I2 = V2/abs(complex(R,2*2*pi*f*L));
I4 = V4/abs(complex(R,4*2*pi*f*L));
I6 = V6/abs(complex(R,6*2*pi*f*L));
I8 = V8/abs(complex(R,8*2*pi*f*L));
I10 = V10/abs(complex(R,10*2*pi*f*L));

% Valores RMS
Irms = sqrt(Io^2 + I1^2 + I2^2 + I4^2 + I6^2 + I8^2 + I10^2);
Vrms = sqrt(Vo^2 + V1^2 + V2^2 + V4^2 + V6^2 + V8^2 + V10^2);

P = (Irms^2)*R;

fprintf('Io     = %.3f A \n', Io);
fprintf('Vo     = %.3f A \n', Vo);
fprintf('Irms     = %.3f A \n', Irms);
fprintf('Vrms     = %.3f A \n', Vrms); 
fprintf('I1     = %.3f A \n', I1);
fprintf('I2     = %.3f A \n', I2);
fprintf('I4     = %.3f A \n', I4);
fprintf('I6     = %.3f A \n', I6);
fprintf('I8     = %.3f A \n', I8);
fprintf('I10     = %.3f A \n', I10);
fprintf('V1     = %.3f A \n', V1);
fprintf('V2     = %.3f A \n', V2);
fprintf('V4     = %.3f A \n', V4);
fprintf('V6     = %.3f A \n', V6);
fprintf('V8     = %.3f A \n', V8);
fprintf('V10     = %.3f A \n', V10);
