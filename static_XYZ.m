function [mat] = static_XYZ(T,alpha,beta,gama,nstep)
    if nargin < 5
        nstep = 50;
    end

    a = linspace(0, alpha, nstep);
    b = linspace(0, beta,  nstep);
    c = linspace(0, gama,  nstep);

    R1 = rotatex(a);
    R2 = rotatey(b);
    R3 = rotatez(c);

    I  = eye(4);
    T1 = repmat(I, [1 1 nstep]);
    T2 = repmat(I, [1 1 nstep]);
    T3 = repmat(I, [1 1 nstep]);

    for i = 1 : nstep
        T1(:,:,i) = R1(:,:,i) * T;
    end

    for i = 1 : nstep
        T2(:,:,i) = R2(:,:,i) * T1(:,:,end);
    end

    for i = 1 : nstep
        T3(:,:,i) = R3(:,:,i) * T2(:,:,end);
    end
    
    mat = cat(3, T1, T2, T3);
end
