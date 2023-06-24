
import os
import time
import torch
from PIL import Image
import matplotlib.pyplot as plt
import numpy as np
from angular_forward import AngularForward

angf = 300  # Fill your parameters here
freq = 200000
c = 1500
h = 0.03
distance = 0.3

# Instantiate the AngularForward class
af = AngularForward(angf, freq, c, h, distance)

# Directory where images are stored
# We test on the image 0
image_dir = 'test_label_binary\0'

# Image file names
image_files = [f"0_{i}.png" for i in range(500)]

# Output directory
output_dir = r'./output_python/0'
os.makedirs(output_dir, exist_ok=True)

# Record start time
start_time = time.time()

for image_file in image_files:
    image_path = os.path.join(image_dir, image_file)
    
    # Open image file, convert it to grayscale and convert to PyTorch tensor
    img = Image.open(image_path).convert('L')
    img_tensor = torch.from_numpy(np.array(img)).double()

    # Call the angular_forward function
    output_image = af.process(img_tensor)
    
    # Convert output image to PIL Image and save it
    output_image = output_image.cpu().numpy()  # Convert tensor to numpy array
    output_image = Image.fromarray((output_image * 255).astype(np.uint8))  # Convert to PIL Image
    output_image.save(os.path.join(output_dir, image_file))  # Save the image

# Calculate elapsed time
elapsed_time = time.time() - start_time

print(f'Images saved successfully. Elapsed time: {elapsed_time} seconds.')
print(f'Elapsed time for a single image is{elapsed_time/500} seconds')

