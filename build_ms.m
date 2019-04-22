function [MS] = build_ms(nm, d_m_mat)
%BUILD_MS
rmm = 0.5;
temp = 0;
for k=1:nm
    temp = temp + norm(d_m_mat(:,k))^2;
end
rm = rmm / (1/nm * temp);

MS = zeros(nm,nm);
for j=1:nm
    for i=j:nm
        t = -norm(d_m_mat(:,i)-d_m_mat(:,j))^2/rm;
        MS(i,j) = exp(t);
        MS(j,i) = MS(i,j);
    end
end
end

