% Retificador de Onda Completa - LC Modo cont�nuo
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
%       R   -> Valor da carga Resistiva
%       C   -> Valor do capacitor
%       L   -> Valor do indutor
%       f   -> frequ�ncia de opera��o do circuito
%   Valores calculados:
%      Vo    -> Tens�o m�dia na carga    

%Vs = 100*sin(2*pi*f)
Vp = 100;
fprintf('Vp     = %0.4f V\n',Vp);
R = 50;
L = 5e-3;
C = 10000e-6;
f = 60;
w = 2*pi*f;
cont = (3*w*L)/R;

if (cont>1)
    fprintf('Modo Cont�nuo\n');
else
    fprintf('modo n�o cont�nuo\n');
end

Vo = 85;       %Primeira Itera��o deve ser um valor pr�ximo ao Vp
alpha = asin(Vo/Vp);
fprintf('aplha  = %0.4f\n',alpha);

b = @(b) (Vp*(cos(alpha)-cos(b)) - Vo*(b-alpha));
b0 = pi/2;
beta = fzero(b, b0);
fprintf('beta  = %0.4f rad\n',beta);

syms wt;
i = (1/2*pi*f*L)*((Vp*(cos(alpha)-cos(wt)) - Vo*(wt-alpha)));
il = (int(i,[alpha beta]))/(pi);
Il = vpa(il);
Vo_novo = Il*R;

fprintf('Vo           = %0.4f V\n',Vo);
fprintf('Vo_novo     = %.3f V\n',sscanf(char(Vo_novo),'%f'));
fprintf('IL     = %.3f A\n',sscanf(char(Il),'%f'));
