clc
clear all
close all
tic
I=imread('4.1.08.tiff');
Ig=im2gray(I);
figure
imshow(Ig);
figure
imhist(Ig);
% figure
% imhist(I);
red = I(:,:,1);
green = I(:,:,2);
blue = I(:,:,3);
[m,n,c]=size(I);
A=zeros(m,n);
R=zeros(m,n);
G=zeros(m,n);
B=zeros(m,n);

num = m*n;

 
for i=1:m
    for j=1:n
        R(i,j)= red(i,j);
    end
end

for i=1:m
    for j=1:n
        G(i,j)= green(i,j);
    end
end

for i=1:m
    for j=1:n
        B(i,j)= blue(i,j);
    end
end

for i = 1:m
    for j=1:n
        S(i,j) = (R(i,j)*(256*256)) + (G(i,j)*256) + B(i,j);
        A(i,j) = S(i,j);
    end
end


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
Max;

Min=A(1,1);
for i=1:m
    for j=1:n
        if Min>= A(i,j)
            Min=A(i,j);
        end
    end
end
Min;

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
                    A(i,j) = b;
                end
            elseif a>1 && a<k
                if  (A(i,j) <= BT(a) && A(i,j) > BT(a-1))
                    A(i,j) = a*b;
                end
            elseif a==k
                if A(i,j) > BT(a-1)
                    A(i,j) = a*b;
                end
            end
        end
    end
end

figure
imshow(A,[],"border","tight")
colormap("gray")
toc

A1=uint8(A);
%I1=double(Ig);
psnrval= psnr(A1,Ig)
ssimval= ssim(A1,Ig)