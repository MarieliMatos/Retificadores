% Retificador Meia Onda - Carga RC
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       C   -> Valor da carga Capacitiva
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Idp   -> Corrente de pico
%      Vrp   -> Tensão de Ripple pico à pico

Vrms = 120;
Vp = Vrms*sqrt(2);
f = 60;
R = 500;
C = 0.0001;
Fs = 10000;
wrc = 2*pi*f*R*C;
fprintf('wrc   = %.3f rad\n',wrc);

t = 0:1/Fs:(2*pi)/f;
w = 2*pi*f;
theta = pi - atan(wrc);
fprintf('theta   = %.3f rad\n',theta);
Vt = Vp*sin(theta);
fprintf('Vtheta  = %.3f\n', Vt);
Vin = Vp*sin(w*t);

a = @(a) sin(a) - sin(theta)*exp(-(2*pi+a-theta)/(wrc));
a0 = 0;
alpha = fzero(a, a0);
fprintf('alpha   = %.3f radianos\n',alpha);

for i = 0:1/Fs:10
    if w*t >= theta
        Vo = Vp*sin(w*t);
    else
        Vo = Vt*exp(-(w*t-theta)/w*R*C);
    end
end

%plot(t, Vo);
%ic_diode_on = (-(Vp*sin(theta)/R)*exp(-(

Idp = Vp*((w*C*cos(alpha)) + (sin(alpha)/R));
Vrp = Vp*(1-sin(alpha));
Vrp_aprox = Vp/(f*R*C);

% Achar C
delta_Vo = 0.01*Vp;
C_calc = Vp/(f*R*delta_Vo);


fprintf('Idp  = %.3f A \n',Idp); %diodo
fprintf('Vrp  = %.3f V \n',Vrp);