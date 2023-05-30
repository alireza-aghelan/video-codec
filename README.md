# Video codec
In this project, we work on the compression of grayscale and color videos. In the first phase, we implement the encoder and decoder. Furthermore, we implement huffman coding after the run-Length step. Our program can generate a file from the coded video in the encoder unit and convert the coded file to video in the decoder unit.

![1](https://github.com/alireza-aghelan/video-codec/assets/47056654/7e69a7c1-459e-416a-82bd-7a05fcb96018)

Encoder

![2](https://github.com/alireza-aghelan/video-codec/assets/47056654/a38d6148-c04c-4d48-8e9f-2da68e04e95d)

Decoder

![3](https://github.com/alireza-aghelan/video-codec/assets/47056654/5f229bc3-d5ca-410c-9adc-705c0d58d576)

In the second phase, we add motion estimation to the encoder and decoder of the first phase. We save one frame as I, then the next five frames as P, and do this until the end of the video. I-frame is the same frame in the original video, and P-frame is the difference between the current frame and the I-frame.

![4](https://github.com/alireza-aghelan/video-codec/assets/47056654/527a142e-6f96-47d2-8b1e-a1f83b58109c)

Original video

Decompressed video
