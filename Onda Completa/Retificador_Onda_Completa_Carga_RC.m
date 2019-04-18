% Retificador de Onda Completa - Carga RC
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor da carga Resistiva
%       C   -> Valor do capacitor
%       f   -> frequência de operação do circuito
Vp = 120*sqrt(2);
fprintf('Vp     = %0.4f V\n',Vp);
R = 500;
C = 100e-6;
f = 60;
w = 2*pi*f;
wrc = w*R*C;
%fprintf('wrc    = %0.4f V\n',wrc);

theta = -atan(wrc)+pi;
%fprintf('Theta  = %0.4f rad\n',theta);

vrev = Vp*sin(theta);        %tensao de quando começa a reverter os diodos
%fprintf('Vrev   = %0.4f rad\n',vrev);

a = @(a) sin(theta)*exp((-pi-a+theta)/wrc)-sin(a);
a0 = pi/2;
alpha = fzero(a, a0);
fprintf('Alpha  = %0.4f rad\n',alpha);

DVo = Vp*(1-sin(alpha));     %variação da tensao de pico na saída
fprintf('delta_vo     = %0.4f Vpp\n',DVo);

syms wt;
v_1 = abs(Vp*sin(wt));
v_2 = (Vp*sin(theta))*exp(-(wt-theta)/(w*R*C));

%Achar C
delta_vo = 0.1;
C_calc = 1/(2*f*R*delta_vo);

fprintf('Vo     = %.3f V \n',sscanf(char(Vo),'%f'));

