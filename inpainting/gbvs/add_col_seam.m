function [I_n,I_S_n]= add_col_seam(I_o,I_S_o)

size_I_S = size(I_S_o);
I_n = zeros(size_I_S(1),size_I_S(2)+1);
I_S_n=zeros(size_I_S(1),size_I_S(2)+1);
[minimum,index1]= min(I_S_o(size_I_S(1),:));

I_n(size_I_S(1),1:index1)= I_o(size_I_S(1),1:index1);
I_S_n(size_I_S(1),1:index1)= I_S_o(size_I_S(1),1:index1);

I_n(size_I_S(1),index1+2:size_I_S(2)+1)= I_o(size_I_S(1),index1+1:size_I_S(2));
I_S_n(size_I_S(1),index1+2:size_I_S(2)+1)= I_S_o(size_I_S(1),index1+1:size_I_S(2));

%col addition in last row
if index1== size_I_S(2),
    I_n(size_I_S(1),index1+2)= (I_o(size_I_S(1),index1-1)+I_o(size_I_S(1),index1))/2;
else
    I_n(size_I_S(1),index1+2)= (I_o(size_I_S(1),index1)+I_o(size_I_S(1),index1+1))/2;
end


for i= size_I_S(1)-1:-1:1,
        B=[];
        B(2)=I_S_o(i,index1);
        if index1==1
            B(1)=1/0;
        else
            B(1)=I_S_o(i,index1-1);
        end
        if index1==size_I_S(2),
            B(3)=1/0;
        else
            B(3)=I_S_o(i,index1+1);
        end
        [minimum,index2]= min(B);
        
        I_n(i,1:index1+index2)= I_o(i,1:index1+index2);
        I_S_n(i,1:index1+index2)= I_S_o(i,1:index1+index2);
        
        
        I_n(i,index1+index2+2:size_I_S(2)+1)= I_o(i,index1+index2+1:size_I_S(2));
        I_S_n(i,index1+index2+2:size_I_S(2)+1)= I_S_o(i,index1+index2+1:size_I_S(2));
        %col addition in last row
if index1== size_I_S(2),
    I_n(i,index1+2)= (I_o(i,index1-1)+I_o(i,index1))/2;
else
    I_n(i,index1+2)= (I_o(i,index1)+I_o(i,index1+1))/2;
end
        
end    


%I_n = mat2gray(I_n,[0 255]);
