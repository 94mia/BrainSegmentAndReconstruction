clear all%�ͷŲ���
D=imread('788_6_5.bmp');
for i=6:1:57
    fname = sprintf('788_6_%d.bmp',i);
    x=fname;
    d= imread(x);
    D = cat(3,D,d);
end%��forѭ���������е�bmp��Ϣ����cat����������ά��������
D = squeeze(D);
[x y z D] = reducevolume(D, [4 4 1]);%��4 4 1��ȡ������������
D = smooth3(D); % �����ݽ���ƽ������
p = patch(isosurface(x,y,z,D, 5,'verbose'), ...
'FaceColor', 'yellow', 'EdgeColor', 'none'); %patch���������
p2 = patch(isocaps(x,y,z,D, 5), 'FaceColor', 'interp', 'EdgeColor','none');
view(3); 
axis tight; 
daspect([1 1 .4])%X,Y,Z����ʾ����
colormap(gray(100))
camlight; lighting gouraud%������յ