function drawArrow(T1,T2)
%DRAWARROW 此处显示有关此函数的摘要
%   此处显示详细说明
    sp = transl(T1);
    ep = transl(T2);

    dir_x = T1(1:3,1);

    Link_HS = sp;
    if (abs(dir_x(1)) == 1)
        Link_HE = [ep(1); sp(2); sp(3)];
    elseif (abs(dir_x(2)) == 1)
        Link_HE = [sp(1); ep(2); sp(3)];
    else
        Link_HE = [sp(1); sp(2); ep(3)];
    end

    Link_VS = Link_HE;
    Link_VE = ep;
    HLine = [Link_HS,Link_HE];
    VLine = [Link_VS,Link_VE];
    hLine = line(HLine(1,:),HLine(2,:),HLine(3,:));
    vLine = line(VLine(1,:),VLine(2,:),VLine(3,:));

    set(hLine,'Color','r','LineWidth',3,'LineStyle',':');
    set(vLine,'Color','b','LineWidth',3,'LineStyle',':');
end

