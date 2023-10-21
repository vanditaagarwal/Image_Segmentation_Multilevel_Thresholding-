clc
clear all
close all
tic
I=imread('4.1.08.tiff');
figure
imshow(I);
red = I(:,:,1);
green = I(:,:,2);
blue = I(:,:,3);
[m,n,c]=size(I);
A=zeros(m,n);
R1=zeros(m,n);
G1=zeros(m,n);
B1=zeros(m,n);

num = m*n;


for i=1:m
    for j=1:n
        R1(i,j)= red(i,j);
    end
end

for i=1:m
    for j=1:n
        G1(i,j)= green(i,j);
    end
end

for i=1:m
    for j=1:n
        B1(i,j)= blue(i,j);
    end
end

for i = 1:m
    for j=1:n
        S(i,j) = (R1(i,j)*0.2989) + (G1(i,j)*0.5870) + (B1(i,j)*0.1140);
        A(i,j) = S(i,j);
    end
end

% R(5,7);
% S(5,10)
% S(34,61)


Max=A(1,1);
for i=1:m
    for j=1:n
        if Max<= A(i,j)
            Max=A(i,j);
        end
    end
end
Max

Min=A(1,1);
for i=1:m
    for j=1:n
        if Min>= A(i,j)
            Min=A(i,j);
        end
    end
end
Min

k= input("Enter the number of spilts :");
sp = (100/k);

for i = 1:(k-1)
    BT(i) = ((Max-Min)*((sp*i)/100))+Min;
    disp(BT(i))
end

b=255/k;

for i = 1:m
    for j = 1:n
        for a = 1:k
            if a==1
                if A(i,j) <= BT(a)
                    A(i,j) = a/k;
                end
            elseif a>1 && a<k
                if  (A(i,j) <= BT(a) && A(i,j) > BT(a-1))
                    A(i,j) = a/k;
                end
            elseif a==k
                if A(i,j) > BT(a-1)
                    A(i,j) = a/k;
                end
            end
        end
    end
end

figure
imshow(A,[],"border","tight");
colormap("gray")
toc

Ig=im2gray(I);
A1=uint8(A);
psnrval=psnr(A1,Ig)
ssimval=ssim(A1,Ig)