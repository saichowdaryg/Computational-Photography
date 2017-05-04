%% the 2homography functions are taken from internet
%% References:http://cs.adelaide.edu.au/~hwong/doku.php?id=data
close all;
clear all;
i1=double(imread('14.jpg'));
i2=double(imread('21.jpg'));

% transform = makecform('srgb2lab');
% lab_i1 = applycform(i1, transform);
% lab_i2 = applycform(i2, transform);
% m1=mean(mean(lab_i1(:,:,1)));
% m2=mean(mean(lab_i2(:,:,1)));
% m31=mean(mean(i1(:,43:44)));
% m32=mean(mean(i1(:,251:252)));
% m41=mean(mean(i2(:,45:46)));
% m42=mean(mean(i2(:,249:250)));
% cols=250-45+1;
% ml=m31/m41;
% mr=m32/m42;
% md=mr-ml;
% dx=md/cols;
% m=ml:dx:mr;

    
[ h wim1 ] = homography( i1, i2);


i_new=i1;


size_img=size(i1);



i_new(:,:,:)=0;



for i=1:size_img(1),
    for j=1:1:size_img(2),
        
            y = homography_transform([i j].', h);
              location=round(y.');
              location(1)=location(1)+9;
              location(2)=location(2)-10;
             
              if location(1)>0 && location(1)<size_img(1) && location(2)>0 && location(2)<size_img(2),
                    i_new(i,j,:)=i2(location(1),location(2),:); 
               
              end
        
    end
end
figure;
imshow(uint8(i1));

figure;
imshow(uint8(i2));

figure;
imshow(uint8(i_new));
wlb=i_new;
imwrite(uint8(i_new),'without laplacian blending.jpg');

% cropped=wlb(:,45:250,:);
% figure;imshow(uint8(cropped));
% size_cropped=size(cropped);
%  cropped2=cropped;
% for i=1:size_cropped(2),
%     cropped2(:,i,:)=cropped(:,i,:)*m(i);
% end    
% 
% figure;imshow(uint8(cropped2));


%% histogram

% cropped=wlb(:,45:250,:);
% figure;imshow(uint8(cropped));
% h=imhist(rgb2gray(uint8(cropped)));
% size_cropped=size(cropped);
% p1=105;
% p2=160;
% d=15;
% for i=1:size_cropped(1),
%     for j=1:size_cropped(2),
%         if (cropped(i,j)>= (p1-d) & cropped(i,j)<=(p1+d)) | (cropped(i,j)>= (p2-d) & cropped(i,j)<=(p2+d)),
%             cropped(i,j,:)=cropped(i,j,:);
%         else
%             cropped(i,j,:)=0;
%         end    
%     end
% end    
% figure;imshow(uint8(cropped));


%% laplacian
% i_new(:,45:250,:)=cropped2;
% figure;imshow(uint8(i_new));
% for i=1:34,
%    i_new(:,i,:)=i_new(:,35,:);  
% end
% for i=261:size_img(2),    
%    i_new(:,i,:)=i_new(:,260,:);  
% end 
figure;
imshow(uint8(i_new));
mask=zeros(size_img(1),size_img(2));
mask(:,:)=1;
mask(:,45:320)=0;
I=i1;
I(:,:,1)=laplacian_blend(i1(:,:,1),i_new(:,:,1),mask);
I(:,:,2)=laplacian_blend(i1(:,:,2),i_new(:,:,2),mask);
I(:,:,3)=laplacian_blend(i1(:,:,3),i_new(:,:,3),mask);

figure;
imshow(uint8(I));
imwrite(uint8(I),'after blending.jpg');

%% seam carving

I3=imread('after blending.jpg');
I4=imread('abc.jpg');
I_r=delete(I3(:,:,1),I4(:,:,1));
I_g=delete(I3(:,:,2),I4(:,:,2));
I_b=delete(I3(:,:,3),I4(:,:,3));
I=I(1:size_img(1)-24,:,:);
I(:,:,1)=transpose(mat2gray(I_r,[0 255]));
I(:,:,2)=transpose(mat2gray(I_g,[0 255]));
I(:,:,3)=transpose(mat2gray(I_b,[0 255]));

figure;
imshow(I);
imwrite(I,'result.jpg');
% 
% % I2=I/2+wlb/2;
% % figure;
% % imshow(uint8(I2));
% % imwrite(uint8(I2),'after averaging.jpg');
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % %% poisson
% % 
% % i_source = i_new(:,45:250,:);
% % mask = i_new;
% % mask(:,45:250,:) = 255;
% % mask(:,1:44,:) = 0;
% % mask(:,251:size_img(2),:) = 0;
% % figure;imshow(uint8(i_source));
% % figure;imshow(uint8(mask));
% % %shift=[45,0];
% % h = [0 -1 0; -1 4 -1; 0 -1 0];
% % lap_s = imfilter(i_source, h, 'replicate');
% % figure;imshow(uint8(lap_s));
% % it=i1
% % it(:,45:250,:)=lap_s;
% % figure;imshow(uint8(it));
% % 
% % %figure, imagesc(uint8(TargImPaste)), axis image, title('Target image with laplacian of source inserted');
% % TargFilled = PoissonColorImEditor(it, mask);
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%% not working
% % % % % % % % % i_new2=i_new(:,45:250,:);
% % % % % % % % % figure;imshow(i_new2);
% % % % % % % % % 
% % % % % % % % % [mh mv]= imgrad(i_new2);
% % % % % % % % % [oh ov]= imgrad(i1);
% % % % % % % % % 
% % % % % % % % % x=i_new;
% % % % % % % % % 
% % % % % % % % % fh=oh;
% % % % % % % % % fv=ov;
% % % % % % % % % 
% % % % % % % % % fh(:,45:250,:)=mh;
% % % % % % % % % fv(:,45:250,:)=mv;
% % % % % % % % % mask=zeros(size(x));
% % % % % % % % % mask(:,45:250,:)=1;
% % % % % % % % % 
% % % % % % % % % Y = PoissonGaussSeidel( x, fh, fv, mask );
% % % % % % % % % imwrite(uint8(Y),'Ygs.png');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% % % % % % % % a=size(i1);
% % % % % % % % ih=zeros(a);
% 
% % % % % % % % 
% % % % % % % % for i=1:a(1),
% % % % % % % %     for j=1:a(2),
% % % % % % % %        if(i3(i,j,1)>200 & i3(i,j,2)< 50 & i3(i,j,3)<50 ),
% % % % % % % %                i3(i,j,:)=[0 0 0];
% % % % % % % %        end    
% % % % % % % %     end    
% % % % % % % % end
% 
% 
% % % % % c=0;
% % % % % h2=inv(h);
% % % % % for i=1:a(1),
% % % % %     for j=1:a(2),
% % % % %        if( i3(i,j)==0 ),
% % % % %            a=h*[i j 1]';
% % % % %            b=[a(1)/a(3) a(2)/a(3)];
% % % % %            i2(i,j,:) =i1(floor(b(1)),floor(b(2)),:);
% % % % %            c=c+1
% % % % %        end    
% % % % %     end    
% % % % 
% % % % 
% % % % % end
% 
% 
