float angle;
int posicion = 0; //variable que determina la posición para la transición **************************************Agregar esto
int velocidad = 5; //variable que determina la velocidad ***********************************************Agregar esto

class Transicion{
  void setup() {
    surface.setLocation(957,0);
    rectMode(CENTER);
    stroke(0,15,30);
    strokeWeight(10);
  }
  void draw() {
    background(0,15,30,0);
    translate(width/2, height/2); //investigar esste
    float scaleVar = map(posicion, 0, width, 0.5, 5);
    scale(scaleVar); //escalar la flor
    for (int i=0; i<100; i++) {
      fill(i*10, 255-i*25, 255-i*10); //color de la flor 
      scale(0.95); //investigar este
      rotate(radians(angle)); //investigar este
      rect(0, 0, 600, 600); //este son los rectangulos
    }
    angle+=0.1; //hace que el rectangulo rote sumandole aumentandole al angulo
  }
}
