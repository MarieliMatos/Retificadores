% Conversor trif�sico inversor
% Considerando L muito alto

Vp = sqrt(2)*4160;              % Tens�o de linha
R = 2;
Vcc = 3000;
alpha_graus = 120;
alpha_rad = deg2rad(120);

if alpha_graus>90 && alpha_graus < 180
    fprintf('Funcionamento como Inversor\n');
else
    fprintf('Funcionamento como Retificador\n');
end

Vo = ((3*Vp)/pi)*cos(alpha_rad);                % Tens�o CC
Io = (Vo+Vcc)/R;

Pac = -Io*Vo;                   % Pot�ncia que volta para o sistema CA
Pcc = Io*Vcc;                   % Pot�ncia fornecida pela fonte CC
Pr = (Io^2)*R;                  % Pot�ncia absorvida por R

fprintf('Vo %f V\n', Vo);
fprintf('Io %f A\n', Io);
fprintf('Pac %f W\n', Pac);
fprintf('Pcc %f W\n', Pcc);
fprintf('Pr %f W\n', Pr);

