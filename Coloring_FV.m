    clc
    clear all
    
    n = randi([1 10],1,1);
    m = randi([1 10],1,1);
    
    matrix= random_unit_vector(m,n);
    color=zeros(1,n) ; %initialize it with all zeros
   
    while (~(all(abs(color(:))==1) ))

        clearvars -except color matrix n m

    %-----------step 1 ------------

    A=find(color <1 & color>-1);
    maximum=max(A);

    %------------------------------

    %-----------step 2 ------------

    update_direction_all=sym('x',[1 n]);
    update_direction_all(maximum) = 1;

    for j=1:n
        if(color(j)==1 || color(j)==-1)
          update_direction_all(j) = 0;
        end
    end

    for q=1:length(A)-1
        new_matrix(:,q)=matrix(:,A(q));
    end

    p=0;
    final_V_orthogonal=0;
    
    if(length(A)>1)
        orth=orth(new_matrix);
      %  if(rank(orth)~=m)
            disp("here we are");
         p=orth*pinv(transpose(orth)* orth)*transpose(orth)*matrix(:,maximum);
         final_V_orthogonal=matrix(:,maximum)-p;
       % end
    end
 
    r=final_V_orthogonal- matrix(:,maximum);
    const=r;
    disp('----r_first---');
    disp(vpa(norm(r)));
    disp('----------');

    for q=1:length(A)-1
        update_direction_all(A(q))=(inner(r,matrix(:,A(q))))/norm(matrix(:,A(q)))^2;
        r=r-(update_direction_all(A(q)).* matrix(:,A(q)));
        disp('----r---');
        disp(vpa(norm(r)));
        disp('----------');
    end

    %--------------checking if sigma is near to zero
    clear sigma_of_matrix

    sigma_of_matrix=0;

    for q=1:length(A)-1
        sigma_of_matrix=matrix(:,A(q)).* update_direction_all(A(q))+sigma_of_matrix;
    end
    near_zero=const-sigma_of_matrix;

    disp('-----near_zero_vpa----');
    disp(vpa(near_zero));
    disp('-----near_zero_end_vpa----');

    %-----------------------------------------------


    %-------------finding delta--------
    clear un
    syms un

    for i=1:length(A)
       all_delta(i)=(1-(color(A(i))))/update_direction_all(A(i));
    end
    for j=1:length(A)
       all_delta_m(j)=(-1-(color(A(j))))/(update_direction_all(A(j)));
    end

    for ii = 1:length(all_delta)
             TempCalc(ii) = abs(all_delta(ii) - 0);
    end

    for jj = 1:length(all_delta_m)
             m_TempCalc(jj) = abs(all_delta_m(jj) - 0);
    end

    p_delta=min(TempCalc);
    m_delta=min( m_TempCalc).* -1;

    rvals =[m_delta, p_delta];
    r = randi([1, 2], 1);
    delta=rvals(r);
    %-------------------------------

    for i=1:length(update_direction_all)
       color(1,i)= int8(color(1,i)+delta*update_direction_all(1,i));   
    end

    disp('The new colorings:');
    disp(color);

    end

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

