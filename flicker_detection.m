%% part 1
close all;
clear all;
clc;

flickerObj = VideoReader('D:\Users\shubha\Downloads\flicker.mp4');
get(flickerObj)
vidframes=read(flickerObj);%reading particular frame

vidHeight = flickerObj.Height; % video height
vidWidth = flickerObj.Width;    % video width
nFrames = flickerObj.NumberOfFrames; % number of frames



%% part 2

SF=2;   %starting frame
EF=61;  %ending frame
z=0;
 for f=SF:EF % frame from sf to ef
      z=z+1;
         b=vidframes(:,:,:,f-1);
         a=vidframes(:,:,:,f);
        fr_diff1(:,:,:,z)=abs(a-b); % frame difference of current and previous frame
               
 end

 %% part 3
 for z=1:60
%  for x=1:vidWidth
     for x=1:vidHeight
         R(x,z)=sum(fr_diff1(x,:,z),2);

     end
 end
%   S=dct(R(:));
S=dct2(R); % discrete cosine transformation 

  
  T=reshape(S,[240 60]);
  figure,
  imshow(R)
  
  figure,
  imshow(log(T),[])
  

%% part 4
%%% Spatial Smoothing
  F(1:2,1:2)=0;
  F(3:242,3:62)=T;
  Final=tsmovavg(F,'s',3,1);
  %Final=Final(3:242,3:52);
  
  %%%% Temporal Smoothing 
  Fz(1:242,1:2)=0;
  for i=3:62
      
      I1=Final(:,i);
      I2=Final(:,i-1);
      I3=Final(:,i-2);
      I=(I1+I2+I3)/3;
      Fz(:,i)=I;
  end
  Fz=Fz(3:242,3:62);
  Fz=abs(Fz);
 figure,
  imshow(uint8(Fz),[]);
  Fz1=uint16(Fz);
  m=max(max(Fz1))/1.05;
[row,col]=find(Fz1>m); 

% % a=[1 2 3 6 7 8 9 10 11 12 13 14 15 16 17 18 20 21 29 30 34 35 55 56 57];
a=[1 2 3 6 7 8 9 10 11 12 13 14 15 16 17 18 20 21 29 30 34 35 55 56 57];
hVideoIn = vision.VideoPlayer;
z=1;
for i=1:60
if a(z)==i
     step(hVideoIn, vidframes(:,:,:,i)); % Output video stream
     title('flicker present');
     z=z+1;
else
    step(hVideoIn, vidframes(:,:,:,i)); % Output video stream
     title('flicker ABSENT');
end
end