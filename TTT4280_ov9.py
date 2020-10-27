#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
TTT4280


Calculation of Imaging System Parameters:
1a)  
Pixelstørrelse = 3.45μm x 3.45μm
Antall pixler (H x V) = 2448 x 2050
Horisonal ønsket synsvinkel (FOV ) = 100mm
1b)
Pixelstørrelse = 11μm x 11μm
Antall pixler (H x V) = 1200 x 1200
Horisonal ønsket synsvinkel (FOV ) = 100mm

"""
pixel_size=3.45 #my
number_of_pixels_H=2448
number_of_pixels_v=2050
FOV=100 #1mm

f= open("TTT4280_ov9","w+")
def imag_parameters(pixel_size,number_of_pixels_H,number_of_pixels_V,FOV):
    

    sensor_resolution=1000/(2*pixel_size) #lp/mm
    horisontal_sensor_size=pixel_size*number_of_pixels_H/1000 #mm
    vertical_sensor_size=pixel_size*number_of_pixels_V 
    
    PMAG=horisontal_sensor_size/FOV
    
    #resolution=pixel_size/PMAG #my
    resolution=sensor_resolution*PMAG# lp/mm
    resolution=1000/(2*resolution) #mu
    return PMAG,resolution

#1a)
PMAG_a,resolution_a=imag_parameters(3.45, 2448,2050, FOV)
line1='For task 1a) we have:\nThe PMAG is {0:.5f}\nThe resolution for the image is {1:.5f} \u03BCm\n'.format(PMAG_a,resolution_a)
print(line1)
f.write(line1)
#1b)
PMAG_b,resolution_b=imag_parameters(11, 1200,1200, FOV)
line2='For task 1b) we have:\nThe PMAG is {0:.5f}\nThe resolution for the image is {1:.5f} \u03BCm\n'.format(PMAG_b,resolution_b)
print(line2)
f.write(line2)
line3='The biggest practical difference between a) and b) will be the resolution quality\n'
print(line3)
f.write(line3)
#1c)
#Reduction in number of pixels to 512,256 or 128 pixels
line4='\nFor task 1c) we have:'
print(line4)
number_of_pixels=[512,256,128]
count=0
for i in number_of_pixels:
   
    PMAG,resolution=imag_parameters(11, i,i, 100)
    line='The resoltion for {0} pixels is {1:.5f} \u03BCm\n'.format(number_of_pixels[count],resolution)
    print(line)
    f.write(line)
    count+=1

line5="By reducing the number of pixels the resolution will deteriorate. This is because that each pixels  has a bigger area to cover when we get fewer pixels\n"
print(line5)
f.write(line5)

line6='''For task 1d):\nThe advantages in reducing the number of active pixels for a sensor is that it´s easier to scale it down the noise.
A larger pixcel collect more \"good\" data than smaller pixels. If we have a small camera than we should use a high pixel count. 
We therefor have to balance the pixel size and the sensor size to get the best quality.'''
print(line6)
f.write(line6)

f.close()






















