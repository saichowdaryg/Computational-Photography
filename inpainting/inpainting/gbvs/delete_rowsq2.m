function [I_r]= delete_rows(I,n,I2)


I=(I);
map = gbvs(I);
I_energy = map.master_map_resized; 
s=size(I_energy);
for i=1:s(1),
    for j=1:s(2),
       if I2(i,j)==0,
           I_energy(i,j)=-100000000;
       end  
    end  
end   

s=size(I_energy);
I_S = zeros(s);
I_S(1,:) = I_energy(1,:);

I_energy=I_energy .* double((I2));
 figure;
 imshow(I_energy);
 I_energy_size=size(I_energy);
 for i=1:I_energy_size(1),
    for j=1:I_energy_size(2),
       if I_energy(i,j)>0,
           I_energy(i,j)=1;
       else
           I_energy(i,j)=0;
       end    
    end  
end    
 
  figure;
 imshow(I_energy);
for i = 2:s(1),
    for j = 1: s(2),
        A=[];        
        
        A(2)=I_S(i-1,j);
        if(j==1),
            A(1)=1/0;
        else
            A(1)=I_S(i-1,j-1);
        end 
        if(j==s(2)),
            A(3)=1/0;
        else
            A(3)=I_S(i-1,j+1);
        end 
        I_S(i,j)= min(A)+I_energy(i,j);
    end
end    
% figure;
% imshow(I_S);
I_original=I;

%deleting 'n' column seam inputs I,I_S,
% n=50;
for a=1:n,
    [I_new,I_S_new]= delete_col_seam(I,I_S);
    I=I_new;
    I_S=I_S_new;
end
% I = mat2gray(I,[0 255]);


I_r=(I);


