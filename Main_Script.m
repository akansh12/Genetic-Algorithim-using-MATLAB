clc;
close all;
clear;

%% Problem Defination 
problem.CostFunction = (@(x)MinOne(x));

problem.nVar = 20;




%% GA Parameter

params.MaxIt = 100;
params.nPop = 20;

params.pC = .8;

params.mu =0.1;



%%
out = RunGA(problem, params);


%%