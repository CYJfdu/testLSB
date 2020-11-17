file_name='lenaembed.png';
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

num_row_matrix=0;
num_col_matrix=0;
row_matrix_index=[];
col_matrix_index=[];
for i=1:Nn
    for j=1:Mm
        sumtemp=sumtemp+extracted(i,j);
        if(j==Mm)
            if(sumtemp/Mm>0.95)
                num_row_full1=num_row_full1+1;
                row_index(num_row_full1)=i;
                if(num_row_full1>1&&row_index(num_row_full1-1)==i-1)
                    num_row_matrix=num_row_matrix+1;
                    row_matrix_index(num_row_matrix)=i;
                end
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
                if(num_col_full1>1&&col_index(num_col_full1-1)==i-1)
                    num_col_matrix=num_col_matrix+1;
                    col_matrix_index(num_col_matrix)=i;
                end
            end
        end
    end
    sumtemp=0;
end
num1_row=size(row_matrix_index,2);
num1_col=size(col_matrix_index,2);
% 取一个message矩阵,作为单一结果
single_res_messege=zeros(8);
for ii=1:8
    for jj=1:8
        single_res_messege(ii,jj)=extracted(row_matrix_index(1)+ii,col_matrix_index(1)+jj);
    end
end
res=zeros(1,8);
for i=1:8
    for j=1:8
        res(i)=res(i)+bitshift(single_res_messege(i,j),j-1);
    end
end
mes_res=char(res);
% 判别以及平均

