pkg load statistics;
clear;
clc;
clf;

a = 13;
b = 37;

X = 10 : 0.5 : 40;
plot(X, unifpdf(X, a, b), "r.-");
hold on;

n = 10^6;
m = 100;
X = sort(unifrnd(a, b, n, 1));
Len = (X(n) - X(1)) / m;
R = X(1) : Len : X(n) - Len;
Y = hist(X, m) / (n * Len);
plot(stairs(R, Y), "b.-");