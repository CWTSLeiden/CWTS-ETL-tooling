function LCS = calc_LCS(x, y)

m = length(x);
n = length(y);
c = zeros(m + 1, n + 1);
for i = 1:m
    for j = 1:n
        if (x(i) == y(j))
            c(i + 1, j + 1) = c(i, j) + 1;
        else
            c(i + 1, j + 1) = max(c(i + 1, j), c(i, j + 1));
        end
    end
end
LCS = c(end, end);