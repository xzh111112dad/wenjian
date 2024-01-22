%%%%%%%给成三点计算所围成的夹角角度；将大矩阵分割成cell形式的数组，用于LSTM的样本;生成categorical格式的数据，用于LSTM的标签集
clear
clc
F=zeros(0,5);
  for k=35:35
       path=strcat('C:\Users\Administrator\Desktop\关节1\s',(int2str(k)),'.mat');
       A=importdata(path);
 %A=importdata('C:\Users\Administrator\Desktop\关节1\s36.mat');
     B=A(~isnan(A));%删除NAN
     [a,b]=size(B);
     C=reshape(B,5,a/5);
     C([2,3],:)=C([3,2],:);
     for i=1:2:a/5
        for j=1:4
          x(j)=C(j,i);y(j)=C(j,i+1);
%         x2=C(2,i);y2=C(2,i+1);
%         x3=C(3,i);y3=C(3,i+1);
%          x4=C(4,i);y4=C(4,i+1);
          x5=C(5,i);y5=C(5,i+1);
          a2 = (x(j)-x5)*(x(j)-x5)+(y(j)-y5)*(y(j)-y5);
          b2 = (x5-x5)*(x5-x5)+(190-y5)*(190-y5);
          c2 = (x(j)-x5)*(x(j)-x5)+(y(j)-190)*(y(j)-190);
          a3 = sqrt(a2);
          b3 = sqrt(b2);
          c3 = sqrt(c2);
          pos = (a2+b2-c2)/(2*a3*b3);
          angle = acos(pos);   
          realangle(i,j) = angle*180/pi;
   
        end
      end

realangle(all(realangle==0,2),:)=[];
D=realangle';
[d1,d2]=size(D);
E=reshape(D,4*d2/5,5);
F=cat(1,F,E);
realangle=[];
  end
% a=importdata('XIAO1.mat');
% b=importdata('XIAO2.mat');
% c=importdata('XIAO3.mat');
% F=cat(1,a,b,c);
%  for i=1:139
%      H(i)=1;
%  end
% G=mat2cell(F,[H],[5])
 M=[1;2;3]
 Y=categorical(M)
% Y(1:49)='1';
% Y(50:102)='2';
% Y(103:139)='3';
% % for i=2:a2
% %     for j=1:4
% %     E(j,i-1)=D(j,i-1)-D(j,i);    
% %     
% %     end
% % end


    