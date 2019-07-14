public String mUrl;

/* @pjs preload="tiger.jpg"; */

PImage source;      // Source image
//for each "worm", variables: position

//aimed direction
PVector vise=new PVector();
int locPixel;
ArrayList <PathFinder> PathFindersArray;
float seekX,seekY;
//worm's length
int maxLength;
int maxLayers;
//like pixels[], to keep track of how many times a point is reached by a worm
int [] buffer;
int [] limiteDown;
//number of worms at the beginning
int nbePoints;
public float inertia;
//width and length of the drawing area
int larg;
int haut;
int largI;
int hautI;
//brightness of the destination pixel
float briMax;
//minimum brightness threshold
public int seuilBrillanceMini;
//maximum brightness threshold
public int seuilBrillanceMaxi;
//location of the tested point in pixels[]
int locTest;
int locTaX;
    int locTaY;
int brightnessTemp;
//around a point (worms position), how many pixels will we look at...
int amplitudeTest;
//constrain the acceleration vector into a devMax radius circle
float devMax;
//constrain the speed vector into a vMax radius circle
float vMax;
//not used:random factor
int hasard;
//stroke's weight (slider) or radius of ellipse used for drawing
public float myweight;
//draw or not (button onOffButton)
public boolean drawing=true;
//different drawing options
public int modeCouleur;
//fill color
int macouleur;
boolean limite;

//setup only sets up what won't change:GUI and window params
//I use initialiser() to set up what has to be initialised
//when you hit "ResetButton" and drawAnimation() to set the drawing parameters
void setup() {
  larg=largI=1000;
  haut=hautI=1000;

  size(800, 800);

  limite=false;

  source = loadImage("pic1.jpg");
  if(hautI*source.width>largI*source.height){
    larg=largI;
    haut=larg*source.height/source.width;
  }else{
    haut=hautI;
    larg=haut*source.width/source.height;
  }
source.resize(larg,haut);
source.loadPixels();
  fill(0);
  initialiser();
  delay(1000);
}

//launched after setup and any time you hit the ResetButton button
public void initialiser() { 
  drawing=true;
  nbePoints=6;
  fill( 255 );
  stroke( 255 );
  rect( 0, 0, larg,haut );
  buffer=new int[haut*larg];
  smooth();
  inertia=6;
  maxLayers=10;
  myweight=.2;
  seuilBrillanceMaxi=200;
  seuilBrillanceMini=0;
  amplitudeTest=1;
  maxLength=300;
  limite=true;
  hasard=0;
  devMax=4;
  vMax=50;
  modeCouleur=1;
  strokeJoin(ROUND);
  PathFindersArray=new ArrayList <PathFinder>();
 
  for(int i=0;i<nbePoints;i++) {
    
    PathFinder mPathFinder=new PathFinder(new PVector(random(larg),random(haut)),new PVector(random(-3,3),random(-3,3)),inertia);
    
    while((brightness(mPathFinder.getImgPixel())>seuilBrillanceMaxi)||(brightness(mPathFinder.getImgPixel())<seuilBrillanceMini))
    {
      mPathFinder.setP(int(random(larg)),int(random(haut)));
    }
    PathFindersArray.add(mPathFinder);
  }
}



