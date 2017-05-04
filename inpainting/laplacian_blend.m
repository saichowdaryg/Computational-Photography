%% References:https://www.youtube.com/watch?v=g7zFl8EnbzI, i also referre mathworks for a few functions
%                   I have taken the dataset from internet(i have attached
%                   the zip folder containing the dataset, the zip folder contains the dataset
%                   and some other functions BUT i have NOT used those functions in the code 
function b_img=laplcian_blend(ag0,og0,am0);

%% gaussian pyramid of apple
%ag0=rgb2gray(im2double(imread('apple1.jpg')));
k=fspecial('gaussian',10,10);
ag0_b=imfilter(ag0,k);
ag1=imresize(ag0_b,0.5);
ag1_b=imfilter(ag1,k);
ag2=imresize(ag1_b,0.5);
ag2_b=imfilter(ag2,k);
ag3=imresize(ag2_b,0.5);
ag3_b=imfilter(ag3,k);
ag4=imresize(ag3_b,0.5);

% figure;imshow(ag0);
% figure;imshow(ag1);
% figure;imshow(ag2);
% figure;imshow(ag3);
% figure;imshow(ag4);

%% laplacian pyramid of apple
al0=ag0-ag0_b;
al1=ag1-ag1_b;
al2=ag2-ag2_b;
al3=ag3-ag3_b;
al4=ag4;
% figure;imshow(al0);
% figure;imshow(al1);
% figure;imshow(al2);
% figure;imshow(al3);
% figure;imshow(al4);



%% gaussian pyramid of orange
%og0=rgb2gray(im2double(imread('orange1.jpg')));
%k=fspecial('gaussian',10,2);
og0_b=imfilter(og0,k);
og1=imresize(og0_b,0.5);
og1_b=imfilter(og1,k);
og2=imresize(og1_b,0.5);
og2_b=imfilter(og2,k);
og3=imresize(og2_b,0.5);
og3_b=imfilter(og3,k);
og4=imresize(og3_b,0.5);

% figure;imshow(og0);
% figure;imshow(og1);
% figure;imshow(og2);
% figure;imshow(og3);
% figure;imshow(og4);

%% laplacian pyramid of apple
ol0=og0-og0_b;
ol1=og1-og1_b;
ol2=og2-og2_b;
ol3=og3-og3_b;
ol4=og4;

% figure;imshow(ol0);
% figure;imshow(ol1);
% figure;imshow(ol2);
% figure;imshow(ol3);
% figure;imshow(ol4);




% % % figure;imshow(imresize(l4,size(g0)));
% % % figure;imshow(imresize(l3,size(g0)));
% % % figure;imshow(imresize(l2,size(g0)));
% % % figure;imshow(imresize(l1,size(g0)));

% r_img1=imresize(imresize(imresize(imresize(al4,size(al3))+al3,size(al2))+al2, size(al1))+al1,size(al0)) +al0;
% figure;imshow(r_img1);
% r_img=imresize(al4,size(ag0))+imresize(al3,size(ag0))+imresize(al2,size(ag0))+imresize(al1,size(ag0))+al0;
% figure;imshow(r_img);

%% gaussian pyramid of the mask for apple

% am0 = zeros(size(ag0));
% am0(:,150:230) = 1;
%figure;imshow(m0);

am0_b=imfilter(am0,k);
am1=imresize(am0_b,0.5);
am1_b=imfilter(am1,k);
am2=imresize(am1_b,0.5);
am2_b=imfilter(am2,k);
am3=imresize(am2_b,0.5);
am3_b=imfilter(am3,k);
am4=imresize(am3_b,0.5);

% figure;imshow(am0);
% figure;imshow(am1);
% figure;imshow(am2);
% figure;imshow(am3);
% figure;imshow(am4);

%laplacian pyramid of the blended image

bl0=al0.*am0+ ol0.*(1-am0);
bl1=al1.*am1+ ol1.*(1-am1);
bl2=al2.*am2+ ol2.*(1-am2);
bl3=al3.*am3+ ol3.*(1-am3);
bl4=al4.*am4+ ol4.*(1-am4);

%figure;imshow(bl0);
%figure;imshow(bl1);
%figure;imshow(bl2);
%figure;imshow(bl3);
%figure;imshow(bl4);

 b_img=imresize(bl4,size(ag0))+imresize(bl3,size(ag0))+imresize(bl2,size(ag0))+imresize(bl1,size(ag0))+bl0;
 %figure;imshow(uint8(b_img));



