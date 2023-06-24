# AngularForward

## Overview
This code provides a simulation of the projection of images via different materials. 
Users can choose different images, receiver sizes, image-receiver distances, and materials(speed of sound).
It contains a Python version and a MATLAB version.

## Quick Start

### Dependencies (Python Only)
- Linux or Windows
- Python 3.7+
- PyTorch 1.11+
- Numpy
- scipy
- PIL (test code only)

### Example
- The dataset used: test_label_binary.zip a 32*32 MNIST binary pixel dataset. In the test code, it focused on image 0, you can add more for loop as you like
- unzip the zip file to the same directory as angular_forward_test
- Python:
  - go to the angular_forward_test.py file
  - Choose your angular frequency(angf), frequency(freq), speed of sound(c), receiver size(h), and receiver image distance(distance)
  - forward to the target folder via terminal
  - type in
    python angular_forward_test.py
  - check projected images in the folder ./output_python
    
- MATLAB:
  - Open the angular_forward_test.m file
  - press run
  - check projected images in the folder ./output_matlab


## What's the difference between the two versions?
- Python version is much faster than the Matlab version due to vectorization
- We optimized the forward propagation process by replacing the for loop with a torch tensor
    MATLAB:
    -%forward propagation
        H=exp(1i*(distance)*sqrt(k0^2-Kx1.^2-Ky1.^2));
        for j=1:2*nx1-1
            for k=1:2*ny1-1
                if Kx1(j,k)^2+Ky1(j,k)^2>k0^2
                    H(j,k)=0;
                end
            end
        end
![750f9e486a2be025013466a76126ae8](https://github.com/mcl0222/AngularForward/assets/85031225/1c599908-e3d4-4f98-87f7-1fd54a0ceacd)


    Python:
     H = torch.tensor(np.exp(1j * (self.distance) * np.sqrt(np.maximum(k0 ** 2 - Kx1 ** 2 - Ky1 ** 2, 0))), dtype=torch.cdouble)
  ![image](https://github.com/mcl0222/AngularForward/assets/85031225/7b8a749d-61ec-4ed4-a97e-43da8c2596e1)


- In comparison, while MATLAB needs to use 4.5114s to process a 32x32 image(on a 3200 MHz RAM), python only needs 0.13s to process it,
  which is more than 34 times faster. Python version is more friendly when users need to process massive datasets


