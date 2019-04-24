Vp = 120*sqrt(2);
f = 60;
Vcc = 48;
R = 24.79;

Fs = 10000;
t = 0:(1/Fs):(2*pi)/f;
alpha = asin(Vcc/Vp);

Io = (Vp-Vcc)/(pi*R);
Vo = Vcc + Io*R;

Irms = (Vp-Vcc)/(2*R);
Vrms = (Vp-Vcc)/2;
Pca = (Vp/sqrt(2))*Irms;
Pcc = Io*Vcc;

fprintf('Vo     = %.3f V \n',Vo);
fprintf('Io     = %.3f A \n',Io);
fprintf('Vrms    = %.3f V \n',Vrms);
fprintf('Irms     = %.3f A \n',Irms);
fprintf('Pca     = %.3f A \n',Pca);
fprintf('Pcc     = %.3f A \n',Pcc);