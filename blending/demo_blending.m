%Read the source and the target images
source_image = imread('img4.jpg');
target_image = imread('img3.jpg');

%Return a logical mask for the region of the source image to  be cut and
%pasted in the target image
mask = maskImage(source_image);

%Store the offsets for pasting the source image in the target image
offsetX = -60;
offsetY = 60;
    
%Paste the source image at the above offsets in the target image and
%perform Poisson Image Editing
resultImg = seamlessCloningPoisson(source_image,target_image,mask,offsetX,offsetY);

%Display the final target image 
figure;
imagesc(resultImg);
axis image;
