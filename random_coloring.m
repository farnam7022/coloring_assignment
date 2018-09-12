    n =50;
    m = 50;
    %n = randi([1 10],1,1);
    %m = randi([1 10],1,1);
    matrix= random_unit_vector(m,n);
    color=zeros(1,n) ; 
    colorings = [1,-1];
    
    for i=1:n
        r= randi([1, 2], 1); 
        color(1,i)=colorings(r);
    end
    
    disp(color);
    
    cpr=zeros(1,m) ;

    
      if (all(abs(color(:))==1) )
          disp("end of coloring assignment");
          for j=1:m
           for i=1:length(color)
               if (j-1>0)
           cpr(1,j)=color(1,i)*matrix(j,i)+cpr(1,j-1); 
               else 
                    cpr(1,j)=color(1,i)*matrix(j,i);
               end
           end
          end
          
          for j=1:m
              cpr(1,j)=abs(cpr(1,j));
          end
          
          
          disp(cpr);
          disp('----------------');
          disp(max(cpr));
          disp('----------------');
      end