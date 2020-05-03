pkg load statistics;
clear;
clc;
clf;

a = pi;
s = e;

X = (a - 3 * s) : 0.1 : (a + 3 * s);
plot(X, normpdf(X, a, s), "r.-");
hold on;

n = 10^6;
m = 100;
X = sort(normrnd(a, s, n, 1));
Len = (X(n) - X(1)) / m;
R = X(1) : Len : X(n) - Len;
Y = hist(X, m) / (n * Len);
plot(stairs(R, Y), "b.-");