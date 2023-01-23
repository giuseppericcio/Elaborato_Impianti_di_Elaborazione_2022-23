clc;
clear;

%% Read the data
data = xlsread('dati');
pca_data = xlsread('pca');
cluster_data = xlsread('cluster');
N_pca = size (pca_data,2); % number of principal components
N_cluster = max (cluster_data); % number of clusters

%% Total Deviance
data_norm = zscore(data);
DEV_TOT = sum(sum((data_norm-mean(data_norm,1)).^2)); % total deviance

%% PCA Deviance
DEV_PCA = sum(sum((pca_data-mean(pca_data,1)).^2)); % deviance after pca
DEV_PCA_per = DEV_PCA/DEV_TOT; % percentage deviance after pca

%% Cluster Deviance
W = zeros (N_cluster,1); % deviance intra (within) clusters
B = zeros (N_cluster,1); % deviance inter (between) clusters
for i = 1: N_cluster
   index = find(cluster_data==i); % find the index of cluster i
   n_ele = size(index, 1); % number of samples of the cluster i
   centroid = mean(pca_data(index,:),1); 
   W(i) = sum(sum((centroid-pca_data(index,:)).^2));
   B(i)= n_ele*sum((centroid-mean(pca_data,1)).^2);
end

W = sum(W); % total deviance intra (within) cluster
B = sum(B); % total deviance inter (between) cluster
(W+B)/DEV_PCA % check if W+B is equal to the deviance after pca

DEV_PCA_CL_per = (B/DEV_TOT); % percentage deviance after pca & clustering
DEV_LOST_per = (1-DEV_PCA/DEV_TOT)+(W/DEV_TOT); % percentage deviance lost after pca & clustering 
%DEV_LOST_per2 = (1-DEV_PCA/DEV_TOT)+ DEV_PCA_per * W/DEV_PCA; % equivalent formula 