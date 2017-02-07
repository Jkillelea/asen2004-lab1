function [ CM ] = L1_calcCM( M_pitch, N_force, A, q, S, c )

	P_M_cg = M_pitch - N_force*A;
	CM = P_M_cg/(q*S*c);

end