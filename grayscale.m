clc;
clear all;
close all;

v = VideoReader('a.avi');
numframes = v.NumFrames();

grayVid = VideoWriter('grayVid','MPEG-4');
open(grayVid);

for f = 1:numframes
  
     grayframe = rgb2gray(read(v,f));
     writeVideo(grayVid,grayframe); 
     arr_uint{1,f} = uint8(grayframe);
      
end

close(grayVid); 

save('test_data_uint8','arr_uint');

for f = 1:numframes
  
     grayframe = rgb2gray(read(v,f));
     arr_double{1,f} = double(grayframe);
      
end

close(grayVid); 

save('test_data_double','arr_double');
