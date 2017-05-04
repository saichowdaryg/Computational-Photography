%% References:https://www.youtube.com/watch?v=mPWVG6mCu80
%                  saliency is used instead of gradient for energy
%                  except gvbs.m,map.m all other functions are written by me only i.e(delete_rows.m,delete_cols.m, add_cols.m, add_rows.m, 
%                  delete_col_seam.m are written by me only) 

close all;
clear all;

I=imread('2.jpg');
I=rgb2gray(I);
figure;imshow(I);
%[I_c]=add_cols(I,5);
%[I_r]=add_rows(I,50);
%first deleting columns and the rows
%[I_c]=delete_cols(I,20);
[I_r]=delete_rows(I,10);

I_res = mat2gray(I_r,[0 255]);
figure;
imshow(I_res);
