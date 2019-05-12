function [a, b, r] = hough_transform(edge_map)
    
    %% find x, y position from edge map
    [edge_y, edge_x] = find(edge_map);

    %% range of theta
    theta_min = 0;
    theta_max = 360;
    theta_range = 0:360;

    %% range of r
    r_min = 10;
    r_max = 60;
    r_range = r_min:r_max;
    
    %% create vote matrix
    V = zeros(size(edge_map, 2), size(edge_map, 1), length(r_range));
    
    %% add votes
    for i = 1 : length(edge_y)
        y = edge_y(i);
        x = edge_x(i);

        for r = r_min : r_max
           for theta = theta_min : theta_max
               a = round(x - r * cos(theta * pi/180));
               b = round(y - r * sin(theta * pi/180));
               if a > 1 && a < size(edge_map, 2) && ...
                  b > 1 && b < size(edge_map, 1)
                    V(a, b, r-r_min+1) = V(a, b, r-r_min+1) + 1;
               end
           end
        end
    end
    
    %% find the maximal vote
    max_vote = max(V(:));
    [max_a_index, max_b_index, max_r_index] = find( V == max_vote );
    a = max_a_index;
    b = max_b_index;
    r = r_range(max_r_index);

end