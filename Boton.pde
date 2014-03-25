class Boton {
  float x, y, w = 32, h = 32;
  color colBack = #FFFFFF;
  color colFore = #000000;

  void draw(){
    //implemente en el hijo
  }

  boolean over() {
    return overRect(x, y, w, h);
  }
  
  boolean clicked(){
    return over();
  }

  boolean overRect(float x, float y, float width, float height) {
    if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
      return true;
    } 
    
    return false;
  }
}

class BotonPausa extends Boton {
  BotonPausa(float x, float y){
    colBack = COL_AVISO;
    colFore = COL_FONDO;
    this.x = x; this.y = y;
  }
  
  void draw(){
    rectMode(CORNER);
    noStroke();
    fill(colBack);
    rect(x, y, w, h);
    //fill(colFore);
    //rect(x
  }
}
