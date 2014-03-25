class Nave {
  float size = height/10;
  float x = width/2 - size/2, y = height - size*2.5;
  float prevx = width/2;
  
  void draw() {
    pushMatrix();
    noStroke();
    translate(x, y);
    fill(COL_NAVE);
    triangle(size/2, 0, 0, size, size, size);
    /*stroke(COL_NAVE);
    strokeWeight(1);
    noFill();
    ellipse(size/2, size/2, size*2, size*2);*/
    popMatrix();
    /*stroke(#000000);
    strokeWeight(10);
    point(x,y);
    strokeWeight(1);
    noFill();
    rect(x, y, size, size);*/
  }
  boolean colision(Pieza p1) {
    //HACK//
    //return false;
    return (x <= p1.w || x + size >= p1.x+p1.w+ANCHO*2);
  }
  
  void move(float posx){
    //calculo de la duracion de la nueva animacion
    float dur = (frameCount - ANIMSTART)*1.0/ANIMLENGTH;
    float diff = frameCount - ANIMSTART;
    //println(diff);
    //println("diff: " + diff + ", prevx: " + prevx + ", posx: " + posx + ", x: " + x);
    if(frameCount - ANIMSTART < ANIMLENGTH){
      float n = (posx - prevx)*dur + prevx;
      x = n;
      //println("prevx: " + prevx + ", posx: " + posx + ", x: " + x);
      //println("esperando");
    } else if(frameCount - ANIMSTART > ANIMLENGTH){
      x = posx;
      ANIMSTART = frameCount;
    }
    
    prevx = x;
    
  }
}


