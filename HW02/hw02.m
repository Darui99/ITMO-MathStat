pkg load statistics;

n = 10000;
m = 100;
a = 3.14;
s = 2.7;
t0 = 0.5;
y = 0.97;

Q = norminv((1 + y) / 2);
sample = normrnd(a, s, n, m);
f = mean(sample < t0);
delta = Q * sqrt(f .* (1 - f) / n);
L = f - delta;
R = f + delta;
F = normcdf(t0, a, s);

x = 1:1:m;
plot(x, L, "r.-", x, R, "g.-", x, ones(1, m) .* F, "b.-")
grid

miss = sum(L > F) + sum(R < F);
printf("Number of misses %g\n", miss);