% =====================================================
%   PREPROCESSING OF IMAGE
% -------------------------------------
% PROJET DE SYNTHESE
% Pair No. 81
% =====================================================

clear; close all; clc

% Loading of images
path = 'C:\Users\Naman\OneDrive\CentraleSupelec\Année 1\Projet 1A\mat files\';
f=dir(strcat(path,'*.mat'));
files={f.name};
for k=1:numel(files)
  load(strcat(path, files{k}));
end

% Normalization of Images
sl02_1 = mat2gray(sl02_1);
sl03_1 = mat2gray(sl03_1);
sl09_1 = mat2gray(sl09_1);
sl10_1 = mat2gray(sl10_1);
sl11_1 = mat2gray(sl11_1);
sl33_1 = mat2gray(sl33_1);
sl34_1 = mat2gray(sl34_1);
sl35_1 = mat2gray(sl35_1);

% Plot images
figure
subplot(3,3,1), imagesc(sl02_1), colorbar
subplot(3,3,2), imagesc(sl03_1), colorbar
subplot(3,3,3), imagesc(sl09_1), colorbar
subplot(3,3,4), imagesc(sl10_1), colorbar
subplot(3,3,5), imagesc(sl11_1), colorbar
subplot(3,3,6), imagesc(sl33_1), colorbar
subplot(3,3,7), imagesc(sl34_1), colorbar
subplot(3,3,8), imagesc(sl35_1), colorbar
colormap gray
supertitle('Images After Normalization')

% Image Filtering: low-pass filter
boxKernel = ones(5,5); % bigger box will blur more
sl02_box = mat2gray(imfilter(sl02_1, boxKernel));
sl03_box = mat2gray(imfilter(sl03_1, boxKernel));
sl09_box = mat2gray(imfilter(sl09_1, boxKernel));
sl10_box = mat2gray(imfilter(sl10_1, boxKernel));
sl11_box = mat2gray(imfilter(sl11_1, boxKernel));
sl33_box = mat2gray(imfilter(sl33_1, boxKernel));
sl34_box = mat2gray(imfilter(sl34_1, boxKernel));
sl35_box = mat2gray(imfilter(sl35_1, boxKernel));

figure
subplot(1,2,1), imagesc(sl34_1), colorbar, title('Original Image')
subplot(1,2,2), imagesc(sl34_box), colorbar, title('Image after low pass box filter')
colormap gray
figure
plot(sl34_1(150,:))
hold on
plot(sl34_box(150,:))
title('Effect of filtering on line 150')
legend('Original Line Intensity','Line Intensity after low pass box filter')

% Image Filtering: Gaussian Filtering
sl02_gauss = imgaussfilt(sl02_1, 0.7);
sl03_gauss = imgaussfilt(sl03_1, 0.7);
sl09_gauss = imgaussfilt(sl09_1, 0.7);
sl10_gauss = imgaussfilt(sl10_1, 0.7);
sl11_gauss = imgaussfilt(sl11_1, 0.7);
sl33_gauss = imgaussfilt(sl33_1, 0.7);
sl34_gauss = imgaussfilt(sl34_1, 0.7);
sl35_gauss = imgaussfilt(sl35_1, 0.7);

figure
subplot(1,2,1), imagesc(sl34_1), colorbar, title('Original Image')
subplot(1,2,2), imagesc(sl34_gauss), colorbar, title('Image after Gaussian Filtering')
colormap gray
figure
plot(sl34_1(150,:))
hold on
plot(sl34_gauss(150,:))
title('Effect of filtering on line 150')
legend('Original Line Intensity','Line Intensity after gaussian filter')

% Image Filtering: Median Filtering
sl02_med = medfilt2(sl02_1);
sl03_med = medfilt2(sl03_1);
sl09_med = medfilt2(sl09_1);
sl10_med = medfilt2(sl10_1);
sl11_med = medfilt2(sl11_1);
sl33_med = medfilt2(sl33_1);
sl34_med = medfilt2(sl34_1);
sl35_med = medfilt2(sl35_1);
figure
subplot(1,2,1), imagesc(sl34_1), colorbar, title('Original Image')
subplot(1,2,2), imagesc(sl34_med), colorbar, title('Image after Median Filtering')
colormap gray
figure
plot(sl34_1(150,:))
hold on
plot(sl34_med(150,:))
title('Effect of filtering on line 150')
legend('Original Line Intensity','Line Intensity after median filter')


% Histogram Equilization
% sl02_1 = histeq(sl02_1, 256);
% sl03_1 = histeq(sl03_1, 256);
% sl09_1 = histeq(sl09_1, 256);
% sl10_1 = histeq(sl10_1, 256);
% sl11_1 = histeq(sl11_1, 256);
% sl33_1 = histeq(sl33_1, 256);
% sl34_1 = histeq(sl34_1, 256);
% sl35_1 = histeq(sl35_1, 256);

% % Plot images
sl34_hist = histeq(sl34_1,256);
sl34hist_box = histeq(sl34_box, 256);
sl34hist_gauss = histeq(sl34_gauss, 256);
sl34hist_med = histeq(sl34_med, 256);

figure
subplot(3,2,1), imagesc(sl34_1), colorbar, title('Original Image')
subplot(3,2,2), imagesc(sl34_hist), colorbar, title('After hisogram equilization without filter')
subplot(3,2,3), imagesc(sl34hist_box), colorbar, title('After hisogram equilization with box filter')
subplot(3,2,4), imagesc(sl34hist_gauss), colorbar, title('After hisogram equilization with gaussian filter')
subplot(3,2,5), imagesc(sl34hist_med), colorbar, title('After hisogram equilization with median filter')
colormap gray

figure
plot(sl34_1(150,:)), hold on
plot(sl34_hist(150,:)), hold on
plot(sl34hist_box(150,:)), hold on
plot(sl34hist_gauss(150,:)), hold on
plot(sl34hist_med(150,:))
legend('Original','After histeq','After histeq with box filter','After histeq with gaussian filter','After histeq with median filter')
title('Line intensity at line 150')