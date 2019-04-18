% Retificador de Onda Completa - LC Modo contínuo
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor da carga Resistiva
%       C   -> Valor do capacitor
%       L   -> Valor do indutor
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Vo    -> Tensão média na carga    

%Vs = 100*sin(2*pi*f)
Vp = 100;
fprintf('Vp     = %0.4f V\n',Vp);
R = 5;
L = 5e-3;
C = 10000e-6;
f = 60;
w = 2*pi*f;
cont = 3*w*L;

if (R<cont)
    fprintf('Modo Contínuo\n');
else
    fprintf('modo não contínuo\n');
end

%Variação na corrente L
I2  = (2*Vp)/(3*w*L);

fprintf('R_max para corrente continua = %0.4f ohms\n',cont);
Vo = (2*Vp)/pi;
IL = Vo/R;
IR = IL;
fprintf('Vo           = %0.4f V\n',Vo);
fprintf('Io           = %0.4f V\n',IR);
fprintf('delta_IL     = %0.4f V\n',I2);
