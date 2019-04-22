function [GS] = build_gs(DS,MS,d_m_mat,nd,nm)
Ad = DS * d_m_mat;
Am = d_m_mat * MS;
alpha = 0.5;
beta = 0.5;

sd = zeros(nd,nm);
for i=1:nd
    tmp_sdi1 = zeros(nd,1);
    for j=1:nm
        tmp_sdi1 = tmp_sdi1 + Am(i,j) * d_m_mat(:,j) / sum(Am(:,j));
    end
    tmp_sdi1 = alpha * tmp_sdi1;
    
    tmp_sdi2 = zeros(nd,1);
    for j=1:nm
        tmp_sdi2 = tmp_sdi2 + Ad(i,j) * d_m_mat(:,j) / sum(Ad(:,j));
    end
    tmp_sdi2 = (1-alpha) * tmp_sdi2;
    sd(:,i) = tmp_sdi1 + tmp_sdi2;
end

GS = zeros(nd,nm);
for j=1:nm
    gs1 = zeros(nd,1);
    for k=1:nd
        gs1 = gs1 + Am(k,j) * sd(:,k) / sum(Am(k,:));
    end
    gs1 = beta * gs1;
    
    gs2 = zeros(nd,1);
    for k=1:nd
        gs2 = gs2 + Ad(k,j) * sd(:,k) / sum(Ad(k,:));
    end
    gs2 = (1-beta) * gs2;
    GS(:,j) = gs1 + gs2;   
end

