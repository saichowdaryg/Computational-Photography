%% References:https://www.youtube.com/watch?v=mPWVG6mCu80
%% logic followed: first the object to be removed is made white, and in that portion the saliency map is attenuated
%                  so that while computing the I_S i.e energy of seam, the path with these pixels will be preferred over others.                  
%                  except gvbs.m,map.m all other functions are written by me only i.e(delete_rowsq2.m,delete_col_seam.m are written by me only) 

close all;
clear all;

p=0.5;
I=imread('ab.jpg');
I=rgb2gray(I);
I=transpose(I)
figure;
imshow(I);
% map = gbvs(I);
% I_energy=map.master_map_resized;
% figure;
% imshow(I_energy);
I2=imread('abc.jpg');
I2=rgb2gray(I2);
I2=transpose(I2);
figure;
imshow(I2);
I2_size=size(I2);
for i=1:I2_size(1),
    for j=1:I2_size(2),
       if I2(i,j)>230,
           I2(i,j)=0;
       else
           I2(i,j)=1;
       end    
    end  
end    
% figure;
% imshow(I2);
[I_r]=delete_rowsq2(I,20,I2);

I_res = mat2gray(I_r,[0 255]);
figure;
imshow(I_res);
% figure;
% imshow(I_energy);














% saliency_mask=[];
% img_size=size(I);
% for i=1:img_size(1),
%   for y=1:img_size(2),
%      if(map.master_map_resized(i,y)>=p),
%         saliency_mask(i,y)=255; 
%      end
%      if (map.master_map_resized(i,y)<p)
%          saliency_mask(i,y)=0;
%      end    
%      
%   end    
% end
% 
% figure;imshow(saliency_mask);