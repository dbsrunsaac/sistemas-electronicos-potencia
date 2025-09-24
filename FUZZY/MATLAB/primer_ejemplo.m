clc, clear, close all;
ejey=[0 1];

error=-20:0.5:20;
%limites de la variable error
ea=-10;  %Conjutnto ENG
eb=-5;   %Conjutnto ENP
ec=0;    %Conjutnto EZ
ed=5;    %Conjutnto EPP
ee=10;   %Conjutnto EPG
%INICIADORES DE CONTADORES
A=1;B=1;C=1;D=1;E=1;
%/////////////////////
%// Variable de entrada error
%conjunto difuso trapezoidal ENG error negativo
%contador uno A
for x=error;
    if (x<ea)
        ENG (A)=1;
    end
    if (x>=ea)&(x<eb)
        ENG(A)=1-(x-ea)/(eb-ea); %ala derecha
    end
    if (x>=eb)
        ENG(A)=0;
    end 
    A=A+1;
end

%conjunto difuso triangular ENP error negativo pfqueño
%contador dos B
for x=error;
    if (x<ea)||(x>=ec)
        ENP(B)=0;
    end
    if (x>=ea)&&(x<eb)
        ENP(B)=(x-ea)/(eb-ea); %ala izquierda
    end
    if (x>=eb)&&(x<ec)
        ENP(B)=1-(x-eb)/(ec-eb); %ala derecha
    end
    B=B+1;
end
%conjunto difuso triangular E2 error zero
%ontador tres c
for x=error;
    if (x<eb)||(x>=ed)
        EZ(C)=0;
    end
    if (x>=eb)&&(x<ec)
        EZ(C)=(x-eb)/(ec-eb);
    end
    if (x>=ec)&& (x<ed)
        EZ(C)=1-(x-ec)/(ed-ec);
    end
    C=C+1;
end
%conjunto difuso triangular EPP positivo pequeño
%contador cuatro D
for x=error;
    if (x<ec)||(x>=ee)
        EPP(D)=0;
    end
    if (x>=ec)&&(x<ed)
        EPP(D)=(x-ec)/(ed-ec);
    end
    if (x>=ed)&&(x<ee)
        EPP(D)=1-(x-ed)/(ee-ed);
    end 
    D=D+1;
end
%conjunto difuso trapezoidal EPG positivo grande
%contador cinco g
for x=error;
    if (x<ed)
        EPG(E)=0;
    end
    if (x>=ed)&&(x<ee)
        EPG(E)=(x-ed)/(ee-ed);
    end
    if (x>=ee)
        EPG(E)=1;
    end
    E=E+1;
end
subplot(2,2,1), plot(error,ENG,error,ENP,error,EZ,error,EPP,error,EPG)
title('Variable de entrada error');
xlabel('Error');
axis([-20 20 -0.2 1.2]);

% MODELADO DE UNA SEGUNDA ENTRADA (ERROR)
derror = -10 : 0.5 : 10; % Universo de discurso de la derivada de la variable error
% limites de la variable derror
def = -10;
deg = 0;
deh = 10;

% Iniciadores de contadores
f = 1; g = 1; h =1;

% Variable de entrada derivada del error
% Contador uno f
for y = derror;
    if y < def || y >= deg
        N(f) = 0;
    end
    if y >= def && y < deg
        N(f) = 1 - (y-def)/(deg-def); % to right
    end
    f = f + 1;
end

% Conjutno difuso triangular Z derivada de error zero
% contador g
for y = derror;
    if y < def || y >= deh
        Z(g) = 0;
    end
    if y >= def && y < ec
        Z(g) = (y-def)/(deg-def); 
    end
    if y >= deg && y < deh
        Z(g) = 1 - (y-deg)/(deh-deg);
    end
    g = g + 1;
end
% contador difuso triangular P derivada del error positivo
% contador tres h
for y=derror;
    if (y < deg) || (y >= deh)
        P(h) = 0;
    end
    if (y >= deg) && (y <= deh)
        P(h) = (y - deg)/(deh - deg);
    end
    h = h + 1;
