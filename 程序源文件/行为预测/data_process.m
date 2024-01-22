%%%%%%%%%%批量处理LEAP结果坐标数据计算关节夹角；比较角大小选择较小角；计算同一帧的两角度之差；计算上肢和下肢的距离差；计算相邻帧下肢的距离差；
clear
clc
% m7=zeros(0,20);
% m8=zeros(0,20);
m11=zeros(0,1);
m18=zeros(0,1);
inv_m7=zeros(0,1);
% m11=zeros(0,1)
 for k=1:12
     path=strcat('C:\Users\Administrator\Desktop\关节\walk_',(int2str(k)),'.mat');
     B=importdata(path);
%       x=B(:,1,1);
%       y=B(:,2,1);
%       figure(k)
%      plot(x,y)
%B=importdata('C:\Users\Administrator\Desktop\关节\run_10.mat');
  % B=A(:,:,1:10);
%B=A(~isnan(A));%删除NAN
%B=ceil(B);
[d,e,f]=size(B);
 
% 
%%%计算角度%%%
for i=1:f
    for j=1:3:d
        x1=B(j,1,i);y1=B(j,2,i);
        x2=B(j+1,1,i);y2=B(j+1,2,i);
        x3=B(j+2,1,i);y3=B(j+2,2,i);
        a2 = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
        b2 = (x3-x2)*(x3-x2)+(y3-y2)*(y3-y2);
        c2 = (x1-x3)*(x1-x3)+(y1-y3)*(y1-y3);
        a = sqrt(a2);
        b = sqrt(b2);
        c = sqrt(c2);
        pos = (a2+b2-c2)/(2*a*b);
        angle = acos(pos);         
        realangle = angle*180/pi;   
      %  disp(realangle);
        inv_m7= cat(1,inv_m7,realangle); 
  
    end
end 
 m11=cat(1,m11,inv_m7);
 [c1,c2]=size(m11);
 m12=reshape(m11,2,c1/2);
 %m12=m12';
 [c3,c4]=size(m12);
 m13=reshape(m12,c4/5*2,5);
 m11=[];
 %inv_m7=[];
 end
  for i=1:c4/5
     H(i,1)=5;
 end
G = mat2cell(m12,2,H);
% %     figure(k)
% %      plot(inv_m7)
% %      ylim([0 180]);

 %end
%%%计算角度最小值%%%
%         [a11,a22]=size(inv_m7);
%        C=reshape(inv_m7',2,a11/2);
     % C=C';
%        for i=1:a11/2
%            E(i) = min(C(i,1),C(i,2));
%        
%        end
%    
%  %end 
%       m17=cat(1,m17,E'); 
%       %m18= cat(1,m18,m17); 
%      [g,h]=size(m17);
%      m9=reshape(m17,g/5,5);
%      g
%      E=[];
%      inv_m7=[];
%
%      
% %计算角度差%%%
%         [a1,a2]=size(inv_m7);
%        C=reshape(inv_m7',2,a1/2);
%       C=C';
%       for i=2:5:a1/2-3      
%            D(1)=C(i-1,1)-C(i,1);
%            D(2)=C(i-1,1)-C(i+1,1);
%            D(3)=C(i-1,1)-C(i+2,1);
%            D(4)=C(i-1,1)-C(i+3,1); 
%            D(5)=C(i-1,2)-C(i,2);
%            D(6)=C(i-1,2)-C(i+1,2);
%            D(7)=C(i-1,2)-C(i+2,2);
%            D(8)=C(i-1,2)-C(i+3,2);
%            
%            D(9)=C(i,1)-C(i+1,1);
%            D(10)=C(i,1)-C(i+2,1);
%            D(11)=C(i,1)-C(i+3,1);
%            D(12)=C(i,2)-C(i+1,2);
%             D(13)=C(i,2)-C(i+2,2);
%            D(14)=C(i,2)-C(i+3,2);
%         
%            D(15)=C(i+1,1)-C(i+2,1);
%            D(16)=C(i+1,1)-C(i+3,1);
%            D(17)=C(i+1,2)-C(i+2,2);
%            D(18)=C(i+1,2)-C(i+3,2);
%           
%            D(19)=C(i+2,1)-C(i+3,1);
%            D(20)=C(i+2,2)-C(i+3,2);
%          
%            D=abs(ceil(D));
%            m7=cat(1,m7,D);
%           
%       end
%        m8= cat(1,m8,m7); 
%        m10=cat(2,m8,m9);
% end
      %%计算上下肢距离差%%
%     for i=1:f
%     for j=1:6:d
%         x1=B(j,1,i);y1=B(j,2,i);%左上
%         x2=B(j+3,1,i);y2=B(j+3,2,i);%右上
%         x3=B(j+2,1,i);y3=B(j+2,2,i);%左下
%         x4=B(j+5,1,i);y4=B(j+5,2,i);%右下
%         a2 = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
%         b2 = (x3-x4)*(x3-x4)+(y3-y4)*(y3-y4);
%        A=a2/b2; 
%       %  disp(realangle);
%         inv_m7= cat(1,inv_m7,A); 
%        
%     end
%     end 


      %%计算临帧下肢距离差%%
%     for i=1:f-1
%     for j=1:6:d
%         x1=B(j+2,1,i+1);y1=B(j+2,2,i+1);%后帧左下
%         x2=B(j+5,1,i+1);y2=B(j+5,2,i+1);%后帧右下
%         x3=B(j+2,1,i);y3=B(j+2,2,i);%左下
%         x4=B(j+5,1,i);y4=B(j+5,2,i);%右下
%         a2 = (x1-x2)*(x1-x2)+(y1-y2)*(y1-y2);
%         b2 = (x3-x4)*(x3-x4)+(y3-y4)*(y3-y4);
%        A=a2/b2; 
%       %  disp(realangle);
%         inv_m7= cat(1,inv_m7,A); 
%       
%     end
%     end 
%       [n,m]=size(inv_m7);
%        m7=reshape(inv_m7,2,n/2);
%        m7=m7'
 
% mat = reshape(B,1,24);
%B(1,2,1)