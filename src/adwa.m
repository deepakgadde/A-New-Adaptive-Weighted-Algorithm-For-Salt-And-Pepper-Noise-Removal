function a=adwa(a,f,row,col)

V=[0.25 0.5 0.25;0.5 0 0.5;0.25 0.5 0.25];
U=0;
count=0;n=0;
for x=2:1:row-1
    for y=2:1:col-1 
        tem=[a(x-1,y-1) a(x-1,y) a(x-1,y+1);a(x,y-1) a(x,y) a(x,y+1);a(x+1,y-1) a(x+1,y) a(x+1,y+1)];
        t=mean2(tem);
        
        
           if(f(x-1,y-1)==0)
              a(x-1,y-1)=a(x-1,y-1);
           else
             
           S3=0;
              
                   for i=1:1:3
                      for j=1:1:3
                       
                         if( tem(i,j) ~= 0 || tem(i,j)~=255)
                                 S3=S3+1;
                         end
                       
                      end
                   end
          
            if(S3==0)
            break
           
            else
                 for k=1:3
                      for l=1:3
                     
                         if (f(x-1,y-1)~=0)
                             Dvalue=abs(double(tem(k,l))-t);
                             U(k,l)=double(1/Dvalue); 
                         else
                             U(k,l)=0;
                         end
                             T(k,l)=U(k,l)*V(k,l);   
                            
                      end
                  end
             
               D=T/sum(sum(T));
               o=0;
                    for i=1:3
                        for j=1:3
                             o=o+(D(i,j)*tem(i,j));
                        end
                    end
                        out(x-1,y-1)=o;
            end
           end
     end
end

   
       for x=1:row-2
           for y=1:col-2
                 if(f(x,y)==0)
                     a(x,y)=a(x,y);
                 else
                     a(x,y)=out(x,y);
            
                 end
               
           end
       end 

end

