clear all
clc

cd 'G:\chrome downloads\shivang';

a=imread('obama3.jpg');

G=rgb2gray(a);                                                              %original image to gray scale
                                                           

p=size(G,1);                                                                %image into black white
q=size(G,2);
imtool(G)
O=G;
for i=1:p
    for j=1:q
        if O(i,j)<160
            O(i,j)=0;
        else 
            O(i,j)=255;
        end
    end
end


final=O;                                                                    %code of improving image
for i=1:p
    for j=1:q
        if O(i,j)==0      
            n=0;
            for k=j:q
               n=n+1;
               
               if O(i,j)==256
                   break;
               end
            end
            if n>=10
                j=j+n-1;
            elseif n<10
                for k=j:j+n-1
                    final(i,k)=255;
                end    
                j=j+n-1;
            end
        elseif O(i,j)==255
            n=0;
            for k=j:q
               n=n+1;
               
               if O(i,j)==0
                   break;
               end
            end
            if n>=10
                j=j+n-1;
            elseif n<10
                for k=j:j+n-1
                    final(i,k)=0;
                end    
                j=j+n-1;
            end
            
        end
    end
end

imtool(final);





q2=234;                                                                     %reducing image pixels
p2=175;
r=3;
t=6;
final1=zeros(175,234)+.256;

for i=1:p2
    for j=1:q2
        n=0;
        for i2=i:i+r-1
            for j2=j:j+r-1
                if final(i2,j2)==0
                    n=n+1;
                end
            end
        end
        
        j=j+r-1;
        if n>=t
            w1=(i+r-1)/r;
            w2=(j)/r;
            final1(w1,w2)=0;
        end
    end
    i=i+r-1;
end

% 
% 
% imtool(final);
% 
% 
% O=final;



for i=1:p
    for j=1:q
        if final1(i,j)==0
            final1(i,j)=1;
        else 
            final1(i,j)=0;
        end
    end
end

% z=0;
% 
% i=1;
% j=1;
% while rem(i,4)==1 && i<p
%     while  rem(j,4)==1 && j<q
%         z=0;
%             for x=i:i+3
%                 for y=j:j+3
%                     z=z+final(i,j);
%                 end
%             end
%         
%         k=(i-1)/4;
%         k=k+1;
%         l=(j-1)/4;
%         l=l+1;
%         
%         if z>12
%             final(k,l)=1;
%         else
%             final(k,l)=0;
%         end
%         z=0;
%         j=j+4;
%     end
%     i=i+4;
% end
% 
% imtool(final);
% 
% m=p-rem(p,4);
% m=m/4;
% n=q-rem(q,4);
% n=n/4;

% final1=final;
% final2=final;








fid=fopen('mymatrix.txt','wt');

% for i=1:p
%     fprintf(fid,'%g\t',final(i,:));
%     fprintf(fid,'\n');
% end

for i=1:p2
    for j=1:q2
        fprintf(fid,'%g\t',final1(i,j));
        fprintf(fid,',');
    end
end

fclose(fid);

% dlmwrite('matrix.txt',O,';',p,q);


