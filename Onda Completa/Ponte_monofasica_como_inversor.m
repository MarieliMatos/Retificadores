% Ponte monof�sica como inversor
%   Valores de entrada:
%       Vp  -> Tens�o de pico da entrada
%       R   -> Valor da carga Resistiva
%       L   -> Valor do indutor
%       f   -> frequ�ncia de opera��o do circuito
%   Valores calculados:
%      Vo    -> Tens�o m�dia na carga
%      Io    -> Corrente m�dia na carga
%      P     -> Pot�ncia ativa na carga
%      S     -> Pot�ncia aparente
%      fp    -> Fator de pot�ncia

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

%Tensao sa�da
Vo = (-Io)*R+Vcc;          %tensao cc na carga
fprintf('Vo     = %.3f V\n',Vo);

alpha = acos((Vo*pi)/(2*Vp));
fprintf('alpha  = %.3f rad\n',alpha);
alphaG = alpha/(pi/180);
fprintf('alphaG = %.3f graus\n',alphaG);

% C�lculo das Pot�ncias
PR = (Io^2)*R;
fprintf('PR     = %.3f A\n',PR);
Pca = Vo*Io;
fprintf('Pca    = %.3f A\n',Pca);


