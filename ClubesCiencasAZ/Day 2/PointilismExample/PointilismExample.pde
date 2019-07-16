/**
Adapted Example from Processing.org

Adapted by Nina Lutz for Clubes Ciencias 2019 AZ
*/
PImage img;

void setup() {
  size(600, 900); //Make the size of your sketch -- I made it the same as the image
  img = loadImage("degas.jpeg"); //Load your image
  noStroke(); //we don't want our circles to have outlines 
}

void draw() {  
  for(int i = 0; i<10; i++){
    float pointillize = random(2, 15); //pick a random size for our ellipses 
    int x = int(random(img.width)); //pick a random x
    int y = int(random(img.height)); //pick a random y 
    color pix = img.get(x, y); //get the color of that image
    fill(pix, 128); //draw the ellipse with that information
    ellipse(x, y, pointillize, pointillize);
  }
}