end

subplot(2,2,2), plot(derror, N, derror, Z, derror, P);
title('Variable de entrada derivada del error');
xlabel('Derivada del Error');
axis([-10 10 -0.2 1.2]);

%variable de salida Voltaje
voltaje=-12:0.1:12;  %Universo de discurso do
%Limites de la variable voltaje
v1=-12;  %Conjunto voltMP
v2=-6;   %sConjunto voltp
v3=0;    %Conjunto voltz
v4=6;    %Conjunto voltG 
v5=12;   %Conjunto voltMG

%INICIADORES DE CONTADORES
a=1;b=1;c=1;d=1;e=1;

%// Fusificacion de la variable de voltaje
%conjunto difuso triangular voltMP
%contador uno a
for x=voltaje;
    if (x<v1)
        voltMP(a)=1;
    end
    if (x>=v1)&&(x<v2)
        voltMP(a)=1-(x-v1)/(v2-v1);
    end
    if (x>=v2)
        voltMP(a)=0;
    end
    a=a+1;
end
%conjunto difuso triangular voltP
%scontador dos b
for x=voltaje;
    if(x<v1)
        voltP (b) = 0;
    end
    if (x>=v1)&&(x<v2)
        voltP (b) = (x-v1)/(v2-v1);
    end
    if (x>=v2)&&(x<v3)
        voltP (b) = 1-(x-v2)/(v3-v2);
    end
    if (x>=v3)
        voltP (b) = 0;
    end
    b=b+1;
end
%conjunto difuso triangular voltz
%contador tres c
for x=voltaje;
    if (x<v2)||(x>=v4)
        voltZ(c)=0;
    end 
    if(x>=v2)&&(x<v3)
        voltZ(c)=(x-v2)/(v4-v3);
    end 
    if (x>=v3)&&(x<v4)
        voltZ(c)=1-(x-v3)/(v4-v3);
    end 
    if (x>=v4)
        voltZ(c)=0;
    end 
    c=c+1;
end
%conjunto difuso triangular voltG
%contador cuatro d
for x=voltaje;
    if (x<v3)||(x>=v5)
        voltG(d)=0;
    end
    if (x>=v3)&&(x<v4)
        voltG(d)=(x-v3)/(v4-v3);
    end
    if (x>=v4)&&(x<v5)
        voltG(d)=1-(x-v4)/(v5-v4);
    end
    if(x>=v5)
        voltG(d)=0;
    end
    d=d+1;
end
%conjunto difuso triangular voltMG
%contador cinco e
for x=voltaje;
    if (x<v4)
        voltMG(e)=0;
    end
    if (x>=v4)&&(x<v5)
        voltMG(e)=(x-v4)/(v5-v4);
    end
    if (x>=v5)
        voltMG(e)=1;
    end
    e=e+1;
end
subplot(2,2,3), plot(voltaje,voltMP,voltaje,voltP,voltaje,voltZ,voltaje,voltG,voltaje,voltMG)
title('Variable de salida Voltaje');
xlabel('Voltaje');
axis([-12 12 -0.2 1.2]);

% Fuzificación de la variable error
e0 = input('Ingresar error: ');


for x = e0;
    
    % Grado de membresia para ENG
    if e0 < ea
        GPENG = 1
    end
    if e0 >=ea && e0 < eb
        GPENG = 1 - (e0-ea)/(eb-ea);
    end
    if e0 >= eb
        GPENG = 0;
    end
    
    % Grado de membresia para ENP
    if e0 >= ea && e0 < eb
        GPENP = (e0-ea)/(ec-ea);
    end
    if e0>=eb && e0 < ec
        GPENP = 1 - (e0-eb)/(ec-eb);
    end
    if e0 >= ec || e0 < ea
        GPENP = 0;
    end
    
    % Grado de membresia para EZ
    if e0 >= eb && e0 < ec
        GPEZ = (e0-eb)/(ec-eb);
    end
    if e0 >= ec && e0<ed
        GPEZ = 1 - (e0-ec)/(ed-ec);
    end
    if e0 >= ed || e0<eb
        GPEZ = 0;
    end
    
    % Grado de membresia para EPP
    
    if e0 >= ec && e0 < ed
        GPEPP = (e0-ec)/(ed-ec);
    end
    if e0 >= ed && e0 < ee
        GPEPP = 1 - (e0-ed)/(ee-ed);
    end
    if e0 >= ee || e0 < ec
        GPEPP = 0;
    end
    
    % Grado de membresia para EPG
    if e0 >= ed && e0 < ee
        GPEPG = (e0-ed)/(ee-ed);
    end
    if e0 >= ee
        GPEPG = 1;
    end
    if e0 < ed
        GPEPG = 0;
    end
