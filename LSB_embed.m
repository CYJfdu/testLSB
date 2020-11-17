clc;
clear;

file_name='lena512color.tiff';
cover_object=imread(file_name);

cover_object_R=cover_object(:,:,1);
cover_object_G=cover_object(:,:,2);
cover_object_B=cover_object(:,:,3);

Mm=size(cover_object_R,1);
Nn=size(cover_object_R,2);

zerored=uint8(zeros(512));

bit=messege(8,'FDU');

for i=1:Mm
    for j=1:Nn
        if (mod(i,10)==1||mod(i,10)==2||mod(j,10)==1||mod(j,10)==2)
            zerored(i,j)=bitset(cover_object_R(i,j),1,1);
        else
            zerored(i,j)=bitset(cover_object_R(i,j),1,bit(mod(i-2,10),mod(j-2,10)));%逻辑还需要修改
        end
%         zerored(i,j)=bitset(cover_object_R(i,j),1,1);
    end
end
watermarked(:,:,1)=zerored;
watermarked(:,:,2)=cover_object_G;
watermarked(:,:,3)=cover_object_B;
figure;
subplot(2,2,1);imshow(zerored,[]);
subplot(2,2,2);imshow(cover_object_R,[]);
subplot(2,2,3);imshow(watermarked);
subplot(2,2,4);imshow(cover_object);

imwrite(watermarked,'lenaembed.png');
w_map=imread('lenaembed.png');
w_r=w_map(:,:,1);