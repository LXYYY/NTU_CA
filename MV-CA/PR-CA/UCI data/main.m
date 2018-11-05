clear 
clc
close all

addpath(genpath(pwd));
dataset_list=["abalone" "car" "chess_krvkp" "contrac" "magic" "molec_biol_splice" "monks_3" "mushroom" "musk_2" "nursery" "optical"]
%dataset_list=["spect"]

for i=1:size(dataset_list,2)
    b_partition=exist(dataset_list(i)+'_R.m','file')
    results(i)=evaluate(dataset_list(i),i,b_partition);
    size(results,1);
    size(results,2);
end 