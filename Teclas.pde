void keyPressed(){
  if (key=='p'){
    if (song.isPlaying()) {
      song.pause(); //pausa de la musica
    } else {
      song.play();
    }
  }
  if(key=='w'){
    jugador2.yPos2Mover = -jugador2.velocidad2; //movimiento hacia arriba - se resta al valor de y
  }
  if(key=='s'){
    jugador2.yPos2Mover = jugador2.velocidad2; //movimiento hacia abajo - se suma al valor de y
  }
  if(key=='a'){
    jugador2.xPos2Mover = -jugador2.velocidad2; //movimiento hacia la izquierda - se resta al valor de x
  }
  if(key=='d'){
    jugador2.xPos2Mover = jugador2.velocidad2; //movimiento hacia la derecha - se suma al valor de x
  }
  
  if(key==CODED){
    if(keyCode==UP){
      jugador1.yPos1Mover = -jugador1.velocidad1; //movimiento hacia arriba - se resta al valor de y
    }
    if(keyCode==DOWN){
      jugador1.yPos1Mover = jugador1.velocidad1; //movimiento hacia abajo - se suma al valor de y
    }
    if(keyCode==LEFT){
      jugador1.xPos1Mover = -jugador1.velocidad1; //movimiento hacia la izquierda - se resta al valor de x
    }
    if(keyCode==RIGHT){
      jugador1.xPos1Mover = jugador1.velocidad1; //movimiento hacia la derecha - se suma al valor de x
    }
  }
  
  if(key=='n' && escenario == 1 && escudo.contador1>=1200){ //verifica si se ha presionado la tecla 'n', si se está en la pista de hockey y si el contador1 de la clase escudo es mayor a 1200. 
    escudo.escudo1 = false; //si se cumple la condición, el valor de escudo1 cambiará a falso
  }
  if(keyCode==SHIFT && escenario == 1 && escudo.contador2>=1200){ //verifica si se ha presionado la tecla 'SHIFT', si se está en la pista de hockey y si el contador2 de la clase escudo es mayor a 1200.
    escudo.escudo2 = false; //si se cumple la condición, el valor de escudo1 cambiará a falso
  }
  
  if(key=='r' && mousePressed){ //ejecuta el if si se presiona la tecla 'r' y el mouse a la vez, ello para evitar desacuerdos.
    disco.xDisco = width/2; //si se presiona 'r' coloca el disco de hockey en medio del ancho de la ventana del programa/de la pistaAirHockey
    disco.yDisco = height/2; //si se presiona 'r' coloca el disco de hockey en medio del alto de la ventana del programa/de la pistaAirHockey
    disco.xDiscoMovimiento = 0; //establece la velocidad en x del disco a 0, lo detiene
    disco.yDiscoMovimiento = 0; //establece la velocidad en y del disco a 0, lo detiene
  }
  if(escenario == 0 && key=='b'){ //si se presiona la tecla 'b' y se está en el menú de inicio, cambia de escenario al campo de juego
    escenario = 1; //escenario del campo de juego
  }
  if(escenario == 1 && key=='m'){ //si se presiona la tecla 'm' y se está en el juego, cambia de escenario al menú
    escenario = 0; //escenario del menú del juego
  }
  if(escenario == 0 && key=='k'){ //si se presiona la tecla 'k' y se está en el menú de inicio, cambia de escenario al selector de skins
    escenario = 2; //escenario de selector de skins
  }
  if(escenario == 2 && key=='m'){ //si se presiona la tecla 'm' y se está en el selector de skins, cambia de escenario al menú del juego
    escenario = 0; //escenario del menú del juego
  }
}
    
void keyReleased(){
  if(key=='w' || key=='s'){ //si el jugador2 deja de presionar 'w' o 's', se establecerá su velocidad de "y" en 0 y se dejará de mover
    jugador2.yPos2Mover = 0;
  }
  if(key=='a' || key=='d'){ //si el jugador2 deja de presionar 'a' o 'd', se establecerá su velocidad de "x" en 0 y se dejará de mover
    jugador2.xPos2Mover = 0;
  }
  if(key==CODED){
    if(keyCode==UP || keyCode==DOWN){ //si el jugador1 deja de presionar la flecha 'UP' o 'DOWN', se establecerá su velocidad de "y" en 0 y se dejará de mover
      jugador1.yPos1Mover = 0;
    }
    if(keyCode==LEFT || keyCode==RIGHT){ //si el jugador1 deja de presionar la flecha 'LEFT' o 'RIGHT', se establecerá su velocidad de "x" en 0 y se dejará de mover
      jugador1.xPos1Mover = 0;
    }
  }
}
