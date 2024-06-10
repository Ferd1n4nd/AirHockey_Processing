class Disco{
  boolean mostrarTexto = true; //variable booleana que hará que se muestre el texto al conseguir un punto o no
  int tiempoParpadeo = 30; //intervalo de tiempo para el parpadeo del texto al conseguir un punto
  float xDisco; //posición en x del disco
  float yDisco; //posición en y del disco
  float bDisco = 38; //medida del ancho del disco
  float hDisco = 38; //medida del alto del disco
  float xDiscoMovimiento = 0; //movimiento del disco en torno al eje x
  float yDiscoMovimiento = 0; //movimiento del disco en torno al eje y
  float movimientoSuave = 0.07; //valor que da el efecto de un movimiento más suavizado
  boolean regresar1 = false; //establece la variable booleana regresar como falso, se usará para dar paso al efecto de movimieto suavizado regresando los objetos a sus lugares
  boolean regresar2 = false; //establece la variable booleana regresar como falso, se usará para dar paso al efecto de movimieto suavizado regresando los objetos a sus lugares
  boolean posicionDisco1 = false; //establece la variable booleana regresar como falso, se usará para dar paso al efecto de movimieto suavizado regresando el disco al lugar respectivo
  boolean posicionDisco2 = false; //establece la variable booleana regresar como falso, se usará para dar paso al efecto de movimieto suavizado regresando el disco al lugar respectivo
  PImage disco; //imagen del disco

  void setup(){
    xDisco = width/2; //posición en x del disco, se posiciona en medio de la pista o ventana
    yDisco = height/2; //posición en y del disco, se posiciona en medio de la pista o ventana
    disco = loadImage("disco.png"); //se carga la imagen "disco.png" en la variable 'disco'
    imageMode(CENTER); //se establece el modo de carga de imagen desde el centro
  }
  
  void draw(){
    image(disco,xDisco,yDisco,50,50); //se carga la imagen en los valores x e y del objeto disco, además se establece sus dimensiones en 33px
    xDisco = xDisco + xDiscoMovimiento; //se actualiza la posición del disco en el eje x según los valores del movimiento en x
    yDisco = yDisco + yDiscoMovimiento; //se actualiza la posición del disco en el eje y según los valores del movimiento en y
    xDiscoMovimiento = xDiscoMovimiento * 0.993; //se establece el valor del movimiento en el eje x del disco y rebote dando un efecto de velocidad
    yDiscoMovimiento = yDiscoMovimiento * 0.993; //se establece el valor del movimiento en el eje x del disco y rebote dando un efecto de velocidad
    
    int intervaloTiempo = frameCount/tiempoParpadeo; //variable que calcula el número de intervalos completos que se ha definido
    mostrarTexto = intervaloTiempo%2 == 0; //alterna el valor de la variable booleana "mostrarTexto" para mostrar u ocultar según si el número de intervalos completos es par o impar
    
    if(xDisco >= width){ //calcula si la posición del disco en el eje x es mayor o igual al valor del ancho de la vetana o pista de juego
      choque.play(0);
      xDiscoMovimiento = -xDiscoMovimiento; //si es mayor o igual el movimiento del disco en el eje "x", este se vuelve negativo, haciendo que rebote en dirección contraria
    }
    if(xDisco <= 0){ //calcula si la posición del disco en el eje x es menor o igual al valor del inicio del ancho vetana o pista de juego
      choque.play(0);
      xDiscoMovimiento = -xDiscoMovimiento; //si es menor o igual el movimiento del disco en el eje "x", este se vuelve negativo, haciendo que rebote en dirección contraria
    }
    if(yDisco >= height - 130){ //calcula si la posición del disco en el eje x es mayor o igual al valor del alto de la pista de juego
      choque.play(0);
      yDiscoMovimiento = -yDiscoMovimiento; //si es mayor o igual el movimiento del disco en el eje "y", este se vuelve negativo, haciendo que rebote en dirección contraria
    }
    if(yDisco <= 130){ //calcula si la posición del disco en el eje y es menor o igual al valor del inicio del alto de la pista de juego
      choque.play(0);
      yDiscoMovimiento = -yDiscoMovimiento; //si es menor o igual el movimiento del disco en el eje "y", este se vuelve negativo, haciendo que rebote en dirección contraria
    }
    else if(yDisco > height/2-100 && yDisco < height/2+100 && xDisco >= 1050 && escudo.escudo1){ //calcula si la posición del disco en el eje x e y se encuentra dentro del área de anotación del jugador1
      regresar2 = true;
      puntaje2 = puntaje2 +1; //se le suma un punto al puntaje del jugador2
      xDiscoMovimiento = 0; //establece el movimiento en x del disco en 0, hace que no se mueva
      yDiscoMovimiento = 0; //establece el movimiento en y del disco en 0, hace que no se mueva
      xDisco = width/2;
      yDisco = height/2;
      anotacion.play(0); //reproducción del sonido de anotación
    }
    else if(yDisco > height/2-100 && yDisco < height/2+100 && xDisco <= 0 && escudo.escudo2){ //calcula si la posición del disco en el eje x e y se encuentra dentro del área de anotación del jugador2
      regresar1 = true;
      puntaje1 = puntaje1 +1; //se le suma un punto al puntaje del jugador1
      xDiscoMovimiento = 0; //establece el movimiento en x del disco en 0, hace que no se mueva
      yDiscoMovimiento = 0; //establece el movimiento en y del disco en 0, hace que no se mueva
      xDisco = width/2; //establece la posición del Disco en el eje x en la mitad de la pista
      yDisco = height/2; //establece la posición del Disco en el eje y en la mitad de la pista
      anotacion.play(0); //reproducción del sonido de anotación
    }
    if(regresar2){ //verifica si la variable regresar2 es verdadera
      if(jugador2.xPos2 <= width/16+5 && jugador1.xPos1 >= width*0.94-5){ //verifica que la posición de ambos jugadores sea en sus áreas
        posicionDisco2 = true; //si es así vuelve verdadero la variable posicionDisco2
      }
      float posicionFinalX2 = width/16; //se crea una variable local de la posición destino del jugador 2 en el eje x
      float distanciaX2 = posicionFinalX2 - jugador2.xPos2; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del jugador2 respecto al eje X
      jugador2.xPos2 += distanciaX2 * movimientoSuave; //se actualiza la posicion del jugador2 respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      float posicionFinalY2 = height/2; //se crea una variable local de la posición destino del jugador 2 en el eje y
      float distanciaY2 = posicionFinalY2 - jugador2.yPos2; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del jugador2 respecto al eje Y
      jugador2.yPos2 += distanciaY2 * movimientoSuave; //se actualiza la posicion del jugador2 respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      
      float posicionFinalX1 = width*0.94;  //se crea una variable local de la posición destino del jugador 1 en el eje x
      float distanciaX1 = posicionFinalX1 - jugador1.xPos1; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del jugador1 respecto al eje X
      jugador1.xPos1 += distanciaX1 * movimientoSuave; //se actualiza la posicion del jugador1 respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      float posicionFinalY1 = height/2; //se crea una variable local de la posición destino del jugador 1 en el eje y
      float distanciaY1 = posicionFinalY1 - jugador1.yPos1; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del jugador1 respecto al eje Y
      jugador1.yPos1 += distanciaY1 * movimientoSuave; //se actualiza la posicion del jugador1 respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      
      if(posicionDisco2){ //verifica si la variable posicionDisco2 es verdadera
        if(xDisco >= 795){ //verifica si la posición del disco en el eje x es mayor o igual a 795
        posicionDisco2 = false; //si se cumple la variable posicionDisco2 se vuelve falsa
        regresar2 = false; //si se cumple la variable regresar2 se vuelve falsa
        }
        float posicionFinalDiscoX = 800; //se crea una variable local de la posición destino del disco en el eje x
        float distanciaDiscoX = posicionFinalDiscoX - xDisco; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del disco respecto al eje X
        xDisco += distanciaDiscoX * movimientoSuave; //se actualiza la posicion del disco respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
        float posicionFinalDiscoY = height/2; //se crea una variable local de la posición destino del disco en el eje y
        float distanciaDiscoY = posicionFinalDiscoY - yDisco; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del disco respecto al eje Y
        yDisco += distanciaDiscoY * movimientoSuave; //se actualiza la posicion del disco respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      }
    }
    if(regresar1){ //verifica si la variable regresar1 es verdadera
      if(jugador2.xPos2 <= width/16+5 && jugador1.xPos1 >= width*0.94-5){ //verifica que la posición de ambos jugadores sea en sus áreas
        posicionDisco1 = true; //si es así vuelve verdadero la variable posicionDisco1
      }
      float posicionFinalX2 = width/16; //se crea una variable local de la posición destino del jugador 2 en el eje x
      float distanciaX2 = posicionFinalX2 - jugador2.xPos2; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del jugador2 respecto al eje X
      jugador2.xPos2 += distanciaX2 * movimientoSuave; //se actualiza la posicion del jugador2 respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      float posicionFinalY2 = height/2; //se crea una variable local de la posición destino del jugador 2 en el eje y
      float distanciaY2 = posicionFinalY2 - jugador2.yPos2; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del jugador2 respecto al eje Y
      jugador2.yPos2 += distanciaY2 * movimientoSuave; //se actualiza la posicion del jugador2 respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      
      float posicionFinalX1 = width*0.94;  //se crea una variable local de la posición destino del jugador 1 en el eje x
      float distanciaX1 = posicionFinalX1 - jugador1.xPos1; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del jugador1 respecto al eje X
      jugador1.xPos1 += distanciaX1 * movimientoSuave; //se actualiza la posicion del jugador1 respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      float posicionFinalY1 = height/2; //se crea una variable local de la posición destino del jugador 1 en el eje y
      float distanciaY1 = posicionFinalY1 - jugador1.yPos1; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del jugador1 respecto al eje Y
      jugador1.yPos1 += distanciaY1 * movimientoSuave; //se actualiza la posicion del jugador1 respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      
      if(posicionDisco1){ //verifica si la variable posicionDisco1 es verdadera
        if(xDisco <= 255){ //verifica si la posición del disco en el eje x es menor o igual a 255
        posicionDisco1 = false; //si se cumple la variable posicionDisco1 se vuelve falsa
        regresar1 = false; //si se cumple la variable regresar1 se vuelve falsa
        }
        float posicionFinalDiscoX = 250; //se crea una variable local de la posición destino del disco en el eje x
        float distanciaDiscoX = posicionFinalDiscoX - xDisco; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del disco respecto al eje X
        xDisco += distanciaDiscoX * movimientoSuave; //se actualiza la posicion del disco respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
        float posicionFinalDiscoY = height/2; //se crea una variable local de la posición destino del disco en el eje y
        float distanciaDiscoY = posicionFinalDiscoY - yDisco; //se crea y calcula una variable que almacena la distancia que hay entre la posición destino y la actual del disco respecto al eje Y
        yDisco += distanciaDiscoY * movimientoSuave; //se actualiza la posicion del disco respecto a la distancia con la posición destino con un efecto de movimiento suave - se acerca a su área
      }
    }
    if(regresar1 && mostrarTexto){ //condición para que se muestre el texto, que el disco este quieto y la variable "mostrarTexto" sea verdadera
      //genera un efecto de contorno dado que no existe función que defina el contorno de un texto
      fill(255); //define el color del texto a blanco
      text("PUNTO PARA EL JUGADOR 1",width/2,70); //se genera el texto "PUNTO PARA EL JUGADOR 1" en la parte media y superior de la ventana/pista
    }
    if(regresar2 && mostrarTexto){ //condición para que se muestre el texto, que el disco este quieto y la variable "mostrarTexto" sea verdadera
      //genera un efecto de contorno dado que no existe función que defina el contorno de un texto
      fill(255); //define el color del texto a un azul muy claro
      text("PUNTO PARA EL JUGADOR 2",width/2,70); //se genera el texto "PUNTO PARA EL JUGADOR 2" en la parte media y superior de la ventana/pista
    }
    
    noFill(); //se quita el relleno del objeto del disco para que no interfiera con la imagen "disco.png"
    noStroke(); //se quita el contorno del objeto del disco para que no interfiera con la imagen "disco.png"
    ellipse (xDisco, yDisco, bDisco, hDisco); //se crea la ellipse que actuaría como hitbox del disco, necesaria para las demás operaciones
  }
}
