load d_m_mat.mat d_m_mat;
nd = 39;
nm = 292;

DS = build_dsg(nd, d_m_mat);
MS = build_ms(nm,d_m_mat);

ns = build_ns(nm,nd,DS,MS,d_m_mat);
gs = build_gs(DS,MS,d_m_mat,nd,nm);
S = (ns + gs) /2;
save('result.mat', 'S');