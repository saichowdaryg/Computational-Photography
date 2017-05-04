%%References: datasets are taken from website for Artefact free HDR Imaging
%             code for gsolve is taken from debvec and malik 
%             code for bilateral filter is also not mine i have taken it
%             from mathworks
%             I had a lot of doubts which I clarified from gagan bhaiyya, raghu and ameya bhaiyya

% the bilateral filter I used is not working properly as a result detail is
% not being acquired, rest of tone mapping part seems to be working fine, so
% to show the result inbuilt matlab function has been used
% ghohsting.m s written after refering to the paper: Artefact free HDR
clc
clear all;
close all;
%% reading the images with known exposures

i1=double((imread('a2.jpg')));
ss=size(i1);
d1=floor(ss(1)/40);
d2=floor(ss(2)/40);
% i1=imresize(i1,[d1*40 d2*40]);
% figure;imshow(uint8(i1));
i2=double((imread('a3.jpg')));
% i2=imresize(i2,[d1*40 d2*40]);
% figure;imshow(uint8(i2));
i3=double((imread('a4.jpg')));
% i3=imresize(i1,[d1*40 d2*40]);
% figure;imshow(uint8(i3));

%% calculating  and lambda
e=[1/250;1/125;1/60];
b=log(e);
lambda=25;
%% calculating w
w=zeros(256);
for i=0:1:255,
    
   if(i<=255/2),
     w(i+1)=  i-0;
   else
     w(i+1)=255-i;
   end    
    
end    
%% calculating z
img_size=size(i1);
n=img_size(1)*img_size(2);
index=round(rand(1000,1)*n);
z=zeros(1000,3,3);

for i=1:1000,
    r=ceil(index(i)/img_size(2));
    c=rem(index(i),img_size(2));
    if(c==0),
      c=img_size(2);
    end    
    z(i,1,:)= i1(r,c,:);
    z(i,2,:)= i2(r,c,:);
    z(i,3,:)= i3(r,c,:);
end
%% get the radiometric calibration function for each colour channel individually
[g1,lE1]=gsolve(z(:,:,1),b,lambda,w);


[g2,lE2]=gsolve(z(:,:,2),b,lambda,w);

[g3,lE3]=gsolve(z(:,:,3),b,lambda,w);


figure;plot(g1);
title('g Function for r channel');
drawnow;
figure;plot(g2);
title('g Function for g channel');
drawnow;
figure;plot(g3);
title('g Function for b channel');
drawnow;

% 


% for i=1:40,
%    for j=1:40,
%        match=[match; g1(i1(i,j,1)), g1(i3(i,j,1))];  
%    end
% end    
% figure;
% plot(match(:,1),match(:,2),'*');
% 
%p=ghosting(g1,g2,g3,i2(700:740,140:180,:)+1,i3(700:740,140:180,:)+1,1/125,1/60);  

%% obtain the HDR image
mr=floor(img_size(1)/40);
mc=floor(img_size(2)/40);
ri=0:mr;
ci=0:mc;

lner = zeros(img_size(1),img_size(2));
lneg = zeros(img_size(1),img_size(2));
lneb = zeros(img_size(1),img_size(2));
for io=1:mr,
for jo=1:mc,
       
         p1=ghosting(g1,g2,g3,i2((ri(io)*40+1):ri(io+1)*40,(ci(jo)*40+1):ci(jo+1)*40,:)+1,i1((ri(io)*40+1):ri(io+1)*40,(ci(jo)*40+1):ci(jo+1)*40,:)+1,1/125,1/250);
         p2=1;
         p3=ghosting(g1,g2,g3,i2((ri(io)*40+1):ri(io+1)*40,(ci(jo)*40+1):ci(jo+1)*40,:)+1,i3((ri(io)*40+1):ri(io+1)*40,(ci(jo)*40+1):ci(jo+1)*40,:)+1,1/125,1/60);
  
% p1=1;p2=1;p3=1;
 for i=(ri(io)*40+1):ri(io+1)*40,  
    for j=(ci(jo)*40+1):ci(jo+1)*40,
      
        %refpatch
        
        %i1 patch
        
        %i3 patch
        
        if i1(i,j,1)==0,
            i1(i,j,1)=1;
        end   
        if i1(i,j,2)==0,
            i1(i,j,2)=1;
        end   
        if i1(i,j,3)==0,
            i1(i,j,3)=1;
        end
        
        if i2(i,j,1)==0,
            i2(i,j,1)=1;
        end   
        if i2(i,j,2)==0,
            i2(i,j,2)=1;
        end   
        if i2(i,j,3)==0,
            i2(i,j,3)=1;
        end
        
        if i3(i,j,1)==0,
            i3(i,j,1)=1;
        end   
        if i3(i,j,2)==0,
            i3(i,j,2)=1;
        end   
        if i3(i,j,3)==0,
            i3(i,j,3)=1;
        end
        lner(i,j)= ( [p1*w(i1(i,j,1))*(g1(i1(i,j,1))-b(1))]+ [p2*w(i2(i,j,1))*(g1(i2(i,j,1))-b(2))] + [p3*w(i3(i,j,1))*(g1(i3(i,j,1))-b(3))] )/(p1*w(i1(i,j,1))+p2*w(i2(i,j,1))+p3*w(i3(i,j,1)));
        lneg(i,j)= ( [p1*w(i1(i,j,2))*(g2(i1(i,j,2))-b(1))]+ [p2*w(i2(i,j,2))*(g2(i2(i,j,2))-b(2))] + [p3*w(i3(i,j,2))*(g2(i3(i,j,2))-b(3))] )/(p1*w(i1(i,j,2))+p2*w(i2(i,j,2))+p3*w(i3(i,j,2)));
        lneb(i,j)= ( [p1*w(i1(i,j,3))*(g3(i1(i,j,3))-b(1))]+ [p2*w(i2(i,j,3))*(g3(i2(i,j,3))-b(2))] + [p3*w(i3(i,j,3))*(g3(i3(i,j,3))-b(3))] )/(p1*w(i1(i,j,3))+p2*w(i2(i,j,3))+p3*w(i3(i,j,3)));    
    end
   end
 end    
end
%% making the HDR image by combining the three channels
size_E=size(lner);
E = zeros(size_E(1),size_E(2),3);
E(:,:,1) = exp(lner);
E(:,:,2) = exp(lneg);
E(:,:,3) = exp(lneb);

%% checking with inbuilt matlab function

II = tonemap(E);
figure;imshow(II(1:mr*40,1:mc*40,:));
imwrite(II(1:mr*40,1:mc*40,:),'result.jpg');
% load('E.mat');
% %% tone mapping
% %%I referred to ppt of Fredo Durand for this part    
% transform = makecform('srgb2lab');
% lab_hdr = applycform(E, transform);
% 
% log_intensity = double(log(lab_hdr(:,:,1)));
% figure;imshow(log_intensity);
% large_scale= bfilter2(log_intensity,12,10);
% figure;imshow(large_scale);
% detail=log_intensity-large_scale;
% figure;imshow(detail);
% large_range = max(max(large_scale))-min(min(large_scale));
% f=10000;
% k=log10(f)/large_range;
% output=detail+large_scale*k-min(min(large_scale));
% output=exp(output);
% lab_hdr(:,:,1) = output;
% 
% 
% transform = makecform('lab2srgb');
% out_img = applycform(lab_hdr, transform);
% figure;imshow(out_img);