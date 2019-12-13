% open the files
%% Question 1
base_dir = '.\\Frames Folder\\Frames Folder\\Frame%d.jpg';
no_frames =15;

for n=1:no_frames
  images{n} = rgb2gray(imread(sprintf(base_dir,n)));
end


[h,w] =size(images{1});
Image_sum=double(zeros(h,w));


for n=1:no_frames
  Image_sum = Image_sum+double(images{n});
end


Img_mean =uint8(Image_sum/no_frames);
figure(1);
imshow(Img_mean);




Image_sum=double(zeros(h,w));
for n=1:no_frames
            
image_sample= double(images{n});
mean_value= double(Img_mean);
Image_sum=Image_sum+(image_sample-mean_value).^2;

 
end


stdv_image=uint8(sqrt(Image_sum/(no_frames-1)));
figure(2);
imshow(stdv_image);


%% Question 2

image_sample =double(images{10});
Img_mean=double(Img_mean);
stdv_image=double(stdv_image);
mask = double(normpdf(image_sample,Img_mean,stdv_image)<0.008);
figure(3);
imshow(uint8(image_sample.*mask));


%% Question 







