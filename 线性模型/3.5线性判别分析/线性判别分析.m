%�����б������LDA�� �������ݼ�3.0��

x = xlsread('C:\Users\lenovo\Desktop\�������ݼ� 3.0��.xlsx', 'sheet1', 'A1:Q2');
y = xlsread('C:\Users\lenovo\Desktop\�������ݼ� 3.0��.xlsx', 'sheet1', 'A4:Q4');
%����y��ֵ�����ʺϳ��� 1�ù� 2����
y=2-y;
u= zeros(2);

%�����ֵ
for i=1:17
    u(:,y(i)) = u(:,y(i)) + x(:,i);
end
u(:,1) = u(:,1) / 8;
u(:,2) = u(:,2) / 9;

%��������Э��������
Sw=zeros(2);
for i=1:17
    Sw=Sw+(x(:,i)-u(:,y(i)))*(x(:,i)-u(:,y(i)))';
end

%ʹ������ֵ�ֽ����w 
[U,S,V] = svd (Sw);
w=V/S*U.'*(u(:,1) - u(:,2));

%����ɢ��ͼ�Լ��������ֱ��
%��㻭  �ֱ��ʾ�Ƿ�ù�
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
%�����ֱ�߽߱�� ������ֱ��
ply=-(0.1*w(1)-0.01)/w(2);
pry=-(0.9*w(1)-0.01)/w(2);
line([0.1 0.9],[ply pry]);

xlabel('�ܶ�');
ylabel('������');
title('�����б������LDA��');