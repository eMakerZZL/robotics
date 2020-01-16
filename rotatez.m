function [mat] = rotatez(theta)
    mat    = repmat(eye(4), 1, 1, length(theta));
    theta  = reshape(theta, 1, 1, length(theta));

    mat(1:2,1:2,:) = [
                        cos(theta), -sin(theta); 
                        sin(theta),  cos(theta)
                     ];

    mat = squeeze(mat);
end
