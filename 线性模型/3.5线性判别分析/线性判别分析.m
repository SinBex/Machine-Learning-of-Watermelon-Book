%线性判别分析（LDA） 西瓜数据集3.0ɑ

x = xlsread('C:\Users\lenovo\Desktop\西瓜数据集 3.0α.xlsx', 'sheet1', 'A1:Q2');
y = xlsread('C:\Users\lenovo\Desktop\西瓜数据集 3.0α.xlsx', 'sheet1', 'A4:Q4');
%更改y的值用来适合程序 1好瓜 2坏瓜
y=2-y;
u= zeros(2);

%计算均值
for i=1:17
    u(:,y(i)) = u(:,y(i)) + x(:,i);
end
u(:,1) = u(:,1) / 8;
u(:,2) = u(:,2) / 9;

%计算两类协方差矩阵和
Sw=zeros(2);
for i=1:17
    Sw=Sw+(x(:,i)-u(:,y(i)))*(x(:,i)-u(:,y(i)))';
end

%使用奇异值分解计算w 
[U,S,V] = svd (Sw);
w=V/S*U.'*(u(:,1) - u(:,2));

%画出散点图以及计算出的直线
%逐点画  分别表示是否好瓜
for i=1:17     
    if y(i)==1
       plot(x(1,i),x(2,i),'+r');
       hold on;
    else if y(i)==2
          plot(x(1,i),x(2,i),'og');    
          hold on;
        end
    end
end
%计算出直线边界点 并绘制直线
ply=-(0.1*w(1)-0.01)/w(2);
pry=-(0.9*w(1)-0.01)/w(2);
line([0.1 0.9],[ply pry]);

xlabel('密度');
ylabel('含糖率');
title('线性判别分析（LDA）');