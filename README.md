# Video codec
In this project, we work on the compression of grayscale and color videos. In the first phase, we implement the encoder and decoder. Furthermore, we implement huffman coding after the run-Length step. Our program can generate a file from the coded video in the encoder unit and convert the coded file to video in the decoder unit.

Encoder

Decoder

In the second phase, we add motion estimation to the encoder and decoder of the first phase. We save one frame as I, then the next five frames as P, and do this until the end of the video. I-frame is the same frame in the original video, and P-frame is the difference between the current frame and the I-frame.

Original video

Decompressed video
