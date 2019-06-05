time=cputime;
I = imread('prashant.jpg'); %test image
I1 = rgb2gray(I); %grayscale
 
figure(1);

T = imread('11.jpg'); %crop template
T2 = rgb2gray(T); %grayscale
subplot(2,1,1); imshow(T2);

T = zeros(17,21);
T1 = uint8(T);
for i=118:134
    for j=249:269
        T1(i-117,j-248) = I1(i,j); %extracted template in file
    end
end
subplot(2,1,2); imshow(T1);

%imwrite(T1,'T1g.jpg'); %write to file for storage
%T1 = imread('T1g.jpg'); %extracted templage in file
%T1=T2; %using crop template

figure(2);
subplot(2,1,1); imshow(I1);
 
f = double (I1);
w = double (T1);
 
%f = [83,78,72,70,70,69,65;75,71,64,62,60,60,61;71,63,58,52,50,51,54;66,57,57,52,44,44,46;61,54,53,57,50,46,45;67,54,47,46,50,53,48;75,61,50,46,48,48,46;75,61,51,45,49,47,45]
%w = [57,52,44,44,46;53,57,50,46,45;47,46,50,53,48;50,46,48,48,46;51,45,49,47,45]
 
%f = [91,86,82,79;83,78,72,70;75,71,64,62;71,63,58,52;71,63,58,52]
%w = [78,72,70;71,64,62;63,58,52]
 
[a,b] = size(f);
[m,n] = size(w);
 
tlx = (n-1)/2 +1;
tly = (m-1)/2+1;
brx = b-(n-1)/2;    %must be careful to avoid noninteger number
bry = a-(m-1)/2;    %must be careful to avoid noninteger number
 
temp = sum(w,2);
wbar = sum(temp)/(m*n)*ones(m,n);
wst = w-wbar;
 
wst2 = times(wst,wst);
temp = sum(wst2,2);
wstd = sum(temp);    %square denominator
 
wf = zeros(m,n);
gamma = zeros(a,b);
 
for y = tly:1:bry %row
    for x = tlx:1:brx %col
        %display(x);
        %display(y);
        %copy coincident image on f
        for i = 1:m %row
            for j = 1:n %col
                wf(i,j) = f(y-(m-1)/2-1+i,x-(n-1)/2-1+j);
            end
        end
        %display(wf);
        
        temp = sum(wf,2);
        wfbar = sum(temp)/(m*n)*ones(m,n);
        wfst = wf-wfbar;
        
        wfst2 = times(wfst,wfst);
        temp = sum(wfst2,2);
        wfstd = sum(temp);   %square denominator
        
        wwf = times(wst, wfst);
        temp = sum(wwf,2);
        
        num = sum(temp);
        den = sqrt(wstd*wfstd);
        
        gamma(y,x) = num/den;
    end
end
 
match = zeros(1,3);
for y=1:1:a
    for x=1:1:b
        if match(1,1)<gamma(y,x)
            match(1,1) = gamma(y,x);
            match(1,2) = y;
            match(1,3) = x;
        end
    end
end
display(match)
 
for i = -5:5
    for j = -5:5
        I1(match(1,2)+i, match(1,3)+j)=255;
    end
end
 
subplot(2,1,2); imshow(I1);
time=cputime-time;
fprintf('Processing time = %f s\n',time);