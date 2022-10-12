# video-codec
In this project, we worked on the compression of grayscale and color videos. In the first phase, we implemented the encoder and decoder. also, we implemented Huffman coding after the Run-Length step. our program can generate a file from the coded video in the encoder unit and convert the coded file to video in the decoder unit.

<img width="468" alt="image" src="https://user-images.githubusercontent.com/47056654/195435384-2de8edd4-5c09-4718-b2a4-6ce57a273dbf.png">

Encoder

<img width="468" alt="image" src="https://user-images.githubusercontent.com/47056654/195435551-ecfdf3b2-7add-41de-ba6e-5dfca587031e.png">

Decoder

<img width="468" alt="image" src="https://user-images.githubusercontent.com/47056654/195435631-cb02df70-4426-47df-a0bd-610fa684a7cf.png">

In the second phase, we added Motion Estimation to the Encoder and Decoder of the first phase of the project.
we saved one frame as i and then the next five frames as p, and we did this until the last. Frame i is the same frame in the video, and the frames saved as p are the difference between that frame and frame i

<img width="468" alt="image" src="https://user-images.githubusercontent.com/47056654/195435693-e95efe97-2b69-40e1-9ebd-e1cc2a1d8f73.png">



