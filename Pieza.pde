class Pieza {
  float x = 0, y = 0, w = ANCHO, h = height/PIEZAS;
  void draw() {
    fill(COL_PIEZA);
    noStroke();
    rectMode(CORNER);
    rect(x, y, w, h);
    rect(x+w+ANCHO*2, y, width, h);
  }
}
