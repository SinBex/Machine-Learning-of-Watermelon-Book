%���ʻع� �������ݼ�3.0��
old_l=0;    %��¼�ϴμ����l
n=0;    %�����������
b=[0;0;1];  %��ʼ���� ���Զ��壩

x = xlsread('C:\Users\20142\Desktop\�������ݼ� 3.0��.xlsx', 'sheet1', 'A1:Q3');
y = xlsread('C:\Users\20142\Desktop\�������ݼ� 3.0��.xlsx', 'sheet1', 'A4:Q4');

while(1)
   cur_l=0;
   bx=zeros(17,1);
   %���㵱ǰ�����µ�l
   for i=1:17
        bx(i) = b.'*x(:,i);
        cur_l = cur_l + ((-y(i)*bx(i)) )+log(1+exp(bx(i)));
   end

   %������ֹ����
   if abs(cur_l-old_l)<0.001  
       break;
   end

   %���²���(ţ�ٵ�����)�Լ����浱ǰl
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

%����ɢ��ͼ�Լ��������ֱ��
%��㻭  �ֱ��ʾ�Ƿ�ù�
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
%�����ֱ�߽߱�� ������ֱ��
ply=-(0.1*b(1)+b(3))/b(2);
pry=-(0.9*b(1)+b(3))/b(2);
line([0.1 0.9],[ply pry]);

xlabel('�ܶ�');
ylabel('������');
title('���ʻع�'); 