%Hypotesetest:
xgauss = randn(10 ,1);
xuni = rand (10 ,1);
[H,p_gauss ,SW] = swtest(xgauss ,0.05 );
disp ( p_gauss )
0.1190;
[H,p_uni,SW] = swtest( xuni , 0.05);
disp ( p_uni )
0.0024;