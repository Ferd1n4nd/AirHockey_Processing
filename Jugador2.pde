class Jugador2{ 
  float xPos2; //posición en x del jugador2
  float yPos2; //posición en y del jugador2  
  float xPos2Mover = 0; //variable que almacena el movimiento en el eje x
  float yPos2Mover = 0; //variable que almacena el movimiento en el eje y
  float velocidad2 = 7; //velocidad de movimiento
  PImage skin2; //imagen del jugador2 - default
  PImage escuelaSkin2; //skin del jugador2 - escuela seleccionada

  void setup(){
    xPos2 = width/16; //posición en x del jugador2, se posiciona dentro de su área
    yPos2 = height/2; //posición en y del jugador2, se posiciona a la mitad de la pista o ventana
    skin2=loadImage("jugador2.png"); //se carga la imagen "jugador2.png" en la variable 'jugador2'
    escuelaSkin2=loadImage("cs.png"); //se carga la imagen de la escuela seleccionada
    imageMode(CENTER); //se establece el modo de carga de imagen desde el centro
  }

  void draw(){
    image(skin2,xPos2,yPos2,78,78); //se carga la imagen en los valores x e y del objeto jugador2, además se establece sus dimensiones en 52px
    if (skin22){ //se verifica si la variable skin22 es verdadera
      image(escuelaSkin2,xPos2,yPos2,62,62); //si es verdadera se muestra la imagen de la escuela seleccionada con un tamaño más pequeño y que sigue a la skin default
    }
    xPos2 = xPos2 + xPos2Mover; //se actualiza la posición de x sumándole la velocidad de movimiento
    yPos2 = yPos2 + yPos2Mover; //se actualiza la posición de y sumándole la velocidad de movimiento
  }

  void colision(Disco DiscoLocal){ //función que calcula la colisión entre el disco de hockey y el jugador2
    float d = dist(xPos2, yPos2, DiscoLocal.xDisco, DiscoLocal.yDisco); //se calcula la distancia entre dos puntos, el valor x e y del jugador2 y el valor x e y del disco de hockey
    if (d < 50){ //si la distancia es menor a 35 es porque colisionan
    // este apartado ayuda a calcular la dirección que tomará el disco de hockey según la distancia entre el punto x e y del jugador1 y el disco
      float dx = xPos2-DiscoLocal.xDisco; //calcula la distancia entre los puntos x del jugador2 y el disco de hockey
      float dy = yPos2-DiscoLocal.yDisco; //calcula la distancia entre los puntos y del jugador2 y el disco de hockey
      DiscoLocal.xDiscoMovimiento = -dx*0.4; //calcula y establece el movimiento del disco en x según la distancia, se usa el negativo para que vaya en la dirección contraria
      DiscoLocal.yDiscoMovimiento = -dy*0.4; //calcula y establece el movimiento del disco en y según la distancia, se usa el negativo para que vaya en la dirección contraria
    }
  }
}
