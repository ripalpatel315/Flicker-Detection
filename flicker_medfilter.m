close all;
clear all;
clc;

flickerObj = VideoReader('D:\Users\shubha\Downloads\flicker.mp4');
get(flickerObj)
vidframes=read(flickerObj);%reading particular frame

vidHeight = flickerObj.Height;
vidWidth = flickerObj.Width;
nFrames = flickerObj.NumberOfFrames;

SF=2;
EF=61;
z=0;

 for f=SF:EF % frame from sf to ef
      z=z+1;
      
         b=vidframes(:,:,:,f-1);
         b=rgb2gray(b);
         b = medfilt2(b, [5 5]);
               
            a=vidframes(:,:,:,f);
             a=rgb2gray(a);
        a = medfilt2(a, [5 5]);
        fr_diff1(:,:,:,z)=abs(a-b);      
 end
 
 for z=1:60
     for x=1:vidHeight
         R(x,z)=sum(fr_diff1(x,:,z),2);
     end
 end

S=dct2(R);

  T=reshape(S,[240 60]);
  
%%% Spatial Smoothing
  F(1:2,1:2)=0;
  F(3:242,3:62)=T;
  Final=tsmovavg(F,'s',3,1);
  
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

  Fz1=uint16(Fz);
  T=[1 1 1 0 0 1 1 1 1 0 0 0 0 1 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 1 1 0 0 1 1 1 1 0 0 0];
% %   m=max(max(Fz1))/1.05;
% % [row,col]=find(Fz1>m); 
% % 
% % figure,
% % x1=unique(col); % if a value is repeated multiple times it give a single output for those multipe outputs
% % x1=[x1; 0]; %appending 0 to the above matrix
% % z=1;
% % for i=1:60
% %    I=vidframes(:,:,:,i);
% % 
% %      if i==x1(z)
% %      z=z+1;
% %      subplot (1,2,1);
% %      imshow(I);
% %      title(['log filter FLicker is present in frame no:',int2str(i)]);
% % %      subplot (1,2,2);
% % %      imshow(f1);
% % %      title(['log filter FLicker is present in frame no:',int2str(i)]);
% %      else 
% %      imshow(I);
% %       title(['log filter Flicker absent in frame no:',int2str(i)]);
% % %      subplot (1,2,2);
% % %      imshow(f1);
% % %       title(['log filter Flicker absent in frame no:',int2str(i)]);
% %      end
% % hold off;
% %      pause(0.1);
% % end
