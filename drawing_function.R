library(ggplot2)
library(gridExtra)
library(magick)
library(cowplot)


makeInfoPanel <- function(sub) {
  
  plot1 <- drawInfoBoxes(sub, "images")
  plot2 <- drawInfoBoxes(sub, "cameras")
  
  grid.arrange(plot1, plot2, nrow = 2)
} 

drawInfoBoxes <- function(project, indicator){
  
  image_txt <- "Imágenes totales"
  camera_txt <- "Cámaras trampa"
  
  if(indicator == "images"){
    ind <- format(project$variable1, big.mark = ",")
    icon_file <- "www/logo_images.png"
    title <- image_txt
  }
  else if (indicator == "cameras") {
    ind <- format(project$variable2, big.mark = ",")
    icon_file <- "www/logo camera.png"
    title <- camera_txt
  }
  else{
    print("Select a valid indicator")
    exit()
  }
  
  
  
  # Build information boxes
  # boxes for stats
  x <- 470
  y <- 137
  w <- 940
  h <- 274
  #font <- "Proxima Nova"
  sizeTitles <- 7
  sizeNumbers <- 13
  sizePos <- 11
  sizeSubTitles <- 6
  hshift <- 0.3
  vshift <- 0.1
  
  df <- data.frame ( x = x/100, y = y/100, h = h/100, w = w/100)
  
  #read in icon files
  icon <- image_read(icon_file)
  #trophy_icon <-image_read("logo trophy.png")
  
  #Setup canvas
  p <- ggplot(df, aes(x, y, height = h, width = w)) + geom_tile(fill="transparent") + theme_void()
  
  # draw icon
  p <- p + draw_image(icon, 0, 0.3, 2.3, 2.3)
  
  #draw titles
  p <- p + 
    geom_text(color = "black", size = sizeTitles, aes(x = 6, y = 2.3, label = title))#, family = font)) #+ 
  
  
  #draw the numbers
  p <- p + 
    geom_text(color = "black", size = sizeNumbers, aes(x = 6 + hshift, y = 1.3 + vshift, label = ind))#, family = font, fontface = "bold")) #+ 
  p
  
} 