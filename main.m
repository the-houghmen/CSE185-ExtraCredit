
%% load input image
% name = 'lines';
name = 'bridge';
% name = 'hill';

img = imread(sprintf('%s.png', name));


%% extract edge map
edge_map = edge(rgb2gray(img), 'canny', 0.1, 3);
% figure, imshow(edge_map);


%% Hough Transform (vote for m and b)
[a, b, r] = hough_transform(edge_map);
x = 1:size(img, 2);
y_plus = sqrt(r .^ 2 - (x - a) .^ 2) + b;
y_minus = -sqrt(r .^ 2 - (x - a) .^ 2) + b;

figure, imshow(img); title('Your implementation (mb)'); hold on;
plot(x, y_plus, 'LineWidth', 4, 'Color', 'red');
plot(x, y_minus, 'LineWidth', 4, 'Color', 'red');
h = gcf;
saveas(h, sprintf('%s_circle.png', name));