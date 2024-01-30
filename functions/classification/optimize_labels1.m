fid = fopen(sprintf('%s/%s', folder, input_file), 'r');
header = textscan(fid, '%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s', 1, 'Delimiter', '\t');
data = textscan(fid, '%d %d %d %d %d %s %s %s %s %s %s %s %s %s %s', 'HeaderLines', 1, 'Delimiter', '\t');
fclose(fid);

labels = cat(2, data{6:end});
header = cat(2, header{:});

n = size(labels, 1);
labels_selection = cell(n, 5);

n_rejected_labels = 0;
for i = 1:n
    labels_selection{i, 1} = labels{i, 1};
    j = 2;
    k = 1;
    while ((j <= 10) && (k < 5))
        max_similarity = 0;
        for l = 1:k
            similarity = calc_LCS(labels{i, j}, labels_selection{i, l}) ./ ((length(labels{i, j}) + length(labels_selection{i, l})) ./ 2);
            max_similarity = max(max_similarity, similarity);
        end
        if (max_similarity < 0.65)
            k = k + 1;
            labels_selection{i, k} = labels{i, j};
        else
            n_rejected_labels = n_rejected_labels + 1;
        end
        j = j + 1;
    end
end
mean_n_rejected_labels = n_rejected_labels ./ n;

output_data = cat(2, data{1:5});

[n_rows, n_cols]= size(labels_selection);

fid = fopen(sprintf('%s/%s', folder, output_file), 'w');
fprintf(fid, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\r\n', header{1:10});
for row=1:n_rows
    fprintf(fid, '%d\t%d\t%d\t%d\t%d\t', output_data(row,:));
    fprintf(fid, '%s\t%s\t%s\t%s\t%s\r\n', labels_selection{row,:});
end
fclose(fid);