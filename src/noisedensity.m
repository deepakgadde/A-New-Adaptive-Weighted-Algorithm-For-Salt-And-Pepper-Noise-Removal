function N=noisedensity(a,row,col)
count=0;

  for x=3:row-2     
       for y=3:col-2     
           
            if( a(x,y)==0 || a(x,y)==255) 
                 count =count+1;  
            end
           
       end
   end
N=count/(row*col)
