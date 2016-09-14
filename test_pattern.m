%clear all;
global dx dy txt
%f = fopen('data.txt','r');

%x = fgetl(f);
%x = str2num(x);
x = round(dx);
%y = fgetl(f);
%y = str2num(y);
y = round(dy);

img = zeros(640,640);
z = [];
for k = 1:length(x)-1;
    cg = linspace(x(k),x(k+1),20);
    cg = round(cg);
    z = cat(2,cg,z);
end
m = [];
for k = 1:length(y) - 1;;
    cg = linspace(y(k),y(k+1),20);
    cg = round(cg);
    m = cat(2,cg,m);
end

for k = 1:length(z);
    img(z(k),m(k)) = 1;
end
%figure, imshow(img);

se = strel('disk',2,8);
img2 = imdilate(img,se);
img2 = imrotate(img2,90);
img2 = flipdim(img2,1);
txt = ocr(img2);
Iocr         = insertObjectAnnotation(img2, 'rectangle', ...
                           txt.WordBoundingBoxes, ...
                           txt.WordConfidences);
                   


%fclose(f);
