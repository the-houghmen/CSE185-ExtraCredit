
%% load input image
% name = 'lines';
name = 'desk';
% name = 'hill';

img = imread(sprintf('%s.png', name));


%% extract edge map
edge_map = edge(rgb2gray(img), 'canny', 0.1, 3);
% figure, imshow(edge_map);


%% Hough Transform (vote for a, b, and r)
r_min = 20;
r_max = 100;
num_circles = 5;

[as, bs, rs] = hough_transform(edge_map, r_min, r_max, num_circles);

figure, imshow(img);
title(sprintf('First %d Circles Detected', num_circles)); hold on;
ang = 0 : 0.01 : 2*pi;

for i = 1:num_circles
    xp = rs(i) * cos(ang);
    yp = rs(i) * sin(ang);

    plot(as(i)+xp, bs(i)+yp, 'LineWidth', 4, 'Color', 'blue');
end

h = gcf;
saveas(h, sprintf('%s_circle.png', name));
