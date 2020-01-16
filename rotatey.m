function [mat] = rotatey(theta)
    mat    = repmat(eye(4), 1, 1, length(theta));
    theta  = reshape(theta, 1, 1, length(theta));

    mat(1,1,:) =  cos(theta);
    mat(1,3,:) =  sin(theta);
    mat(3,1,:) = -sin(theta);
    mat(3,3,:) =  cos(theta);

    mat = squeeze(mat);
end
