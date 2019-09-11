clc
clear all
close all
%I = imread('cameraman.tif');
I = imread('peppers.png');
%I = imread('rice.png');
%I = imread('trees.tif');
I=rgb2gray(I);
figure,imshow(I),xlabel('Input Image')

f=zeros();
count=0;
noise=0.1:0.1:0.6;
for k=1:6
Z=imnoise(I,'salt & pepper',noise(k)); 
figure,imshow(Z), xlabel('Image with noise')

a=Z;
a=padarray(a,[2 2]);
[row col]=size(a);
x=medfilt2(a);
figure,imshow(x);
x= x(3:row-2, 3:col-2);
%figure,imshow(x), xlabel('MEDIAN FILTER OUTPUT')

[msemed(k),psnrmed(k)]=PSNR(I,x);


y=wiener2(a);
figure,imshow(y);
y= y(3:row-2, 3:col-2);
%figure,imshow(y), xlabel('WIENER FILETER OUTPUT')

[msewiener(k),psnrwiener(k)]=PSNR(I,y);


% Calculation of label matrix
    f=labelmatrix(a,row,col);
    
    
% Calculation of noise density
ND=noisedensity(a,row,col);


if ND<=0.3
    
    %mean method

   fprintf('mean method')   
    for x=2:1:row-1
        for y=2:1:col-1  
           tem=[a(x-1,y-1) a(x-1,y) a(x-1,y+1);a(x,y-1) a(x,y) a(x,y+1);a(x+1,y-1) a(x+1,y) a(x+1,y+1)];
           t=mean2(tem);
               for i=-1:1
                  for j=-1:1
                     if f(x+i,y+j)~=0
                        a(x+i,y+j)=t;
                     else
                        a(x+i,y+j)=a(x+i,y+j);
    
                     end
                  end
               end           
        end
    end
a= a(3:row-2, 3:col-2);
figure,imshow(a),xlabel('output image from adjacent signal pixel mean method')

else
    
    %'Adaptive weighted method'
   
   fprintf('adaptive weighted algorithm')
   
   a=adwa(a,f,row,col);
   a= a(3:row-2, 3:col-2);
   figure,imshow(a),xlabel('Output image from adaptive weight algorithm')

end
ImRef=I;
ImDis=a;
%mse(k)=PSNR(ImRef,ImDis);
[mse(k),psnr(k)]=PSNR(ImRef,ImDis);

end


figure,plot(noise,mse,'-ro',noise,msemed,'-.b',noise,msewiener,'-*g');xlabel('Noise Level'),ylabel('MSE')
h = legend('adwa','med','wiener');
set(h,'Location','none');

figure,plot(noise,psnr,'-ro',noise,psnrmed,'-.b',noise,psnrwiener,'-*g');xlabel('Noise Level'),ylabel('PSNR')
h = legend('adwa','med','wiener');
set(h,'Location','none');