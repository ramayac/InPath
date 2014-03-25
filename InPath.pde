/*
* Juego minimalista geometrico, creado por @ramayac
*/

Estado estado;
//enum Estado { ESPERANDO, JUGANDO, MUERTO }; //pasar a archivo Estado.java

float xoff = 0.0, yoff = 0.0; //para el perlin noise
int FONTSIZE = 24, PIEZAS = 10, CONTADOR = 0, ANIMSTART, ANIMLENGTH = 10;
float ANCHO = 0, SCORE = 0, SCORE_BST = 0;

//Paleta de colores
color COL_PIEZA = #FF3333, COL_NAVE  = #FFFFFF,
  COL_FONDO = #FF7F7F, COL_AVISO = #7F1919,
  COL_TEXTO = #FFFFFF;

Pieza[] pieza = null;
Nave nave = null;

void setup() {
  size(320, 470);
  
  frameRate(40);
  smooth();
  noCursor();
  
  noiseDetail(3, 0.5);
  textAlign(CENTER, CENTER);
  
  textFont(createFont("Consolas", 16, true), FONTSIZE); ///Consolas, 16 point, anti-aliasing on

  ANCHO = width/4;
  nave = new Nave();
  pieza = new Pieza[PIEZAS];

  estado = Estado.ESPERANDO;

  for (int i = 0; i < pieza.length; i++) {
    pieza[i] = new Pieza();
    pieza[i].y = i * pieza[i].h;
  }
}

float nnxy() { //Next noise step
  return map(noise(xoff, yoff), 0.0, 1.0, 0, width);
}

void draw() {
  background(COL_FONDO);

  //Dibujar las piezas
  for (int i = 0; i < pieza.length; i++) {
    pieza[i].draw();
  }

  nave.draw();

  //Actualizar las piezas
  if (estado == Estado.ESPERANDO) {
    textt("Keep in path", width/2, height/10);
    textt("Touch to start",  width/2, height/10+FONTSIZE);
    //nave.move(width/2);
  }
  else if (estado == Estado.JUGANDO) {
    
    //Así sería para touch
    //if (mousePressed == true){
    //nave.x = mouseX;
    //};

    xoff = 0;
    pieza[0].w = nnxy();
    for (int i = 0; i < pieza.length-1; i++) {
      float diff = pieza[i].w - pieza[i+1].w;
      pieza[i+1].w += diff/3;
      xoff+=0.05;
    }

    boolean flag_colision = nave.colision(pieza[pieza.length-1]);
    if (flag_colision) {
      estado = Estado.MUERTO;
    }

    float yyy = abs(sin(frameCount))/20;
    yoff+= 0.01 + yyy;
    
    ANCHO -= 0.01;
    SCORE = CONTADOR/frameRate;
    CONTADOR++;
    
    textt(round(SCORE) + " seg.", width/2, height/10);
  } 
  else if (estado == Estado.MUERTO) {
    if(SCORE_BST == 0.0) SCORE_BST = SCORE;
    if(SCORE >= SCORE_BST) {
      SCORE_BST = SCORE;
      textt("BEST SCORE: " + round(SCORE_BST) + "sec !", width/2, height/10);
    } else {
      textt("Best score: " + round(SCORE_BST) + "sec" , width/2, height/10);
      textt("Your score: " + round(SCORE) + "sec", width/2, height/10 + FONTSIZE);
    }
  }
}

void textt(String s, float x, float y){
  //fill(COL_AVISO);
  //noStroke();
  //rectMode(CENTER);
  //rect(x, y, width, height/10);
  fill(COL_TEXTO);
  text(s, x, y);
}

void resetGame(){
  ANCHO = width/4;
  SCORE = 0.0;
  CONTADOR = 0;
  
  nave.x = width/2 - nave.size/2;
  nave.prevx = nave.x;
  nave.move(nave.x);
   
  for (int i = 0; i < pieza.length; i++) {
    pieza[i].w = ANCHO;
  }
}

void mouseClicked(){
  if (estado == Estado.JUGANDO) {
    return;
  }
  else if (estado == Estado.ESPERANDO) {
    resetGame();
    estado = Estado.JUGANDO;
  } 
  else if (estado == Estado.MUERTO) {
    estado = Estado.ESPERANDO;
  }
}

//mouseMoved, mouseDragged
void mouseMoved() {
  if (estado == Estado.JUGANDO) {
    nave.move(mouseX);
  } 
}
  /* else if (estado == Estado.ESPERANDO) {
    resetGame();
    estado = Estado.JUGANDO;
  } 
  else if (estado == Estado.MUERTO) {
    estado = Estado.ESPERANDO;
  }
}
*/

