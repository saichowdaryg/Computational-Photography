%%http://in.mathworks.com/help/matlab/ref/rgb2gray.html
%   http://in.mathworks.com/help/matlab/ref/svd.html
%   http://in.mathworks.com/matlabcentral/answers/2327-how-do-i-apply-svd-singular-value-decomposition-to-an-image
%   
close all;
clear all;
%reading the figure
img1=(imread('goku.jpg'));
figure;
imshow(img1);
%seperating the channels
imgr=img1(:,:,1);
imgg=img1(:,:,2);
imgb=img1(:,:,3);
imgr=im2double(imgr);
imgg=im2double(imgg);
imgb=im2double(imgb);
% figure;
% imshow(imgr);
% figure;
% imshow(imgg);
% figure;
% imshow(imgb);


%applying svd and retaining only a few diagonal elements
[ur,sr,vr]=svd(imgr);
r=min(size(sr));
d=71;
for i=d:r,
    sr(i,i)=0;
end
sr=sr(1:d,1:d);
ur=ur(:,1:d);
vr=vr(:,1:d);
img2r=ur*sr*vr';

[ug,sg,vg]=svd(imgg);
r=min(size(sg));
d=71;
for i=d:r,
    sg(i,i)=0;
end
sg=sg(1:d,1:d);
ug=ug(:,1:d);
vg=vg(:,1:d);
img2g=ug*sg*vg';


[ub,sb,vb]=svd(imgb);
r=min(size(sb));
d=71;
for i=d:r,
    sb(i,i)=0;
end
sb=sb(1:d,1:d);
ub=ub(:,1:d);
vb=vb(:,1:d);
img2b=ub*sb*vb';

%concatenating and displaying the output rgb image
img2=cat(3,img2r,img2g,img2b);
figure;
imshow(img2);


%here in each channel we have reduced the columns from around 3000 to 71 in
%U,V matrices and also S is now 71*71 i.e we have reduced the storage space
%i.e we have compressed the image.