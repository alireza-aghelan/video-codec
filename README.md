# Video codec
In this project, we work on the compression of grayscale and color videos. In the first phase, we implement the encoder and decoder. Furthermore, we implement Huffman coding after the Run-Length step. Our program can generate a file from the coded video in the encoder unit and convert the coded file to video in the decoder unit.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/47056654/195435384-2de8edd4-5c09-4718-b2a4-6ce57a273dbf.png">

Encoder

<img width="468" alt="image" src="https://user-images.githubusercontent.com/47056654/195435551-ecfdf3b2-7add-41de-ba6e-5dfca587031e.png">

Decoder

<img width="468" alt="image" src="https://user-images.githubusercontent.com/47056654/195435631-cb02df70-4426-47df-a0bd-610fa684a7cf.png">

In the second phase, we add Motion Estimation to the Encoder and Decoder of the first phase. We save one frame as I and then the next five frames as P, and we do this until the last. I-frame is the same frame in the video, and P-frame is the difference between that frame and frame i.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/47056654/195435693-e95efe97-2b69-40e1-9ebd-e1cc2a1d8f73.png">

original video

https://user-images.githubusercontent.com/47056654/195437577-b6fa4507-609c-4908-b2cf-858785102e5c.mp4

decompressed_video

https://user-images.githubusercontent.com/47056654/195436192-fe22b590-0a63-470f-aad7-f8f5d22be10f.mp4

