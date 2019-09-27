% =====================================================
%   HOMOGENEITY OF TISSUE FROM CT SCANS
% -------------------------------------
% PROJET DE SYNTHESE
% Pair No. 81
% =====================================================

clear; close all; clc

% Loading of images
path = 'PATH/TO/MAT/IMAGE/FILES';
f=dir(strcat(path,'*.mat'));
files={f.name};
for k=1:numel(files)
  load(strcat(path, files{k}));
end

% Plot images
% figure
% subplot(3,3,1), imagesc(sl02_1), colorbar
% subplot(3,3,2), imagesc(sl03_1), colorbar
% subplot(3,3,3), imagesc(sl09_1), colorbar
% subplot(3,3,4), imagesc(sl10_1), colorbar
% subplot(3,3,5), imagesc(sl11_1), colorbar
% subplot(3,3,6), imagesc(sl33_1), colorbar
% subplot(3,3,7), imagesc(sl34_1), colorbar
% subplot(3,3,8), imagesc(sl35_1), colorbar
% colormap gray

% Concatenate images
% full = [sl02_1, sl03_1, sl09_1, sl10_1, sl11_1, sl33_1, sl34_1, sl35_1];
% figure
% imagesc(full)
% colorbar, colormap gray, axis image

% Variables
glcm_features = zeros(7, 5, 4, 4);    % glcm_features(resolution, step, direction, feature: K, R, E, H)
resolutions = [4 8 16 32 64 128 256];
steps = [1 2 3 4 5];
directions = [0 1; -1 1;-1 0;-1 -1]; %0,45,90,135

sl34_ROI = roipoly(sl34_1);
sl34 = sl34_1; sl34(~sl34_ROI) = nan;
imagesc(sl34);
colormap gray
sl34 = histeq(sl34,256);

% Calculation of glcm
i = 1;
for res = resolutions
   j = 1;
   for step = steps
       [glcms, si] = graycomatrix(sl34, 'Offset', step*directions, 'NumLevels', res);
       for k = 1:4
           stats = graycoprops( glcms(:,:,k), 'all');
           glcm_features(i, j, k, 1) = stats.Contrast;
           glcm_features(i, j, k, 2) = stats.Correlation;
           glcm_features(i, j, k, 3) = stats.Energy;
           glcm_features(i, j, k, 4) = stats.Homogeneity;           
       end
       j = j+1;
   end
   i = i+1;
end

% Calculation of 