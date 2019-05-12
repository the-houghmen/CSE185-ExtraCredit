
%% load input image
% name = 'lines';
name = 'desk';
% name = 'hill';

img = imread(sprintf('%s.png', name));


%% extract edge map
edge_map = edge(rgb2gray(img), 'canny', 0.1, 3);
% figure, imshow(edge_map);


%% Hough Transform (vote for a, b, and r)
[a, b, r] = hough_transform(edge_map);
ang = 0 : 0.01 : 2 * pi;
xp = r * cos(ang);
yp = r * sin(ang);

figure, imshow(img); title('Circles Detected'); hold on;
plot(a+xp, b+yp, 'LineWidth', 4, 'Color', 'blue');
h = gcf;
saveas(h, sprintf('%s_circle.png', name));