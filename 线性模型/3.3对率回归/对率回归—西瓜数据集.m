%对率回归 西瓜数据集3.0ɑ
old_l=0;    %记录上次计算的l
n=0;    %计算迭代次数
b=[0;0;1];  %初始参数 （自定义）

x = xlsread('C:\Users\20142\Desktop\西瓜数据集 3.0α.xlsx', 'sheet1', 'A1:Q3');
y = xlsread('C:\Users\20142\Desktop\西瓜数据集 3.0α.xlsx', 'sheet1', 'A4:Q4');

while(1)
   cur_l=0;
   bx=zeros(17,1);
   %计算当前参数下的l
   for i=1:17
        bx(i) = b.'*x(:,i);
        cur_l = cur_l + ((-y(i)*bx(i)) )+log(1+exp(bx(i)));
   end

   %迭代终止条件
   if abs(cur_l-old_l)<0.001  
       break;
   end

   %更新参数(牛顿迭代法)以及保存当前l
   n=n+1;
   old_l = cur_l;
   p1=zeros(17,1);
   dl=0;
   d2l=0;

   for i=1:17
        p1(i) = 1 - 1/(1+exp(bx(i)));
        dl = dl - x(:,i)*(y(i)-p1(i));
        d2l = d2l + x(:,i) * x(:,i).'*p1(i)*(1-p1(i));
   end
   b = b - d2l\dl;
end

%画出散点图以及计算出的直线
%逐点画  分别表示是否好瓜
for i=1:17     
    if y(i)==1
       plot(x(1,i),x(2,i),'+r');
       hold on;
    else if y(i)==0
          plot(x(1,i),x(2,i),'og');    
          hold on;
        end
    end
end
%计算出直线边界点 并绘制直线
ply=-(0.1*b(1)+b(3))/b(2);
pry=-(0.9*b(1)+b(3))/b(2);
line([0.1 0.9],[ply pry]);

xlabel('密度');
ylabel('含糖率');
title('对率回归'); 