void draw() {

 if (drawing){
   
      for (int i = 0; i < nbePoints; i++) {
        PathFinder mPathFinder = PathFindersArray.get(i);
        drawAnimation(mPathFinder);
        if (mPathFinder.isDeplace()) {
          mPathFinder.setDeplace(false);
        }
      }
 }
}



  void drawAnimation(PathFinder myPathFinder) {
    seekX = myPathFinder.getP().x;
    seekY = myPathFinder.getP().y;
    vise.x = 0;
    vise.y = 0;
    int pixelsPosition = floor(seekX) + floor(seekY) * larg;
    int locTestX = floor(seekX);
    int locTestY = floor(seekY);
    
    for (int i = -amplitudeTest; i < amplitudeTest + 1; i++) {
      for (int j = -amplitudeTest; j < amplitudeTest + 1; j++) {
        locTaX = locTestX + i;
        locTaY = locTestY + j;
        if ((locTaX > 0) && (locTaY > 0) && (locTaX < larg - 1) && (locTaY < haut - 1)) {
          brightnessTemp = int(brightness(source.pixels[locTaX + larg * locTaY]));
          vise.sub(new PVector(i * brightnessTemp, j * brightnessTemp));
        }
      }
    }

    vise.normalize();
    vise.mult(100f/myPathFinder.inertia);
    myPathFinder.getV().add(new PVector(vise.x,vise.y));
    PVector deviation = myPathFinder.getV().get();
    deviation.normalize();
    deviation.mult(devMax);
    myPathFinder.getV().normalize();
    myPathFinder.getV().mult(vMax);
    myPathFinder.getP().add(deviation);
    // ******************different cases that lead to move the PathFinder to
    // another random place**************
    // outside window
    // on compte les segments de chaque ver
    // worm's length is increased
    myPathFinder.setLongueur(myPathFinder.getLongueur() + 1);
    float positionBrightness=brightness(myPathFinder.getImgPixel());
    //println(positionBrightness+" "+myPathFinder.getP().x+" "+myPathFinder.getP().y);
    //drawing=false;
    // si c'est trop long on demenage
    // PathFinder's moved if worm's too long
    if (myPathFinder.getLongueur() > maxLength) {
      deplacePoint(myPathFinder);
    }
    if ((myPathFinder.getP().x < 1) || (myPathFinder.getP().y < 1) || (myPathFinder.getP().x > larg - 1) || (myPathFinder.getP().y > haut - 1))// ||
    {
      myPathFinder.setDeplace(true);
      deplacePoint(myPathFinder);
      return;
    }
    // buffer est une copie vide de l'image. on l'augmente pour chaque point
    // parcouru
    // buffer is an empty copy of the source image. It's increased every
    // time a point is reached.
    buffer[pixelsPosition]++;
    // si on est passe plus de n fois on demenage le point
    // If a point is reached n times, PathFinder is moved
    if (buffer[pixelsPosition] > maxLayers) {
      deplacePoint(myPathFinder);
    }

    // inside window, limite on and inside value range
    if ((limite) && (positionBrightness <= seuilBrillanceMaxi) && (positionBrightness >= seuilBrillanceMini)) {
      if (myPathFinder.getLimiteDown() != 0) {
        myPathFinder.setLimiteDown(myPathFinder.getLimiteDown() - 2);
      }
    }
    // limite on and outside value range
    if ((limite) && ((positionBrightness > seuilBrillanceMaxi) || (positionBrightness < seuilBrillanceMini))) {
      if (myPathFinder.getLimiteDown() == 0) {
        myPathFinder.setLimiteDown(2);
      }
      myPathFinder.setLimiteDown(myPathFinder.getLimiteDown() + 4);// print(myPathFinder.limiteDown+" ");
      if (myPathFinder.getLimiteDown() >= 152 / myweight) {
        myPathFinder.setLimiteDown(0);
        deplacePoint(myPathFinder);
      }
    }
    // null deviation
    if ((deviation.x == 0) && (deviation.y == 0)) {
      myPathFinder.setLimiteDown(0);
      deplacePoint(myPathFinder);
    } 
      else briMax = brightness(source.pixels[pixelsPosition]);
    
    // go draw the PathFinder's shape
    myPathFinder.setDia((float) (myweight * (1 - cos((myPathFinder.getLongueur()) * PI * 2 / (float) maxLength))));
    myPathFinder.setAlpha((max(0, (round(127 * myPathFinder.getDia() / myweight) - (int) briMax / 2))));
    stroke(0, 0, 0,myPathFinder.getAlpha());
    strokeWeight(myPathFinder.getDia());
    line(seekX,seekY,myPathFinder.getP().x,myPathFinder.getP().y);
    //println("Size "+myPathFinder.getDia());
    // on cree un nouveau vers de temps en temps (on pourrait tester selon
    // la brilance de la zone...)
    // from times to times a new worm is created
    if (random(1) > 1 - (255 - briMax) / (500 * PathFindersArray.size())) {
      PathFindersArray.add(new PathFinder(new PVector(seekX, seekY), new PVector(myPathFinder.getV().x * random(-3,3), myPathFinder.getV().x
          * random(-3,3)), inertia));
      nbePoints++;
      // Log.d("DrawingView","Size "+PathFindersArray.size());
    }
  }

  // *****************move the PathFinder function***************************
  void deplacePoint(PathFinder PathFinder) {
    PathFinder.setLongueur(0);
    PathFinder.setP(random(1, larg - 1), random(1, haut - 1));
    while ((brightness(PathFinder.getImgPixel()) > seuilBrillanceMaxi)
        || (brightness(PathFinder.getImgPixel()) < seuilBrillanceMini)) {
      PathFinder.setP(random(1, larg - 1), random(1, haut - 1));
    }
    seekX = PathFinder.getP().x;
    seekY = PathFinder.getP().y;
  }
