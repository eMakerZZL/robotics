function [mat] = euler_ZYX(T, alpha, beta, gama, nstep)
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
        T1(:,:,i) = T * R1(:,:,i) ;
    end

    for i = 1 : nstep
        T2(:,:,i) = T1(:,:,end) * R2(:,:,i) ;
    end

    for i = 1 : nstep
        T3(:,:,i) = T2(:,:,end) * R3(:,:,i);
    end
    
    mat = cat(3, T1, T2, T3);
end
