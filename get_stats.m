
global out_img data stats gest_data index min_pix
out_img = imfill(out_img,'holes');
out_img = bwareaopen(out_img,min_pix);
data = bwlabel(out_img);
stats = regionprops(data,'BoundingBox','Centroid');
