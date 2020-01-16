function [mat] = rotatex(theta)
    mat    = repmat(eye(4), 1, 1, length(theta));
    theta  = reshape(theta, 1, 1, length(theta));

    mat(2:3,2:3,:) = [
                        cos(theta), -sin(theta); 
                        sin(theta),  cos(theta)
                     ];

    mat = squeeze(mat);
end
