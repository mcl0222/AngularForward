% Set parameters
angf = 300;
freq = 200000;
c = 1500;
h = 0.03;
distance = 0.3;

% Set directory where images are stored
image_dir = 'test_label_binary\0';

% Set directory for output images
output_dir = '.\output_matlab\0';
if ~exist(output_dir, 'dir')
   mkdir(output_dir)
end
tic
% Iterate over images
for i = 0:499 % in total 500 images
    % Read image
    image_file = sprintf('%s\\0_%d.png', image_dir, i);
    hologram = imread(image_file);

    % Apply angular_forward function
    output_image = angular_forward(angf, freq, c, h, distance, hologram);
    
    % Save output image
    output_file = sprintf('%s\\%d.png', output_dir, i);
    imwrite(output_image, output_file);
    disp(i+" out of "+ 499 + " time elpased: "+ toc+" s");
end
disp("total time: "+toc+" s")
disp(toc/500+" s/image") % calculate processing time
fprintf('Images saved successfully.\n');
