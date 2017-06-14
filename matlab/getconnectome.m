close all
clear all

cd /projects2/act-plus/subjects

load('~/ID_normal.mat')

subj_dir=ID_normal; %dir('1*')

load('~/TractographyCode/orderROIs.mat')

for s=1:length(subj_dir)
    
    %cd([subj_dir(s,1).name '/session1/EDI/PBTKresultsbedpostxdistcorr0'])
    cd([num2str(subj_dir(s)) '/session1/EDI/PBTKresultsbedpostxdistcorr0'])
    n=load('seed_voxel_num.txt');
    
    for i=1:length(orderROIs)
        tmp=load([orderROIs{i} '.txt']);
        div=(n(i)*ones(length(n),1))+n;
        A(i,:)=tmp./div;
    end
     
    m=(diag(ones(82,1))-1)*-1;
    
    A=A.*m;
    
    tmp=triu(A)+tril(A)';
    A_diag(:,:,s)=tmp+tmp';
    
    A_bin(:,:,s)=A_diag(:,:,s)>.2;
    
    deg(:,s)=degrees_und(A_bin(:,:,s));
    
    den(s)=sum(sum(A_bin(:,:,s)))./(82*81);
    
    cd ../../../..
    
end

n=1;
m=1;
A_bin_cons=sum(A_bin,3)>(round(.75*size(A_bin,3)));
for i=1:size(A_bin_cons,1)
    for j=1:size(A_bin_cons,2)
        if(A_bin_cons(i,j)==1) 
           edges{n,1}=[orderROIs{i} '2' orderROIs{j}];
           if(i>j)
               edgesoneway{m,1}=[orderROIs{i} '2' orderROIs{j}];
               m=m+1;
           end
           n=n+1;
        end
    end
end