class Escudo{
  boolean escudo1 = true; //se define la variable booleana escudo1 como verdadera
  boolean escudo2 = true; //se define la variable booleana escudo2 como verdadera
  int duracion = 200; //se define la variable entera duracion con un valor de 200
  int tiempo1 = 0; //se define la variable entera tiempo1 con un valor de 0
  int tiempo2 = 0; //se define la variable entera tiempo2 con un valor de 0
  int contador1 = 1200; //se define la variable entera contador1 con un valor de 1200
  int contador2 = 1200; //se define la variable entera contador2 con un valor de 1200
   
  void escudoJugador1(){
    strokeWeight(15); //se define el ancho del borde de la línea en 15
  }
  
  void dibujoEscudo(){
    contador1 += 1; //al ejecutarse la función en el draw principal, el contador1 va aumentando en 1
    contador2 += 1; //al ejecutarse la función en el draw principal, el contador2 va aumentando en 1
    
    if(contador1>=1200){ //verifica si el contador1 es mayor o igual a 1200
      fill(#A70C0C); //se define el color en rojo
      ellipse(width - 140, height - 65, 50, 50); //se genera un elipse debajo del campo del jugador1
      textSize(30); //se define el tamaño del texto en 30
      fill(255); //se define el color en blanco
      text("Escudo  Disponible", width - 150, height - 16); //se escribe el texto debajo del elipse rojo
      text("Presionar   N", width - 340, height - 65); //se escribe el texto al lado izquierdo del elipse rojo
    }
    
    if(contador2>=1200){ //verifica si el contador2 es mayor o igual a 1200
      fill(#0C1AA7); //se define el color en azul
      ellipse(140, height - 65, 50, 50); //se genera un elipse debajo del campo del jugador2
      textSize(30); //se define el tamaño del texto en 30
      fill(255); //se define el color en blanco
      text("Escudo Disponible", 150, height - 16); //se escribe el texto debajo del elipse azul
      text("Presionar   SHIFT", 340, height - 65); //se escribe el texto al lado derecho del elipse rojo
    }
    
    if(tiempo1 >= duracion){ //verifica si la variable tiempo1 es mayor o igual a la variable duracion
      escudo1 = true; //si se cumple, entonces vuelve a la variable escudo1 en true
      tiempo1 = 0; //se establce la variable tiempo1 en 0
    }
    if(tiempo2 >= duracion){ //verifica si la variable tiempo2 es mayor o igual a la variable duracion
      escudo2 = true; //si se cumple, entonces vuelve a la variable escudo2 en true
      tiempo2 = 0; //se establce la variable tiempo2 en 0
    }
    if(escudo1 == false){ //verifica si la variable escudo1 es falsa
      stroke(#A70C0C); //define el color en rojo
      line(1050, height/2 - 100, 1050, height/2 + 100); //dibuja una linea que cubre la extensión del arco del jugador1
      tiempo1 += 1; //la variable tiempo1 va aumentando de 1 en 1
      contador1 = 0; //el contador1 se establece en 0
    }
    
    if(escudo2 == false){ //verifica si la variable escudo2 es falsa
      stroke(#0C1AA7); //define el color en azul
      line(0, height/2 - 100, 0, height/2 + 100); //dibuja una linea que cubre la extensión del arco del jugador2
      tiempo2 += 1; //la variable tiempo2 va aumentando de 1 en 1
      contador2 = 0; //el contador2 se establece en 0
    }
  }
}
