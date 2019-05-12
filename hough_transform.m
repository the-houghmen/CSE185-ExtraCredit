function [a, b, r] = hough_transform(edge_map, r_min, r_max)

%% find x, y position from edge map
[edge_y, edge_x] = find(edge_map);

%% range of theta
theta_min = 0;
theta_max = 360;
theta_range = 0:360;

%% range of r
r_range = 1:r_max;

% Calculate each radius as a slice, then tally up maximum votes of each
% slice
%
% stored in format: number of votes, a, b, r
r_votes = zeros(length(r_range), 4);

% recalculate votes for each r to save memory
for r = r_min : r_max
    %% create vote matrix
    V = zeros(size(edge_map, 2), size(edge_map, 1));
    
    %% add votes
    for i = 1 : length(edge_y)
        y = edge_y(i);
        x = edge_x(i);
        for theta = theta_min : theta_max
            a = round(x - r * cos(theta * pi/180));
            b = round(y - r * sin(theta * pi/180));
            if a > 1 && a < size(edge_map, 2) && ...
                    b > 1 && b < size(edge_map, 1)
                V(a, b) = V(a, b) + 1;
            end
        end   
    end
    %% find the maximal vote
    max_vote = max(V(:));
    [max_a_index, max_b_index] = find( V == max_vote );
    a = max_a_index(1);
    b = max_b_index(1);
    
    % store in r_votes to tally up max from each r
    r_votes(r, :, :, :) = [max_vote, a, b, r];
end

r_votes(1:r_min, :, :, :) = zeros(r_min, 4); % Ignore votes less than r_min

[~, index] = max(r_votes(:, 1));
a = r_votes(index, 2);
b = r_votes(index, 3);
r = r_votes(index, 4);
