clc;
clear all;
close all;

%Encode color video

v = VideoReader('a.avi');
numframes = v.NumFrames();

for f = 1:numframes
    
   frame = read(v,f);
   R{1,f} = frame(:,:,1); 
   G{1,f} = frame(:,:,2); 
   BL{1,f} = frame(:,:,3); 
    
end

vmax = size(R{1,f},1);
hmax = size(R{1,f},2);
if rem(vmax,8) ~= 0
    vmax = vmax - rem(vmax,8);
end
if rem(hmax,8) ~= 0
    hmax = hmax - rem(hmax,8);
end

T = dctmtx(8); 
dct = @(block_struct) T * block_struct.data * T';

% q_mtx =  [1   1   1   1   0   0   0   0
%           1   1   1   0   0   0   0   0
%           1   1   0   0   0   0   0   0
%           1   0   0   0   0   0   0   0
%           0   0   0   0   0   0   0   0
%           0   0   0   0   0   0   0   0
%           0   0   0   0   0   0   0   0
%           0   0   0   0   0   0   0   0];

q_mtx = [16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; 14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62;
18 22 37 56 68 109 103 77;24 35 55 64 81 104 113 92; 49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];

data{1,1} = numframes;
data{1,2} = [vmax hmax];
data{1,3} = q_mtx;

%Encode R

for f = 1:numframes
   
   if rem(f,6) == 1
       
       iframe = R{1,f};
       
       for i = f+1:f+5
           
          if i > numframes
              break;
          end
           
          frame = R{1,i};
          pframe = frame - iframe;
          R{1,i} = pframe;
           
       end
                    
   end
  
end

for f = 1:numframes
    
    frame = R{1,f};
    I = double(frame);
    I = imresize(I,[vmax hmax]);
    
    %dct
    B = blockproc(I,[8 8],dct);
    
    %quantization
    c = @(block_struct)(block_struct.data) ./ q_mtx;
    B2 = blockproc(B,[8 8],c);
    B2 = round(B2);
    
    % zig-zag scan
    zig = zigzag(B2);
    
    % run-length encode
    rlcencode = rle(zig);
   
    % huffman encoding on rlencode
    y = unique(rlcencode);
    va = hist(rlcencode,y);
    prob = va./sum(va);
    dict = huffmandict(y,prob);
    trs_sig = huffmanenco(rlcencode,dict);
    
    R_trssig_arr{1,f} = trs_sig;
    R_dict_arr{1,f} = dict;
    
end

data{1,4} = R_dict_arr;
data{1,5} = R_trssig_arr;

%Encode G

for f = 1:numframes
   
   if rem(f,6) == 1
       
       iframe = G{1,f};
       
       for i = f+1:f+5
           
          if i > numframes
              break;
          end
           
          frame = G{1,i};
          pframe = frame - iframe;
          G{1,i} = pframe;
           
       end
                    
   end
  
end

for f = 1:numframes
    
    frame = G{1,f};
    I = double(frame);
    I = imresize(I,[vmax hmax]);
    
    %dct
    B = blockproc(I,[8 8],dct);
    
    %quantization
    c = @(block_struct)(block_struct.data) ./ q_mtx;
    B2 = blockproc(B,[8 8],c);
    B2 = round(B2);
    
    % zig-zag scan
    zig = zigzag(B2);
    
    % run-length encode
    rlcencode = rle(zig);
   
    % huffman encoding on rlencode
    y = unique(rlcencode);
    va = hist(rlcencode,y);
    prob = va./sum(va);
    dict = huffmandict(y,prob);
    trs_sig = huffmanenco(rlcencode,dict);
    
    G_trssig_arr{1,f} = trs_sig;
    G_dict_arr{1,f} = dict;
    
end

data{1,6} = G_dict_arr;
data{1,7} = G_trssig_arr;

%Encode B

for f = 1:numframes
   
   if rem(f,6) == 1
       
       iframe = BL{1,f};
       
       for i = f+1:f+5
           
          if i > numframes
              break;
          end
           
          frame = BL{1,i};
          pframe = frame - iframe;
          BL{1,i} = pframe;
           
       end
                    
   end
  
