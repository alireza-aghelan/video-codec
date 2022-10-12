clc;
clear all;
close all;

%Decode color video

decomp = VideoWriter('decomp','MPEG-4');
open(decomp);

load('coded_data');

numframes = data{1,1};
size = data{1,2};
vmax = size(1,1);
hmax = size(1,2);
q_mtx = data{1,3};
R_dict_arr = data{1,4};
R_trssig_arr = data{1,5};
G_dict_arr = data{1,6};
G_trssig_arr = data{1,7};
BL_dict_arr = data{1,8};
BL_trssig_arr = data{1,9};

T = dctmtx(8);
invdct = @(block_struct) round(T' * block_struct.data * T);

%Decode R

for f = 1:numframes
    
   if rem(f,6) == 1
       
       % huffman decoding
       trs_sig = R_trssig_arr{1,f};
       dict = R_dict_arr{1,f};
       rlcencode = huffmandeco(trs_sig,dict);
    
       % run-length decode
       rlcdecode = irle(rlcencode);

       % zig-zag inverse
       B3 = izigzag(rlcdecode,vmax,hmax);

       % quantize inverse
       B4 = blockproc(B3,[8 8],@(block_struct) q_mtx .* block_struct.data);

       % dct inverse
       I2 = blockproc(B4,[8 8],invdct);

       % to uint8
       iframe = uint8(I2);
       
       R{1,f} = iframe;
       
       for i = f+1:f+5
           
          if i > numframes
              break;
          end
          
          % huffman decoding
          trs_sig = R_trssig_arr{1,i};
          dict = R_dict_arr{1,i};
          rlcencode = huffmandeco(trs_sig,dict);
    
          % run-length decode
          rlcdecode = irle(rlcencode);

          % zig-zag inverse
          B3 = izigzag(rlcdecode,vmax,hmax);

          % quantize inverse
          B4 = blockproc(B3,[8 8],@(block_struct) q_mtx .* block_struct.data);

          % dct inverse
          I2 = blockproc(B4,[8 8],invdct);

          % to uint8
          pframe = uint8(I2);
          
          rec = iframe + pframe;
          R{1,i} = rec;
           
       end
                    
   end
      
end


%Decode G

for f = 1:numframes
    
   if rem(f,6) == 1
       
       % huffman decoding
       trs_sig = G_trssig_arr{1,f};
       dict = G_dict_arr{1,f};
       rlcencode = huffmandeco(trs_sig,dict);
    
       % run-length decode
       rlcdecode = irle(rlcencode);

       % zig-zag inverse
       B3 = izigzag(rlcdecode,vmax,hmax);

       % quantize inverse
       B4 = blockproc(B3,[8 8],@(block_struct) q_mtx .* block_struct.data);

       % dct inverse
       I2 = blockproc(B4,[8 8],invdct);

       % to uint8
       iframe = uint8(I2);
       
       G{1,f} = iframe;
       
       for i = f+1:f+5
           
          if i > numframes
              break;
          end
          
          % huffman decoding
          trs_sig = G_trssig_arr{1,i};
          dict = G_dict_arr{1,i};
          rlcencode = huffmandeco(trs_sig,dict);
    
          % run-length decode
          rlcdecode = irle(rlcencode);

          % zig-zag inverse
          B3 = izigzag(rlcdecode,vmax,hmax);

          % quantize inverse
          B4 = blockproc(B3,[8 8],@(block_struct) q_mtx .* block_struct.data);

          % dct inverse
          I2 = blockproc(B4,[8 8],invdct);

          % to uint8
          pframe = uint8(I2);
          
          rec = iframe + pframe;
          G{1,i} = rec;
           
       end
                    
   end
      
end


%Decode B

for f = 1:numframes
    
   if rem(f,6) == 1
       
       % huffman decoding
       trs_sig = BL_trssig_arr{1,f};
       dict = BL_dict_arr{1,f};
       rlcencode = huffmandeco(trs_sig,dict);
    
       % run-length decode
       rlcdecode = irle(rlcencode);

       % zig-zag inverse
       B3 = izigzag(rlcdecode,vmax,hmax);

       % quantize inverse
       B4 = blockproc(B3,[8 8],@(block_struct) q_mtx .* block_struct.data);

       % dct inverse
       I2 = blockproc(B4,[8 8],invdct);

       % to uint8
       iframe = uint8(I2);
       
       BL{1,f} = iframe;
       
       for i = f+1:f+5
           
          if i > numframes
              break;
          end
          
          % huffman decoding
          trs_sig = BL_trssig_arr{1,i};
          dict = BL_dict_arr{1,i};
          rlcencode = huffmandeco(trs_sig,dict);
    
          % run-length decode
          rlcdecode = irle(rlcencode);

          % zig-zag inverse
          B3 = izigzag(rlcdecode,vmax,hmax);

          % quantize inverse
          B4 = blockproc(B3,[8 8],@(block_struct) q_mtx .* block_struct.data);

          % dct inverse
          I2 = blockproc(B4,[8 8],invdct);

          % to uint8
          pframe = uint8(I2);
          
          rec = iframe + pframe;
          BL{1,i} = rec;
           
       end
                    
   end
      
end



for f = 1:numframes
    
    g = zeros(vmax,hmax,3);
    g(:,:,1) = R{1,f};
    g(:,:,2) = G{1,f};
    g(:,:,3) = BL{1,f};
    writeVideo(decomp,uint8(g)); 
       
end

close(decomp);






%Decode grayscale video
% 
% decomp = VideoWriter('decomp','MPEG-4');
% open(decomp);
% 
% load('coded_data');
% 
% numframes = data{1,1};
% size = data{1,2};
% vmax = size(1,1);
% hmax = size(1,2);
% q_mtx = data{1,3};
% arr_dict_arr = data{1,4};
% arr_trssig_arr = data{1,5};
% 
% T = dctmtx(8);
% invdct = @(block_struct) round(T' * block_struct.data * T);
% 
% for f = 1:numframes
%     
%    if rem(f,6) == 1
%        
%        % huffman decoding
%        trs_sig = arr_trssig_arr{1,f};
%        dict = arr_dict_arr{1,f};
%        rlcencode = huffmandeco(trs_sig,dict);
%     
%        % run-length decode
%        rlcdecode = irle(rlcencode);
% 
%        % zig-zag inverse
%        B3 = izigzag(rlcdecode,vmax,hmax);
% 
%        % quantize inverse
%        B4 = blockproc(B3,[8 8],@(block_struct) q_mtx .* block_struct.data);
% 
%        % dct inverse
%        I2 = blockproc(B4,[8 8],invdct);
% 
%        % to uint8
%        iframe = uint8(I2);
%        
%        writeVideo(decomp,iframe); 
%        
%        for i = f+1:f+5
%            
%           if i > numframes
%               break;
%           end
%           
%           % huffman decoding
%           trs_sig = arr_trssig_arr{1,i};
%           dict = arr_dict_arr{1,i};
%           rlcencode = huffmandeco(trs_sig,dict);
%     
%           % run-length decode
%           rlcdecode = irle(rlcencode);
% 
%           % zig-zag inverse
%           B3 = izigzag(rlcdecode,vmax,hmax);
% 
%           % quantize inverse
%           B4 = blockproc(B3,[8 8],@(block_struct) q_mtx .* block_struct.data);
% 
%           % dct inverse
%           I2 = blockproc(B4,[8 8],invdct);
% 
%           % to uint8
%           pframe = uint8(I2);
%           
%           rec = iframe + pframe;
%           writeVideo(decomp,rec);
%            
%        end
%                     
%    end
%    
% end
% 
% close(decomp); 
