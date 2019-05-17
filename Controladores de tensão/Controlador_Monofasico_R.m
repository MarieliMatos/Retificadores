%Controlador monofásico com carga R

 Vp = 127*sqrt(2);
 R = 12;
 alpha = 66.75;
 alpha_rad = deg2rad(alpha);
 
 syms wt;
 vo = Vp*sin(wt);
 Vo = (int(vo, [alpha_rad pi]))/pi;
 Vo = vpa(Vo);
 Io = Vo/R;
 Io = vpa(Io);
 
 vrms = sqrt((int(vo^2, [alpha_rad pi]))/pi);
 Vrms = vpa(vrms);
 Irms = Vrms/R;
 Irms = vpa(Irms);
 
 Id_rms = Irms/sqrt(2);
 Id_rms = vpa(Id_rms);
 
 P = Irms*Vrms;
 S = (Vp/sqrt(2))*(Vrms/R);
 fp = ((Vp/sqrt(2))*sqrt((1-(alpha_rad/pi) + ((sin(2*alpha_rad))/(2*pi)))))/(Vp/sqrt(2));
 
 C1 = 0.61;             % determinado pelo gráfico
 I_base = (Vp/sqrt(2))/R;
 I1_rms = C1*I_base;
 DHT = vpa(sqrt(Irms^2 - I1_rms^2)/I1_rms);
 
 fprintf('Vo   = %.3f V \n',sscanf(char(Vo),'%f'));
 fprintf('Vrms   = %.3f V \n',sscanf(char(Vrms),'%f'));
 fprintf('Io   = %.3f A \n',sscanf(char(Io),'%f'));
 fprintf('Irms   = %.3f A \n',sscanf(char(Irms),'%f'));
 fprintf('Id_rms  = %.3f A \n',sscanf(char(Id_rms),'%f'));
 fprintf('P   = %.3f W \n',sscanf(char(vpa(P)),'%f'));
 fprintf('S   = %.3f VA \n',sscanf(char(vpa(S)),'%f'));
 fprintf('fp  = %.3f  \n',sscanf(char(vpa(fp)),'%f'));
 fprintf('I1_rms   = %.3f A \n',sscanf(char(I1_rms),'%f'));
 fprintf('DHT   = %.3f  \n',sscanf(char(DHT),'%f'));
 