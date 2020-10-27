rng(0,'twister') % initialize random number generator
M = randn(20,20);
Z = eig(M);

figure
compass(Z)