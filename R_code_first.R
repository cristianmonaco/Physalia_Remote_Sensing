# Course at Physalia
# https://www.physalia-courses.org/courses-workshops/remote-sensing-in-r/

# INTRODUCTION TO ECOLOGICAL REMOTE SENSING IN R ####

# Libraries needed:
# raster
# rgdal
# ncdf4
# RStoolbox
# ggplot2
# patchwork
# rasterdiv
# viridis

# How to install them, e.g. just type the following command in the R console:

# install.packages("raster")

# then choose the CRAN, i.e. the city from the Comprehensive R Archive Network (any of them is ok!)

# To check if the package is in, simply type:

# library(raster)

# If nothing happens, that's ok! If you receive an error, write to:
# Elisa Thouverai <elisa.thouverai2@unibo.it>

# R code for ecosystem monitoring by remote sensing
# First of all, we need to install additional packages
# raster package to manage image data
# https://cran.r-project.org/web/packages/raster/index.html

# install.packages("raster")

library(raster)

# Set the working directory
# setwd("~/lab/") # Linux 
# setwd("C:/lab/")  # windows
# setwd("/Users/name/lab/") # mac

# We are going to import satellite data
# objects cannot be numbers
# p stands for path and r is row
l2011 <- brick('lab/data_book/data_book/raster_data/final/p224r63_2011.grd')

l2011

# plot(l2011)

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band
# B4 is the reflectance in the NIR band


# Importing past data
l1988 <- brick("lab/data_book/data_book/raster_data/final/p224r63_1988.grd")  
l1988

par(mfrow=c(2,1))
plotRGB(l1988, r=4, g=3, b=2, stretch="Hist")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")  

# Put the NIR in the red channel
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  


#----------------- day 2 ####

# B1 is the reflectance in the blue band
# B2 is the reflectance in the green band
# B3 is the reflectance in the red band
# B4 is the reflectance in the NIR band
# B5 swir
# B6 is the thermal IR (resolution 60 m)
# B7 swir

cl <- colorRampPalette(c("black","grey","light grey"))(100) # color ramp palette black and gray
plot(l2011, col = cl)

plot(l2011$B1_sre, col = cl) # blue band
plot(l2011[[1]], col = cl) # blue band, first element




# let's plot the green band
plot(l2011$B2_sre)

cl <- colorRampPalette(c("black","grey","light grey"))(100)
plot(l2011$B2_sre, col=cl)

# change the colorRampPalette with dark green, green, and light green, e.g. clg 
clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# do the same for the blue band using "dark blue", "blue", and "light blue"
# B1
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

# plot both images in just one multiframe graph
par(mfrow=c(1,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

# plot both images in just one multiframe graph with two rows and just one column
par(mfrow=c(2,1))
plot(l2011$B1_sre, col=clb)
plot(l2011$B2_sre, col=clg)

dev.off()


# plotRGB function

plotRGB(l2011, r = 3, g = 2, b = 1, stretch = "Lin") # natural colors, or how we perceive them
# numbers next to r, g, b are indices of bands. This is the default order.
# linear stretching allows filling gaps by stretching the data range up to 255 bits 
# the RGB does not allow working with the shadows. Switch the bands to use the NIR

plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "Lin") # NIR band placed in red (false colours)
plotRGB(l2011, r = 3, g = 4, b = 2, stretch = "Lin") # NIR band placed in green (false colours)

plotRGB(l2011, r = 4, g = 3, b = 2, stretch = "Hist") # histogram stretching for accentuating differences between mean and extreme values (false colours)



#--- day 3 ####

plot(l2011$B1_sre)

# plot the blue band using a blue colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

# multiframe
par(mfrow=c(1,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

# plot the blue and the green besides, with different colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# Exercirse: put the plots one on top of the other
# invert the number of rows and the number of columns

par(mfrow=c(2,1)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

# plot the blue and the green besides, with different colorRampPalette
clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

# Exercise: plot the first four bands with two rows and two columns
par(mfrow=c(2,2)) # the first number is the number of rows in the multiframe, while the second one is the mnumber of columns

clb <- colorRampPalette(c("dark blue","blue","light blue"))(100)
plot(l2011$B1_sre, col=clb)

clg <- colorRampPalette(c("dark green","green","light green"))(100)
plot(l2011$B2_sre, col=clg)

clr <- colorRampPalette(c("dark red","red","pink"))(100)
plot(l2011$B3_sre, col=clr)

clnir <- colorRampPalette(c("red","orange","yellow"))(100)
plot(l2011$B4_sre, col= clnir)

# dev.off()

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  # natural colours
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")  # false colours

par(mfrow=c(2,2))
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")  # natural colours
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")  # false colours
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")  # false colours

# final day on this tropical forest reserve

plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")  
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist") 
