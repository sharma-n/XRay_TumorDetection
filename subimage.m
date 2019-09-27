% ========================================================
%   COMPARING TISSUE HOMOGENIETY VS. CLASSIFICATION BY EYE
% --------------------------------------------------------
% PROJET DE SYNTHESE
% Pair No. 81
% ========================================================
clear; close all; clc

% Loading of images
path = 'C:\Users\Naman\OneDrive\CentraleSupelec\Année 1\Projet 1A\Sub pictures\';
f=dir(strcat(path,'*.png'));
files={f.name};
Im = cell(1, 13);
for k=1:numel(files)
  Im{k}=mat2gray(rgb2gray(imread(strcat(path, files{k})))); %mat2gray for normalization of images
end

% Filtrage passe-bas
figure
for i=1:numel(files)
    Im{i} = medfilt2(Im{i}, [5 5]);
    subplot(2,2,i), imagesc(Im{i}), title (int2str(i)), colormap gray
end

% Variables
steps = [1 3 5];
glcm_features = zeros(numel(files), numel(steps), 4, 4);    % glcm_features(image, step, direction, feature: K, R, E, H)
directions = [0 1; -1 1;-1 0;-1 -1]; %0,45,90,135

% Calculation of glcm 
for i = 1:numel(files)
    j = 1;
    for step = steps
       [glcms, si] = graycomatrix(Im{i}, 'Offset', step*directions, 'NumLevels', 256);
       for k = 1:4
           stats = graycoprops( glcms(:,:,k), 'all');
           glcm_features(i, j, k, 1) = stats.Contrast;
           glcm_features(i, j, k, 2) = stats.Correlation;
           glcm_features(i, j, k, 3) = stats.Energy;
           glcm_features(i, j, k, 4) = stats.Homogeneity;
       end
       j = j+1;
    end
end
