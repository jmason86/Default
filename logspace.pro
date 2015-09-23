FUNCTION LOGSPACE, A, B, N
L = DINDGEN(N) / (N - 1.0D) * (B - A) + A
L = alog10(L)
return, L
END