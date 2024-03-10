clc;
clear all;
close all;

flickerObj = VideoReader('D:\Users\shubha\Downloads\flicker.mp4');
get(flickerObj)
vidframes=read(flickerObj);%reading particular frame
hVideoIn = vision.VideoPlayer;
vidHeight = flickerObj.Height;
vidWidth = flickerObj.Width;
nFrames = flickerObj.NumberOfFrames;
a=[1 2 3 6 7 8 9 10 11 12 13 14 15 16 17 18 20 21 29 30 34 35 55 56 57];
% z=1;
for i=1:60
if a==i
     step(hVideoIn, uint8(vidframes(:,:,:,i))); % Output video stream
     title('flicker present');
%      z=z+1;
else
    step(hVideoIn, uint8(vidframes(:,:,:,i))); % Output video stream
     title('flicker ABSENT');
end
end