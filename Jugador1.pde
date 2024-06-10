class Jugador1{ 
  float xPos1; //posición en x del jugador1
  float yPos1; //posición en y del jugador1
  float xPos1Mover = 0; //variable que almacena el movimiento en el eje x
  float yPos1Mover = 0; //variable que almacena el movimiento en el eje y
  float velocidad1 = 7; //velocidad de movimiento
  PImage skin1; //imagen del jugador1 - default
  PImage escuelaSkin1; //skin del jugador2 - escuela seleccionada

  void setup(){
    xPos1 = width*0.94; //posición en x del jugador1, se posiciona dentro de su área
    yPos1 = height/2; //posición en y del jugador1, se posiciona a la mitad de la pista o ventana
    skin1=loadImage("jugador1.png"); //se carga la imagen "jugador1.png" en la variable 'jugador1'
    escuelaSkin1=loadImage("cs.png"); //se carga la imagen de la escuela seleccionada
    imageMode(CENTER); //se establece el modo de carga de imagen desde el centro
  }
  
  void draw(){
    image(skin1,xPos1,yPos1,78,78); //se carga la imagen en los valores x e y del objeto jugador1, además se establece sus dimensiones en 52px
    if (skin11){ //se verifica si la variable skin11 es verdadera
      image(escuelaSkin1,xPos1,yPos1,62,62); //si es verdadera se muestra la imagen de la escuela seleccionada con un tamaño más pequeño y que sigue a la skin default
    }
    xPos1 = xPos1 + xPos1Mover; //se actualiza la posición de x sumándole la velocidad de movimiento
    yPos1 = yPos1 + yPos1Mover; //se actualiza la posición de y sumándole la velocidad de movimiento
  }

  void colision(Disco DiscoLocal){ //función que calcula la colisión entre el disco de hockey y el jugador1
    float d = dist(xPos1, yPos1, DiscoLocal.xDisco, DiscoLocal.yDisco); //se calcula la distancia entre dos puntos, el valor x e y del jugador1 y el valor x e y del disco de hockey
    if (d < 50){ //si la distancia es menor a 35 es porque colisionan
    // este apartado ayuda a calcular la dirección que tomará el disco de hockey según la distancia entre el punto x e y del jugador1 y el disco
      float dx = xPos1-DiscoLocal.xDisco; //calcula la distancia entre los puntos x del jugador1 y el disco de hockey
      float dy = yPos1-DiscoLocal.yDisco; //calcula la distancia entre los puntos y del jugador1 y el disco de hockey
      DiscoLocal.xDiscoMovimiento = -dx*0.4; //calcula y establece el movimiento del disco en x según la distancia, se usa el negativo para que vaya en la dirección contraria
      DiscoLocal.yDiscoMovimiento = -dy*0.4; //calcula y establece el movimiento del disco en y según la distancia, se usa el negativo para que vaya en la dirección contraria
    }
  }
}
