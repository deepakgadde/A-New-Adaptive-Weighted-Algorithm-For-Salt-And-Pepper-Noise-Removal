function[mse,psnr]=PSNR(ImRef,ImDis)

[r,c]=size(ImRef);

mse=double((sum(sum((ImRef-ImDis)))/(r*c))^2);
psnr=abs(10*log10(255*255/mse));