public void setDevMax(float devMax) {
    this.devMax = devMax;
  }
public class PathFinder {

  // position
  private PVector p = new PVector();
  // speed
  private PVector v = new PVector();
  private int imgPixel;
  private float inertia;
  // worm's length
  private float longueur;
  // worm's limite
  private int limiteDown;
  private int couleur;
  private int red = int(random(0, 100));
  // stroke weight
  private float dia;
  private boolean deplace;
  private int alpha;
  private float greenfade = random(1);
  private float bluefade = random(1);
  private float redfade = random(1);
  private float vegRatio = random(.75, 1);

  // Constructor
  public PathFinder(PVector P, PVector V, float Inertia) {
    p = P;
    v = V;
    limiteDown = 0;
    longueur = 0;
    setInertia(random(-2, 2) + Inertia);
    setDeplace(false);
  }

  public int updateCouleur() {

    float green = green(couleur);
    float blue = blue(couleur);

      if ((green > 100) || (green < 1))
        greenfade = -greenfade;
      green += greenfade;
      if ((blue > 100) || (blue < 1))
        bluefade = -bluefade;
      blue += bluefade;
      couleur =color(alpha, red, green, blue);

    return couleur;
  }

  public float getLongueur() {
    return longueur;
  }

  public void setLongueur(float longueur) {
    this.longueur = longueur;
  }

  public PVector getP() {
    return p;
  }

  public void setP(PVector p) {
    this.p = p;
  }

  public void setP(float a, float b) {
    this.p.x = a;
    this.p.y = b;
  }

  public PVector getV() {
    return v;
  }

  public void setV(PVector v) {
    this.v = v;
  }

  public void setV(float a, float b) {
    this.v.x = a;
    this.v.y = b;
  }

  public int getLimiteDown() {
    return limiteDown;
  }

  public void setLimiteDown(int limiteDown) {
    this.limiteDown = limiteDown;
  }

  public boolean isDeplace() {
    return deplace;
  }

  public void setDeplace(boolean deplace) {
    this.deplace = deplace;
  }

  public float getDia() {
    return dia;
  }

  public void setDia(float dia) {
    this.dia = dia;
  }

  public int getAlpha() {
    return alpha;
  }

  public void setAlpha(int alpha) {
    this.alpha = alpha;
  }

  public float getInertia() {
    return inertia;
  }
public void setInertia(float inertia) {
    this.inertia = inertia;
  }
  

  public int getCouleur() {
    return couleur;
  }

  public void setCouleur(int couleur) {
    this.couleur = couleur;
  }

  public float getVegRatio() {
    return vegRatio;
  }

  public void setVegRatio(float vegRatio) {
    this.vegRatio = vegRatio;
  }
  public int getImgPixel(){
    if(getP().x>0 && getP().x<larg &&getP().y>0 && getP().y<haut)
    return source.pixels[floor(getP().x)+floor(getP().y)*larg];
    else{
      //println("Out of range");
      return 0;
    }
}
}
