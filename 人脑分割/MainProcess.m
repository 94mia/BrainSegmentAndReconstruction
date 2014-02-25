%%
%��ȡͼ��
clc;close all;
index = 25;%12-20Ч���Ϻã�֮��Ļ��������ֵ���Ż�
fileName = sprintf('imgdata\\788_6_%d.bmp', index);
imgData = imread(fileName);
imgData = medfilt2(imgData,[3,3]);
%figure,imshow(imgData);
%��ֵ��
level = graythresh(imgData);
imgbw = im2bw(imgData,level);
%figure('name','imgbw'),imshow(imgbw);
%�������㣬���׶�
SE1=strel('square',5);
imgbw_erode=imerode(imgbw,SE1); %erode
%figure('name','imgbw_erode'),imshow(imgbw_erode);
%imgbw_dilated = imdilate(imgbw_erode,SE1);
%figure('name','imgbw_erode'),imshow(imgbw_dilated);
%%
%����������ȥ�����
I = imgData;
figure,imshow(I),title('ԭʼͼ��')
I=double(I)/255;
[M,N]=size(I);
%���ӵ��ѡȡ
%x1=156;y1=109;%x1=116;y1=123;
x1 = ceil(M/2);
y1 = ceil(N/2);
seed1=I(x1,y1);             %��������ʼ��Ҷ�ֵ����seed��
Y=zeros(M,N);             %��һ��ȫ����ԭͼ��ȴ��ͼ�����Y����Ϊ���ͼ�����
Y(x1,y1)=I(x1,y1);          %��Y������ȡ�����Ӧλ�õĵ�����Ϊ��ԭͼ����ͬ�ĻҶ�

sum1=seed1;               %��������������������ĵ�ĻҶ�ֵ�ĺ�
suit1=1;                   %��������������������ĵ�ĸ���
count1=1;                 %��¼ÿ���ж�һ����Χ�˵�����������µ����Ŀ
threshold1=20/255;         %�ж���ֵ
while count1>0
 s1=0;                    %��¼�ж�һ����Χ�˵�ʱ�������������µ�ĻҶ�ֵ֮��
 count1=0;
 for i1=1:M
   for j1=1:N
     if Y(i1,j1)~=0
      if (i1-1)>0 && (i1+1)<(M+1) && (j1-1)>1 && (j1+1)<(N+1)
 %�жϴ˵��Ƿ�Ϊͼ��߽��ϵĵ�
       for u=-1:1                                %�жϵ���Χ�˵��Ƿ�Ϻ���ֵ����
        for v=-1:1                               %u,vΪƫ����
          if  Y(i1+u,j1+v)==0 && abs(I(i1+u,j1+v)-seed1)<=threshold1    
%�ж��Ƿ�δ�������������Y������Ϊ������ֵ�����ĵ�
             Y(i1+u,j1+v)=I(i1+u,j1+v);            %����������������������Y����֮λ�ö�Ӧ�ĵ�����Ϊ�׳�
             count1=count1+1;                    %�˴�ѭ���µ�����1
             s1=s1+I(i1+u,j1+v);                   %�˵�ĻҶ�֮����s��
          end
        end  
       end
      end
     end
   end
 end
suit1=suit1+count1;                         %��n������ϵ�����������
sum1=sum1+s1;                           %��s������ϵ�ĻҶ�ֵ�ܺ���
seed1=sum1/suit1;                          %�����µĻҶ�ƽ��ֵ
end
figure,imshow(Y)
[B,L] = bwboundaries(Y, 'noholes');
figure,imshow(Y); hold on;
boundary = B{1};
plot(boundary(:,2), boundary(:,1), 'r','LineWidth',2);
BW = roipoly(I,boundary(:,2), boundary(:,1));
roi = immultiply(BW,imgData);
%figure, imshow(roi);
%%
%ģ��c��ֵ����
cluster_n = 4;%�����Ŀ
[center, u, obj_fcn] = fcm(double(roi(:)), cluster_n);
[m,n] = size(roi);

ppp = sort(center,'descend');
for i = 1:cluster_n
    CIndex(i) = find(center == ppp(i));
end
l = m*n;
for k = 1:l
    cluster = find(u(:,k) == max(u(:,k)),1);
    order = find(CIndex == cluster,1); 
    imgData(mod(k-1,n)+1,fix((k-1)/n+1)) =  255-(order-1)*255/(cluster_n-1);
end
figure('name','fuzzy c-means clustering'),imshow(imgData);
break