end

for f = 1:numframes
    
    frame = BL{1,f};
    I = double(frame);
    I = imresize(I,[vmax hmax]);
    
    %dct
    B = blockproc(I,[8 8],dct);
    
    %quantization
    c = @(block_struct)(block_struct.data) ./ q_mtx;
    B2 = blockproc(B,[8 8],c);
    B2 = round(B2);
    
    % zig-zag scan
    zig = zigzag(B2);
    
    % run-length encode
    rlcencode = rle(zig);
   
    % huffman encoding on rlencode
    y = unique(rlcencode);
    va = hist(rlcencode,y);
    prob = va./sum(va);
    dict = huffmandict(y,prob);
    trs_sig = huffmanenco(rlcencode,dict);
    
    BL_trssig_arr{1,f} = trs_sig;
    BL_dict_arr{1,f} = dict;
    
end

data{1,8} = BL_dict_arr;
data{1,9} = BL_trssig_arr;

save('coded_data','data');






%Encode grayscale video
%
% vgray = VideoReader('grayVid.mp4');
% numframes = vgray.NumFrames();
% 
% for f = 1:numframes
%     
%    arr{1,f} = rgb2gray(read(vgray,f)); 
%     
% end
% 
% %check 8*8 block
% frame = read(vgray,1);
% grayframe = rgb2gray(frame);
% vmax = size(grayframe,1);
% hmax = size(grayframe,2);
% if rem(vmax,8) ~= 0
%     vmax = vmax - rem(vmax,8);
% end
% if rem(hmax,8) ~= 0
%     hmax = hmax - rem(hmax,8);
% end
% 
% T = dctmtx(8); 
% dct = @(block_struct) T * block_struct.data * T';
% 
% % q_mtx =  [1   1   1   1   0   0   0   0
% %           1   1   1   0   0   0   0   0
% %           1   1   0   0   0   0   0   0
% %           1   0   0   0   0   0   0   0
% %           0   0   0   0   0   0   0   0
% %           0   0   0   0   0   0   0   0
% %           0   0   0   0   0   0   0   0
% %           0   0   0   0   0   0   0   0];
% 
% q_mtx = [16 11 10 16 24 40 51 61; 12 12 14 19 26 58 60 55; 14 13 16 24 40 57 69 56; 14 17 22 29 51 87 80 62;
% 18 22 37 56 68 109 103 77;24 35 55 64 81 104 113 92; 49 64 78 87 103 121 120 101; 72 92 95 98 112 100 103 99];
% 
% for f = 1:numframes
%    
%    if rem(f,6) == 1
%        
%        iframe = arr{1,f};
%        
%        for i = f+1:f+5
%            
%           if i > numframes
%               break;
%           end
%            
%           frame = arr{1,i};
%           pframe = frame - iframe;
%           arr{1,i} = pframe;
%            
%        end
%                     
%    end
%   
% end
% 
% 
% for f = 1:numframes
%     
%     frame = arr{1,f};
%     I = double(frame);
%     I = imresize(I,[vmax hmax]);
%     
%     %dct
%     B = blockproc(I,[8 8],dct);
%     
%     %quantization
%     c = @(block_struct)(block_struct.data) ./ q_mtx;
%     B2 = blockproc(B,[8 8],c);
%     B2 = round(B2);
%     
%     % zig-zag scan
%     zig = zigzag(B2);
%     
%     % run-length encode
%     rlcencode = rle(zig);
%    
%     % huffman encoding on rlencode
%     y = unique(rlcencode);
%     va = hist(rlcencode,y);
%     prob = va./sum(va);
%     dict = huffmandict(y,prob);
%     trs_sig = huffmanenco(rlcencode,dict);
%     
%     arr_trssig_arr{1,f} = trs_sig;
%     arr_dict_arr{1,f} = dict;
%     
% end
% 
% data{1,1} = numframes;
% data{1,2} = [vmax hmax];
% data{1,3} = q_mtx;
% data{1,4} = arr_dict_arr;
% data{1,5} = arr_trssig_arr;
% 
% save('coded_data','data');
