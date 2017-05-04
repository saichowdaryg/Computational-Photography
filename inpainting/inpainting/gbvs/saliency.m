clear all;
p=0.5;
img=imread('s1.jpg');
map = gbvs(img);
I=map.master_map_resized;
figure;imshow(I);
saliency_mask=[];
img_size=size(img);
for i=1:img_size(1),
  for y=1:img_size(2),
     if(map.master_map_resized(i,y)>=p),
        saliency_mask(i,y)=255; 
     end
     if (map.master_map_resized(i,y)<p)
         saliency_mask(i,y)=0;
     end    
     
  end    
end

figure;imshow(saliency_mask);