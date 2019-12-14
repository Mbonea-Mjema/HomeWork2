
clc;
clear;


%% Question 1

base_dir = '.\\Frames Folder\\Frames Folder\\Frame%d.jpg';    % base directory of all the images

no_frames =15;                                                % Total number of image frames

for n=1:no_frames
  images{n} = rgb2gray(imread(sprintf(base_dir,n)));          % read and convert frame to grayscale  
end


[h,w] =size(images{1});                                       % Get frame dimenstions

Image_sum=double(zeros(h,w));                                  


for n=1:no_frames                                             % add all the frames    
  Image_sum = Image_sum+double(images{n});
end


Img_mean =uint8(Image_sum/no_frames);                         % find the mean pixel value
figure(1);

imshow(Img_mean);                                             % Display the Image   
title('Q1: Mean Image');                                       



Image_sum=double(zeros(h,w));                                 % Initialize sum matrix

for n=1:no_frames                                             % Standard deviation calculation
            
image_sample = double(images{n});
mean_value  = double(Img_mean);
Image_sum  = Image_sum+(image_sample-mean_value).^2;

 
end
stdv_image=uint8(sqrt(Image_sum/(no_frames-1)));


figure(2);                                                      % Display the Standard Deviation Image
imshow(stdv_image);
title('Q1: Standard Deviation Image');


%% Question 2

image_sample =double(images{10});                               % Get image sample
Img_mean=double(Img_mean);                                      % Get the calculated mean        
stdv_image=double(stdv_image);                                  % Get the calculated standard deviation Image
mask = double(normpdf(image_sample,Img_mean,stdv_image)<0.008); % Calculate P(Z<0.008) probability

figure(3);
imshow(uint8(image_sample.*mask));
title('Q2: Binary Segmented Image');


%% Question 3

first_frame=3;                                                  % variable initializations      
last_frame=5;

h = figure;
hViewPanel = uipanel(h,'Position',[0 0 1 1],'Title','Q3: Optical Flow Vectors');
hPlot = axes(hViewPanel);


opticFlow = opticalFlowLKDoG('NoiseThreshold',0.0005); % initialize the optical flow object

for  n=first_frame:last_frame
     flow = estimateFlow(opticFlow,images{n});
end

imshow(images{5})
hold on
plot(flow,'DecimationFactor',[10 10],'ScaleFactor',45,'Parent',hPlot);
hold off



%% Question 4
figure;
orien_vector = wrapTo360(radtodeg(flow.Orientation(:)));
histogram(orien_vector);
xlabel('Orientation in Degrees');
ylabel('Number of pixels');
title('Q4: Histogram of Orientations ');
