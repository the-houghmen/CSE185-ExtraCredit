
%% load input image
% name = 'lines';
name = 'bridge';
% name = 'hill';

img = imread(sprintf('%s.png', name));


%% extract edge map
edge_map = edge(rgb2gray(img), 'canny', 0.1, 3);
% figure, imshow(edge_map);


%% Hough Transform (vote for m and b)
[m, b] = hough_transform(edge_map);
x = 1:size(img, 2);
y = m * x + b;

figure, imshow(img); title('Your implementation (mb)'); hold on;
plot(x, y, 'LineWidth', 4, 'Color', 'red');
h = gcf;
saveas(h, sprintf('%s_mb_line.png', name));