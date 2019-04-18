%Retificador controlado com carga RLE

Vp = sqrt(2)*240;
Vcc = 100;
R = 5;
alpha = deg2rad(46);

Vo = ((2*Vp)/pi)*cos(alpha);
Io = (Vo-Vcc)/R;
Pcc = Io*Vcc;
P = Pcc + Io^2*R;

%Achar L
fprintf('alfa  = %.3f W \n', alpha);
fprintf('Vo  = %.3f W \n', Vo);
fprintf('Io  = %.3f W \n', Io);
fprintf('P  = %.3f W \n', P);