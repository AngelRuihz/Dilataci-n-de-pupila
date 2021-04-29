%Limpiar
clc, clear, close all;

%Cargamos la imagen
I = imread('ojo/eye2.jpg');

% la pasamos a una escala de grises
Ig = rgb2gray(I);
figure,
imshow(I);
% Filtrado
K2 = medfilt2(Ig); %Filtrdo de mediana 2D

% Binariza la imagen
BW= im2bw(K2,0.04); 
BW = BW==0; %Inviertan los colores
BW = imfill(BW,'holes'); %Rellena los hoyos


% SE- strel(forma,parametros) - Elemento estructurante
se1 = strel('disk',5);

%Operaciones morfologicas
J1 = imerode(BW,se1); %erosion
figure,
imshow(J1);
%%% SEGMENTACION
L = bwlabel(J1); % Crea regiones (etiqueta componetes conectados)
numele = max(max(L)); % Numero de objetos etiquetados
disp('Numero de pupilas detectadas '), disp(numele)
stats = regionprops(L,'all'); % Estadistica de las regiones
%coloca un circulo rojo alrededor de un elemento
center = stats(1).Centroid;
radio = sqrt((stats(1).Area)./pi);
diametro = (radio*2)/3.779527559055 + "mm" % 1mm = 3.779527559055
figure(1)
viscircles(center,radio);
figure(2)
viscircles(center,radio);
%Recortat el elemento
E = stats(1).BoundingBox; % Toma la frontera de la region
R1 = imcrop(I,E); %Devuelve la primera region

%Muestra los resultado por proceso
figure,
subplot(3,2,1), imshow(I), title('Original')
subplot(3,2,2), imshow(Ig), title('Grises')
subplot(3,2,3), imshow(K2), title('Filtrada')
subplot(3,2,4), imshow(BW), title('Binarizada')
subplot(3,2,5), imshow(J1), title('Erosionada')
subplot(3,2,6), imshow(R1), title('Pupila')