end

subplot(2, 2, 1), hold on, plot(e0, GPENG, '*',e0, GPENP, '*',...
    e0, GPEZ, '*', e0, GPEPP, '*', e0, GPEPG, '*'), hold off

% FUZIFICACION DE LA VARIABLE DERIVADAD DEL ERROR
de0 = input('Ingresar la derivada del error: ');
  

% FUZIFICACIÓN DE LA VARIABLE DE SALIDA
for x = de0;
    % Grado de membresia para N
    if de0 >= def && de0 < deg
        GPN = 1 - (de0-def)/(deg-def);
    end
    if de0 >= deg || de0 < def
        GPN = 0;
    end
    % Grado de membresia para Z
    if de0 >= def && de0 < deg
        GPZ = (de0-def)/(deg-def);
    end
    if de0 >= deg && de0 < deh
        GPZ = 1 - (de0-deg)/(deh-deg);
    end
    
    if de0 >= deh || de0 < def
        GPZ = 0;
    end
    % Grado de membresia para P
    if de0 >= deg && de0 < deh
        GPP = (de0-deg)/(deh-deg);
    end
    if de0>=deh || de0<deg
        GPP = 0;
    end
end

subplot(2,2,2), hold on, plot(de0, GPN, '*', de0, GPZ, '*',...
    de0, GPP, '*'), hold off

% Antecedente. El minimo de las dos entradas
Ante1 = min(GPENG, GPN);
Ante2 = min(GPENG, GPZ);
Ante3 = min(GPENG, GPP);
Ante4 = min(GPENP, GPN);
Ante5 = min(GPENP, GPZ);
Ante6 = min(GPENP, GPP);
Ante7 = min(GPEZ, GPN);
Ante8 = min(GPEZ, GPZ);
Ante9 = min(GPEZ, GPP);
Ante10 = min(GPEPP, GPN);
Ante11 = min(GPEPP,GPZ);
Ante12 = min(GPEPP, GPP);
Ante13 = min(GPEPG, GPN);
Ante14 = min(GPEPG, GPZ);
Ante15 = min(GPEPG, GPP);

% Se establece las reglas y grado de pertenenca de salida para cada caso
% Entrada = error
R1 = min(voltMP, Ante1);
R2 = min(voltMP, Ante2);
R3 = min(voltP, Ante3);
R4 = min(voltMP, Ante4);
R5 = min(voltP, Ante5);
R6 = min(voltP, Ante6);
R7 = min(voltP, Ante7);
R8 = min(voltZ, Ante8);
R9 = min(voltG, Ante9);
R10 = min(voltZ, Ante10);
R11 = min(voltG, Ante11);
R12 = min(voltMG, Ante12);
R13 = min(voltG, Ante13);
R14 = min(voltMG, Ante14);
R15 = min(voltMG, Ante15);

R = max(R1, max(R2, max(R3, max(R4, max(R5, max(R6, max(R7, max(R8, max(R9, max(R10, max(R11, max(R12, max(R13, max(R14, R15))))))))))))));

total_area = sum(R);
if total_area == 0
    error(message('Error area cero'));
end
posicion = sum(R.*voltaje)/total_area;

p = [posicion posicion]
subplot(2, 2, 4), plot(voltaje, R, p, ejey, 'r')
title('Valor DEFUSIFICADO');
axis([-12 12 0 1]);