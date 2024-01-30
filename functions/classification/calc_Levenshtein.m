function Levenshtein = calc_Levenshtein(s, t)

m = length(s);
n = length(t);

d = zeros(m + 1, n + 1);

for i = 0:m
    d(i + 1, 1) = i;
end
for j = 0:n
    d(1, j + 1) = j;
end

for j = 1:n
    for i = 1:m
        if (s(i) == t(j))
            d(i + 1, j + 1) = d(i, j);
        else
            d(i + 1, j + 1) = min([(d(i, j + 1) + 1) (d(i + 1, j) + 1) (d(i, j) + 1)]);
        end
    end
end

Levenshtein = d(end, end);