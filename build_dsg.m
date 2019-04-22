function [DS] = build_dsg(nd, d_m_mat)
% build GS gaussian;
rdd = 0.5;
temp = 0;
for k=1:nd
    temp = temp + norm(d_m_mat(k,:))^2;
end
rd = rdd / (1/nd * temp);

DS = zeros(nd,nd);
for i=1:nd
    for j=i:nd
        t = -norm(d_m_mat(i,:)-d_m_mat(j,:))^2 / rd;
        DS(i,j) = exp(t);
        DS(j,i) = DS(i,j);
    end
end
end

