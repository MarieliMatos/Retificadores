Vp = sqrt(2)*480;
alpha = deg2rad(39.5);
R = 10;

syms wt;
if alpha<=(pi/3)
    fprintf('Condução contínua\n');
    v = Vp*sin(wt);
    vo = (int(v, [((pi/3)+alpha) ((2*pi/3)+alpha)]))*(3/pi);
    Vo = vpa(vo);
    io = Vo/R;
    Io = vpa(io);
    fprintf('Vo   = %.3f V \n',sscanf(char(Vo),'%f'));
    fprintf('Io   = %.3f A \n',sscanf(char(Io),'%f'));
else
    fprintf('Condução descontínua\n');
    v = Vp*sin(wt);
    vo = (int(v, [((pi)+alpha) ((pi/3)+alpha)]))*(3/pi);
    Vo = vpa(vo);
    io = Vo/R;
    Io = vpa(io);
    fprintf('Vo   = %.3f V \n',sscanf(char(Vo),'%f'));  
    fprintf('Io   = %.3f A \n',sscanf(char(Io),'%f'));
end

% Achar afa
alfa = acos((Vo*pi)/(3*Vp));
alfa = vpa(alfa);
alfa_graus = rad2deg(alfa);
alfa_graus = vpa(alfa_graus);
fprintf('alfa   = %.3f  \n',sscanf(char(alfa_graus),'%f'));
