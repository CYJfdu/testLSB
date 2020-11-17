file_name='lenaembed.tiff';
watermarked=imread(file_name);
watermarked_R=watermarked(:,:,1);
Mm=size(watermarked_R,1);
Nn=size(watermarked_R,2);
% 将R层最低比特位提取出来
extracted=zeros(Mm,Nn);
for i=1:Nn
    for j=1:Mm
        extracted(i,j)=bitget(watermarked_R(i,j),1);
    end
end
% 计算出每行 每列1的个数确定全1行列位置
sumtemp=0;
num_row_full1=0;
num_col_full1=0;
row_index=[];
col_index=[];
for i=1:Nn
    for j=1:Mm
        sumtemp=sumtemp+extracted(i,j);
        if(j==Mm)
            if(sumtemp/Mm>0.95)
                num_row_full1=num_row_full1+1;
                row_index(num_row_full1)=i;
            end
        end
    end
    sumtemp=0;
end
for i=1:Mm
    for j=1:Nn
        sumtemp=sumtemp+extracted(i,j);
        if(j==Nn)
            if(sumtemp/Nn>0.95)
                num_col_full1=num_col_full1+1;
                col_index(num_col_full1)=i;
            end
        end
    end
    sumtemp=0;
end
