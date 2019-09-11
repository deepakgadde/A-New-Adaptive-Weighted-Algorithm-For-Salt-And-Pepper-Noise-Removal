function f=labelmatrix(a,row,col)
b=0;

  for x=1:row
      for y=1:col  
            
            if a(x,y)==255 
               f(x,y)=1;
          
            elseif a(x,y)==0 
               f(x,y)=-1;
            else
               f(x,y)=0;
            end
      end
  end
