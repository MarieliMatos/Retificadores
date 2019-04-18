Vp = sqrt(2)*120;
L = 0.05;
R = 20;
f = 60;
wL = 2*pi*f*L;
alpha = 90;
alpha_rad = deg2rad(alpha);

jZ = complex(R,wL);
Z = abs(jZ);
theta = atan(wL/R);
tal = L/R;

%  Encontra o beta %
b = @(b) (Vp/(Z))*(sin(b-theta)-sin(alpha_rad-theta)*exp((alpha_rad-b)/(2*pi*f*tal)));
b0 = pi;
beta = fzero(b, b0);

a_cond = beta-alpha_rad;

syms wt;
io = (Vp/(Z))*(sin(wt-theta)-sin(alpha_rad-theta)*exp((alpha_rad-wt)/(2*pi*f*tal)));
Io = (int(io, [alpha_rad beta]))/pi;
Io = vpa(Io);

Irms = sqrt((int(io^2, [alpha_rad beta]))/pi);
Irms = vpa(Irms);

Id_rms = Irms/sqrt(2);
Id_rms = vpa(Id_rms);
Ido = (int(io, [alpha_rad beta]))/(2*pi);
Ido = vpa(Ido);

P = R*Irms^2;
S = (Vp/sqrt(2))*Irms;
fp = P/S;

fprintf('alfa               = %.3f° \n', alpha);
fprintf('beta               = %.3f° \n', rad2deg(beta));
fprintf('Ângulo de Condução = %.3f° \n',rad2deg(a_cond));
fprintf('Io                 = %.3f A \n',sscanf(char(Io),'%f'));
fprintf('Irms               = %.3f A \n',sscanf(char(Irms),'%f'));
fprintf('Id_rms             = %.3f A \n',sscanf(char(Id_rms),'%f'));
fprintf('Ido                = %.3f A \n',sscanf(char(Ido),'%f'));
fprintf('P                  = %.3f W \n',sscanf(char(P),'%f'));
fprintf('S                  = %.3f VA \n',sscanf(char(S),'%f'));
fprintf('fp                 = %.3f \n',sscanf(char(fp),'%f'));



