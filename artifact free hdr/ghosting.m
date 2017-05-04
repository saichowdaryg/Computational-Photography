function p= ghosting(g1,g2,g3,ir,i2,tr,t2);

 %figure;plot(g1(ir(1:40,1:40,1)+1),g1(i2(1:40,1:40,1)+1),'*');
 %figure;plot(g1(ir+1),g1(i2+1),'*');
t=0.25;
percent=0.7;
cr=0;
cg=0;
cb=0;
%% r channel
matchr=[];
for i=1:40,
   for j=1:40,
       matchr =[matchr; g1(ir(i,j,1)), g1(i2(i,j,1))];  
   end
end    
% figure;
% plot(matchr(:,1),matchr(:,2),'*');
x=matchr(:,1);
y= matchr(:,2);
ey=x+log(t2/tr);
%figure;plot(x,ey,'*');
d=abs(ey-y);
mean(d);
for i=1:1600,
   if d(i)< t,
   cr=cr+1;
   end    
end
cr
%% g channel
matchg=[];
for i=1:40,
   for j=1:40,
       matchg=[matchg; g2(ir(i,j,2)), g2(i2(i,j,2))];  
   end
end    
% figure;
%plot(matchg(:,1),matchg(:,2),'*');
x=matchg(:,1);
y= matchg(:,2);
ey=x+log(t2/tr);
% figure;plot(x,ey,'*');
d=abs(ey-y);
mean(d);
for i=1:1600,
   if d(i)<t,
   cg=cg+1;
   end    
end
cg
%% b channel
matchb=[];
for i=1:40,
   for j=1:40,
       matchb=[matchb; g3(ir(i,j,2)), g3(i2(i,j,2))];  
   end
end    
% figure;
% plot(matchb(:,1),matchb(:,2),'*');
x=matchb(:,1);
y= matchb(:,2);
ey=x+log(t2/tr);
%figure;plot(x,ey,'*');
d=abs(ey-y);
mean(d);
for i=1:1600,
   if d(i)<t,
   cb=cb+1;
   end    
end
cb
if max([cr cg cb])>percent*1600,
   p=1;
else
    p=0;
end    

end