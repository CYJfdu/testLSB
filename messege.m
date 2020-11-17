function messege = hide_lsb(blocksize,data)
% if data==0&&blocksize>0
%     messege=randi([0,1],blocksize);
% end
uintdata=uint8(data);
n=size(uintdata);
messege=zeros(8);
for i=1:n(2)
    for j=1:8
        messege(i,j)=bitget(uintdata(1,i),j)
    end
end
end