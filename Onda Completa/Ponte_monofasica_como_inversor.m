% Ponte monofásica como inversor
%   Valores de entrada:
%       Vp  -> Tensão de pico da entrada
%       R   -> Valor da carga Resistiva
%       L   -> Valor do indutor
%       f   -> frequência de operação do circuito
%   Valores calculados:
%      Vo    -> Tensão média na carga
%      Io    -> Corrente média na carga
%      P     -> Potência ativa na carga
%      S     -> Potência aparente
%      fp    -> Fator de potência

%Parametros de entrada
%CA 120V
Vp = 120*sqrt(2);
fprintf('Vp      = %.3f V \n',Vp);
R = 0.5;
f = 60;
w = 2*pi*f;
Vcc = -110;
Pcc = 1000;

Fs = 100000;
n = 6;
t = 0:1/Fs:1;

%Corrente
Io = Pcc/Vcc;                          %corrente media na carga
fprintf('Io     = %.3f A\n',Io);

%Tensao saída
Vo = (-Io)*R+Vcc;          %tensao cc na carga
fprintf('Vo     = %.3f V\n',Vo);

alpha = acos((Vo*pi)/(2*Vp));
fprintf('alpha  = %.3f rad\n',alpha);
alphaG = alpha/(pi/180);
fprintf('alphaG = %.3f graus\n',alphaG);

% Cálculo das Potências
PR = (Io^2)*R;
fprintf('PR     = %.3f A\n',PR);
Pca = Vo*Io;
fprintf('Pca    = %.3f A\n',Pca);


