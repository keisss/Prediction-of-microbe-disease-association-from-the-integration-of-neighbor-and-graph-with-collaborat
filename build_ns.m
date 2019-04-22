function [NS] = build_ns(nm,nd,DS,MS,d_m_mat)
NS = zeros(nd,nm);
for i=1:nd
    for j=1:nm
        temp_sd = 0;
        for k=1:nd
            temp_sd = temp_sd+ DS(i,k) * d_m_mat(k,j);
        end
        sd = temp_sd/nd;
        temp_sm = 0;
        for k=1:nm
            temp_sm = temp_sm + MS(j,k) * d_m_mat(i,k);
        end
        sm = temp_sm/nm;
        NS(i,j) = (sd+sm)/2;
    end
end
end

