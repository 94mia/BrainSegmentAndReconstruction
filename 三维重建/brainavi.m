%�Բ�MRIͼ�����ά�ؽ���������ʾ
%brainavi��m 
clear%����ڴ� 
clc%�����Ļ 

Figwin=figure('Name' , '�Բ���ά�ؽ�����ת������ʾ ','NumberTitle' , 'off' ,'Menubar','none' ); 
%��������Ϊ���Բ� ά�ؽ�����ת������ʾ����ͼ�δ� 
%�� 
%%%1�������Բ�MRlͼ��%%%
%%%%%%load mri  %�����Բ�MRIͼ������ 
D=imread('788_6_9.bmp');
for i=10:1:30
    fname = sprintf('788_6_%d.bmp',i);
    x=fname;
    d= imread(x);
    D = cat(3,D,d);
end%��forѭ���������е�bmp��Ϣ����cat����������ά��������

%D=squeeze(D); %��D��4άת��Ϊ3ά 
Ds=smooth3(D);%���ø�˹��ͨ�˲�����D����ƽ 
%������Ds 
%%%2���Բ���ά�ؽ�����ת������ʾ%%% 
fv=isosurface(Ds,20); 
%�Բ���ֵ���ȡ����ֵk=20������ʽ(1)��fv��һ���ṹ 
%���飬���� 
%fv��veaicesΪͼ�εĶ�����Ϣ��fv��facesΪͼ�εı����� 
%Ϣ 
fv2=isocaps(D,5);%�Բ��ϸǵĵ�ֵ���ȡ����ֵk=5 
yuan=fv.vertices; %��yuanΪԭ�Բ�ͼ�εĶ�����Ϣ 
yuan2=fv2.vertices;%��yuan2Ϊԭ�Բ��ϸ�ͼ�εĶ��� 
%��Ϣ 
N=length(yuan);%N��N2�ֱ�Ϊyuan��yuan2�� 
%���ظ��� 
N2=length(yuan2); 
xg=sum(yuan(: ,1))/N;yg=sum(yuan(: ,2))/N; 
zg=sum(yuan(: ,3))/N;
xg2=sum(yuan2(: ,1))/N2;
yg2=sum(yuan2(: ,2))/N2; 
zg2=sum(yuan2(: ,3))/N2; 
%��yuan��yuan2�����ģ�����ʽ(2) 
T1=[1 0 0 0;0 1 0 0;0 0 1 0;-xg -yg -zg 1]; 
T3=[1 0 0 0;0 1 0 0;0 0 1 0;xg yg zg 1];
T12=[1 0 0 0;0 1 0 0;0 0 1 0;-xg2 -yg2 -zg2 1]; 
T32=[1 0 0 0;0 1 0 0;0 0 1 0;xg2 yg2 zg2 1]; 
%3D��ת�����е�T1��T3������ʽ(2)��(4) 
M=24;  %���������֡����M=24 
close('all');
mov = avifile('E:\brainRotate.avi'); %�����Բ���ת�����ļ� brainRotate.avi 
for j=1:M %��ѭ����ʽ��������ʾ�뱣���Բ���ת���� 
    xian=0; 
    xian2=0; 
    %xian��xian2�ĳ�ʼ����xian��xian2�ֱ�Ϊyuan�� 
    %yuan2ÿ����ת��Ķ������档 
    th=2*pi/M*j; %ÿ����z����ת�ĽǶ�m�� 
    a=0;  %ÿ����x����ת�ĽǶ�a�� 
    b=0; %ÿ����Y����ת�ĽǶ�b�� 
    Rx=[1 0 0 0;0 cos(a) sin(a) 0;0 -sin(a) cos(a) 0;0 0 0 1]; 
    Ry=[cos(b) 0 -sin(b) 0;0 1 0 0;sin(b) 0 cos(b) 0; 0 0 0 1]; 
    Rz=[cos(th) sin(th) 0 0;-sin(th) cos(th) 0 0;0 0 1 0;0 0 0 1]; 
    T2=Rx*Ry*Rz;%3D��ת�任T2������ʽ(3) 
    T=T1*T2*T3; %�Բ�ͼ�μ��ϸ�������������ת�ı� 
    %������T��TT������ʽ(5) 
    TT=T12*T2 *T32; 
    xian=[yuan ones(N,1)] * T; %�Բ�ͼ�μ��ϸǵ�3D 
    %��ת�任������ʽ(6) 
    xian2=[yuan2 ones(N2,1)] * T; 
    xian=xian(: ,1 :3);%�Բ�����������ƽ����z��ķ��� 
    %��ת360��(��24֡) 
    xian2=xian2(: ,1:3); %�Բ��ϸ�����������ƽ���� 
    %z��ķ�����ת360��(��24֡) 
    axis([50 250 50 250 0 60])
    daspect([1,1,0.4]);view(3) 
    patch( 'Vertices',xian, 'Faces',fv.faces, 'Facecolor',[1,0.75,0.65],'EdgeColor','none'); 
    hold on 
    patch( 'Vertices',xian2,'Faces' ,fv2.faces,'FaceColor' ,[1,0.75,0.65],'EdgeColor','none' ); 
    %�ֱ���Բ������ϸǽ�������� ά�ؽ�������Ϊ�Ѿ� 
    %��3D��ת��xian��xian2����������Ϣ���䣬��Ȼ�� 
    %fv��faces��fv2��faces�����趨ͼ�α����ɫ���Ե��ɫ�� 
    hold on;
    lightangle(th,30);lighting phong;%����phoneģ�ͽ� 
    %�еƹ����� 
    xlabel( 'x' );ylabel('Y');zlabel('Z'); %��ʾX��Y��Z�� 
    %���� 
    F=getframe(gcf); %����һ֡���� 
    mov=addframe(mov,F);
    %������֡F���붯���ļ�mov�� 
    name=strcat( 'a' ,num2str(j)); 
    print( '-dtiff' ,name);
    %�������ĸ�֡ͼƬ��������Ϊaj��tif��ͼ���ļ���(j= 
    %1-24) 
        if j~=M+1  %������һ֡�Ļ��� 
            delete(gca); 
        end 
end 
aviobjl=close(mov);  %��ʾ��ϣ��رն����ļ�

