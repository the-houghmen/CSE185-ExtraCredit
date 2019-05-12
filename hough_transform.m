function [a, b, r] = hough_transform(edge_map)
    
    %% find x, y position from edge map
    [edge_y, edge_x] = find(edge_map);

    %% range of m
    theta_min = 0;
    theta_max = 360;
    theta_range = 0:360;

    %% range of r
    r_min = 10;
    r_max = 10;
    r_range = r_min:r_max;
    
    %% create vote matrix
    V = zeros(length(edge_x), length(edge_y), length(r_range));
    
    %% add votes
    for i = 1 : length(edge_y)
        y = edge_y(i);
        x = edge_x(i);

        for r = r_min : r_max
           for theta = theta_min : theta_max
               a = round(x - r * cos(theta * pi/180));
               b = round(y - r * sin(theta * pi/180));
               if a > 1 && a < length(edge_x) && ...
                  b > 1 && b < length(edge_y)
                V(a, b, r-r_min+1) = V(a, b, r-r_min+1) + 1;
               
               end
           end
        end
    end

    %% visualize votes
    % figure, imagesc(V); xlabel('b'); ylabel('m'); 
    
    %% find the maximal vote
    max_vote = max(V(:));
    [max_a_index, max_b_index, max_r_index] = find( V == max_vote );
    a = max_a_index;
    b = max_b_index;
    r = r_range(max_r_index);

end