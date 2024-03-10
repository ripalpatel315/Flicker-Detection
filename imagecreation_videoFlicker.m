close all;
clear all;
clc;

% xyloObj = VideoReader('D:\Users\shubha\Downloads\Severe Film Flicker Removal2.mp4');

xyloObj = VideoReader('D:\Users\shubha\Desktop\Video_3.avi');
vidFrames = read(xyloObj);

nFrames = xyloObj.NumberOfFrames;
vidHeight = xyloObj.Height;
vidWidth = xyloObj.Width;

for i=1:nFrames
    img=vidFrames(:,:,:,i);
    figure,
    iptsetpref('ImshowBorder','tight');
     %set(gca,'LooseInset',get(gca,'TightInset'));
    imshow(img);
    %save(gca,'a.png','png');
    j=int2str(i);
    str1='flicker_res';
    str2=j;
    str3='.png';
    name=[str1 str2 str3];
    saveas(gcf,name,'png');
end

 