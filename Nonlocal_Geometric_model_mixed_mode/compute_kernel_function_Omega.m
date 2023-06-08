function sol=compute_kernel_function_Omega(para,r,i)

delta=para.DELTA(i);
a=(2+1)^4;
sol=(8*a)/( pi*delta^4)*1/( 1-exp(-a) )*exp(-a*r.^4/delta^4);

end