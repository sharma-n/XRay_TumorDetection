clear; close all; clc

load sl02_1
load sl03_1
load sl09_1
load sl10_1
load sl11_1
load sl33_1
load sl34_1
load sl34_2
load sl35_1

figure
subplot(3,3,1), imagesc(sl02_1)
subplot(3,3,2), imagesc(sl03_1)
subplot(3,3,3), imagesc(sl09_1)
subplot(3,3,4), imagesc(sl10_1)
subplot(3,3,5), imagesc(sl11_1)
subplot(3,3,6), imagesc(sl33_1)
subplot(3,3,7), imagesc(sl34_1)
subplot(3,3,8), imagesc(sl34_2)
subplot(3,3,9), imagesc(sl35_1)

colormap gray       % Visuale in grayscale
axis equal          % Preserve proportions of image

figure
imhist(sl33_1)

J = histeq(sl33_1,256);
hold
imhist(J)
figure
imagesc(J)
colormap gray

offsets = [0 1; -1 1;-1 0;-1 -1];
C = graycomatrix(J,'Offset',offsets);
C2 = graycomatrix(sl33_1,'Offset',offsets);
figure
imagesc(C(:,:,1))
colormap gray
axis equal
colorbar
figure
mesh(C(:,:,1))

F=fft2(double(J));
S=fftshift(F);
L=log2(S);
A=abs(L);
figure
imagesc(A)

Stat = graycoprops(C(:, :, 1), 'Homogeneity');
Stat2 = graycoprops(C2(:, :, 1), 'Homogeneity');