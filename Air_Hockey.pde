//Bibliotecas
import ddf.minim.*;
import ddf.minim.analysis.*;

// Definición de los objetos
Jugador1 jugador1 = new Jugador1(); //se define e inicializa el objeto jugador1 de la clase Jugador1
Jugador2 jugador2 = new Jugador2(); //se define e inicializa el objeto jugador2 de la clase Jugador2
Disco disco = new Disco(); //se define e inicializa el objeto disco de la clase Disco
Vmenu vmenu = new Vmenu(); //se define e inicializa el objeto vmenu de la clase Vmenu
Escudo escudo = new Escudo(); //se define e inicializa el objeto escudo de la clase Escudo

// Visualizador Parte 1
// Variables que definen las "zonas" del espectro
// Por ejemplo, para el bajo, solo tomamos el primer 4% del espectro total
float specLow = 0.03; // 3%
float specMid = 0.125;  // 12.5%
float specHi = 0.20;   // 20%
// Esto deja un 64% del espectro posible que no se utilizará.
// Estos valores son generalmente demasiado altos para el oído humano de todos modos.
// Valores de puntuación para cada área
float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;
// Valores anteriores, para suavizar la reducción
float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;
// Valor de ablandamiento
float scoreDecreaseRate = 25;
// Cubos que aparecen en el espacio
int nbCubes;
Cube[] cubes;
// Líneas que aparecen a los lados
int nbMurs = 500;
Mur[] murs;
// Fin de visualizador Parte 1

//Variables del juego en general
int puntaje1 = 0; //variable que lleva el conteo del puntaje del jugador1
int puntaje2 = 0; //variable que lleva el conteo del puntaje del jugador2
int escenario = 0; //variable que determina el escenario a mostrar
PFont myFont; //variable de la fuente de texto
PImage pista; //imagen de la pista del air hockey
PImage fondo; //imagen del fondo exterior de la pista
PImage cs; //imagen del logo de Ciencia de computación
PImage electronica; //imagen del logo de Ing. Electrónica
PImage sistemas; //imagen del logo de Ing. de Sistemas
PImage teleco; //imagen del logo de Ing. de Telecomunaciones
PImage default1; //imagen del jugador1 - default
PImage default2; //imagen del jugador2 - default
PImage fondoSkins; //imagen del fondo del selector de skins
boolean skin11 = false; //variable booleana para definir si el jugador tiene skin o no
boolean skin22 = false; //variable booleana para definir si el jugador tiene skin o no
boolean contorno1, contorno2, contorno3, contorno4, contorno5, contorno6, contorno7, contorno8 = false; //variable booleana para mostrar o no el contorno de los logos al seleccionar una escuela como skin

//variables para la simulación de un cursor diferente
int num = 15;
float mx[] = new float[num];
float my[] = new float[num];

//variable audio de anotación
AudioPlayer anotacion;

//variable audio de choque con lados de la pista
AudioPlayer choque;

void setup(){
  // Visualizador Parte 2
  // Visualización en 3D en toda la pantalla
  size(1050,686,P3D);
  // Cargar biblioteca Minim
  minim = new Minim(this);
  // Cargar la canción
  song = minim.loadFile("song.mp3");
  // Crea el objeto FFT para analizar la canción.
  fft = new FFT(song.bufferSize(), song.sampleRate());
  // Un cubo por banda de frecuencia
  nbCubes = (int)(fft.specSize()*specHi);
  cubes = new Cube[nbCubes];
  // Tantas paredes como quieras
  murs = new Mur[nbMurs];
  // Crear todos los objetos
  // Crear los objetos del cubo
  for (int i = 0; i < nbCubes; i++) {
   cubes[i] = new Cube(); 
  }
  // Crear objetos de pared
  // Paredes de la izquierdas
  for (int i = 0; i < nbMurs; i+=4) {
   murs[i] = new Mur(0, height/2, 10, height); 
  }
  // Paredes de la derechas
  for (int i = 1; i < nbMurs; i+=4) {
   murs[i] = new Mur(width, height/2, 10, height); 
  }
  // Paredes de abajos
  for (int i = 2; i < nbMurs; i+=4) {
   murs[i] = new Mur(width/2, height, width, 10); 
  }
  // Paredes de arriba
  for (int i = 3; i < nbMurs; i+=4) {
   murs[i] = new Mur(width/2, 0, width, 10); 
  }
  // Fondo negro
  background(0);
  // Empezar la canción
  song.play(0);
  // Fin del visualizador Parte 2
  
  //definir variable con el sonido de anotación
  anotacion = minim.loadFile("hockey 2.mp3");
  
  //definir variable con el sonido de choque con los bordes de la pista
  
  choque = minim.loadFile("choque.mp3");
  
  // Llamado a las funcinones de los objetos
  jugador1.setup(); //se llama a la función setup del objeto jugador1
  jugador1.xPos1=width*0.94; //se establece la posición en el eje x del objeto jugador1
  jugador1.yPos1=height/2; //se establece la posición en el eje y del objeto jugador1
  jugador2.setup(); //se llama a la función setup del objeto jugador2
  jugador2.xPos2=width/16; //se establece la posición en el eje x del objeto jugador2
  jugador2.yPos2=height/2; //se establece la posición en el eje y del objeto jugador2
  disco.setup(); //se llama a la función setup del objeto disco
  
  // Se carga las imagenes
  pista=loadImage("pistaAirHockey.png"); //se carga la imagen "pistaAirHockey.png" en la variable pista
  fondo=loadImage("fondo2.png"); //se carga la imagen "fondo2.png" en la variable fondo
  cs=loadImage("cs.png"); //se carga la imagen "cs.png" en la variable cs
  electronica=loadImage("electronica.png"); //se carga la imagen "electronica.png" en la variable electronica
  sistemas=loadImage("sistemas.png"); //se carga la imagen "sistemas.png" en la variable sistemas
  teleco=loadImage("teleco.png"); //se carga la imagen "teleco.png" en la variable teleco
  default1=loadImage("jugador1.png"); //se carga la imagen "jugador1.png" en la variable default1
  default2=loadImage("jugador2.png"); //se carga la imagen "jugador2.png" en la variable default2
  fondoSkins=loadImage("skinsVS.png"); //se carga la imagen "skinsVS.png" en la variable fondoSkins
  imageMode(CENTER); //se establece el modo de carga de imagen desde el centro
}

void draw(){
  if(escenario == 0){ //calcula si la variable escenario es igual a 0
    menu(); //si se cumple muestra el menú de inicio
    noCursor(); //se quita el cursor de la pantalla en 0
    noStroke(); //se quita el contorno de las figuras
    fill(mouseX,mouseY,0,150); //se define el color dependiendo la posición del mouse
    //codigo que genera un nuevo diseño que simulara el cursor
    int which = frameCount % num;
    mx[which] = mouseX;
    my[which] = mouseY;
    for (int i = 0; i < num; i++) {
      int index = (which+1 + i) % num;
      ellipse(mx[index], my[index], i, i);
    }
  }
  else if(escenario == 1){ //calcula si la variable escenario es igual a 1
    //transicion.setup();****************************************************************************************Esto
    //transicion.draw();
    //fill(255,255,255,255);
    //ellipse(posicion,height,100,100);
    //posicion+=velocidad;
    //if(posicion > 1050){
    //  velocidad = velocidad * -1;
    //  pistaHockey();
    //}
    pistaHockey(); //si es igual a 1 se muestra la pista de hockey y el juego en sí
    noCursor();
  }
  else if(escenario == 2){ //calcula si la variable escenario es igual a 2
    //se genera el menú de selección de skins para ambos jugadores
    noCursor();
    noStroke();
    image(fondoSkins, width/2, height/2, 1050, 686);
    fill(255);
    textSize(60);
    text("Jugador1", 250, 100);
    text("Jugador2", 780, 100);
    
    textSize(20);
    textAlign(CENTER);
    if (contorno1){
      fill(#E80707);
      ellipse(150,350,160,160);
      fill(255);
    }
    image(cs,150,350,150,150);
    text("Ciencia de\nla Computacion",150,445);
    if (contorno2){
      fill(#E80707);
      ellipse(350,350,160,160);
      fill(255);
    }
    image(electronica,350,350,150,150);
    text("Ing. Electronica",350,445);
    if (contorno3){
      fill(#E80707);
      ellipse(150,550,160,160);
      fill(255);
    }
    image(sistemas,150,550,150,150);
    text("Ing. de Sistemas",150,645);
    if (contorno4){
      fill(#E80707);
      ellipse(350,550,160,160);
      fill(255);
    }
    image(teleco,350,550,150,150);
    text("Ing. de\nTelecomunicaciones",350,645);
    image(default1,250,200,150,150);
    
    if (contorno5){
      fill(#0D07E8);
      ellipse(700,350,160,160);
      fill(255);
    }
    image(cs,700,350,150,150);
    text("Ciencia de\nla Computacion",700,445);
    if (contorno6){
      fill(#0D07E8);
      ellipse(900,350,160,160);
      fill(255);
    }
    image(electronica,900,350,150,150);
    text("Ing. Electronica",900,445);
    if (contorno7){
      fill(#0D07E8);
      ellipse(700,550,160,160);
      fill(255);
    }
    image(sistemas,700,550,150,150);
    text("Ing. de Sistemas",700,645);
    if (contorno8){
      fill(#0D07E8);
      ellipse(900,550,160,160);
      fill(255);
    }
    image(teleco,900,550,150,150);
    text("Ing. de\nTelecomunicaciones",900,645);
    image(default2,800,200,150,150);
    
    //se genera el diseño que simulará el cursor
    fill(mouseX,mouseY,0,150);
    int which = frameCount % num;
    mx[which] = mouseX;
    my[which] = mouseY;
    for (int i = 0; i < num; i++) {
      int index = (which+1 + i) % num;
      ellipse(mx[index], my[index], i, i);
    }
  }
}

void menu(){
  vmenu.draw();
  myFont = createFont("ARCADECLASSIC.ttf",32);
  textFont(myFont); //se define el tipo de fuente de letra a usar
  textAlign(CENTER); //se define la alineación del texto desde el centro
  textSize (60); //se define el tamaño de texto en 60
  fill(255,255,255); //se define el color del texto en blanco
  text("AIR HOCKEY", width/2, height/2); //se escribe el título del juego en el centro de la ventana
  textSize (20); //se define el tamaño del texto en 20
  text("Presiona  P  para  pausar  la  musica", width-190, 25); //se escribe una instrucción para pausar la música
  text("Presiona  B  para  jugar", width/8, 604); //se escribe una instrucción en el lado inferior izquierdo
  text("Presiona  K  para  configurar  tu  skin", width/5.4, 629); //se escribe una instrucción en el lado inferior izquierdo
  text("Presiona  primero  Click  y  despues  R  si  el  disco  se  queda  fuera  de  la  pista  o  esta  estancado", width/2.23, 654); //se escribe una instrucción en el lado inferior izquierdo
  text("Teclas  de  movimiento  para  el  jugador1:  Flechas ↑ ↓ → ←", width/3.7, 25); //se escribe una instrucción en el lado superior izquierdo
  text("Teclas  de  movimiento  para  el  jugador2:  W A S D", width/4.27, 50); //se escribe una instrucción en el lado superior izquierdo
}

void pistaHockey(){
  image(fondo  ,width/2,height/2); //se establece el fondo exterior de la pista con una imagen
  image(pista,width/2,(height/2)+2); //se carga la imagen de la pista de AirHockey en medio de la pantalla y en el alto +2 para ajustar un poco la posición
  jugador1.draw(); //se llama a la función draw del objeto jugador1
  jugador2.draw(); //se llama a la función draw del objeto jugador2
  disco.draw(); //se llama a la función draw del objeto disco
  escudo.escudoJugador1();
  escudo.dibujoEscudo();
  jugador1.colision(disco); //se llama a la función colisión del jugador1 con el disco
  jugador2.colision(disco); //se llama a la función colisión del jugador2 con el disco
  
  fill(255); //define el color del texto en blanco
  textSize(50); //degine el tamaño del texto en 30
  text(puntaje1,width/2+250,160); //muestra el contenido de la variable 'puntaje1' en la parte superior del campo del jugador1
  text(puntaje2,width/2-250,160); //muestra el contenido de la variable 'puntaje2' en la parte superior del campo del jugador2
 
  if(jugador2.xPos2 >= width/2 - 39){ //calcula si la posición del jugador2 en el eje x es mayor o igual a la mitad de la pista
    jugador2.xPos2Mover = -1; //si se cumple, la función establece el movimiento del jugador2 en el eje x en -1 para que retroceda y no pueda cruzar al campo rival
  }
  if(jugador2.xPos2 <= 39){ //calcula si la posición del jugador2 en el eje x es menor o igual al inicio de la pista
    jugador2.xPos2Mover = 1; //si se cumple, la función establece el movimiento del jugador2 en el eje x en 1 para que avance y no pueda salir de la ventana
  }
  if(jugador2.yPos2 >= height - 139){ //calcula si la posición del jugador2 en el eje y es mayor o igual al alto de la pista
    jugador2.yPos2Mover = -1; //si se cumple, la función establece el movimiento del jugador2 en el eje y en -1 para que retroceda y no pueda salir de la ventana
  }
  if(jugador2.yPos2 <= 139){ //calcula si la posición del jugador2 en el eje y es menor al inicio de la pista
    jugador2.yPos2Mover = 1; //si se cumple, la función establece el movimiento del jugador2 en el eje y en 1 para que avance y no pueda salir de la pista
  }
 
  if(jugador1.xPos1 <= width/2 +39){ //calcula si la posición del jugador1 en el eje x es menor o igual a la mitad de la pista
    jugador1.xPos1Mover = 1; //si se cumple, la función establece el movimiento del jugador1 en el eje x en 1 para que avance y no pueda cruzar al campo rival
  }
  if(jugador1.xPos1 >= width - 39) { //calcula si la posición del jugador1 en el eje x es mayor o igual al ancho de la pista
    jugador1.xPos1Mover = -1; //si se cumple, la función establece el movimiento del jugador1 en el eje x en -1 para que retroceda y no pueda salir de la ventana
  }
  if(jugador1.yPos1 >= height - 139){ //calcula si la posición del jugador1 en el eje y es mayor o igual al alto de la pista
    jugador1.yPos1Mover = -1;  //si se cumple, la función establece el movimiento del jugador1 en el eje y en -1 para que retroceda y no pueda salir del campo de juego
  }
  if(jugador1.yPos1 <= 139){ //calcula si la posición del jugador1 en el eje y es menor o igual al inicio de la pista
    jugador1.yPos1Mover = 1; //si se cumple, la función establece el movimiento del jugador1 en el eje y en 1 para que avance y no pueda salir del campo de juego
  }
}

void mousePressed() {
  // Comprobar si se hizo clic dentro de una skin en el menú de skins
  if (mouseX > 75 && mouseX < 225 && mouseY > 275 && mouseY < 425 && escenario == 2) {
    jugador1.escuelaSkin1 = loadImage("cs.png");
    skin11 = true;
    contorno1 = true;
    contorno2 = contorno3 = contorno4 = false;
  } else if (mouseX > 275 && mouseX < 425 && mouseY > 275 && mouseY < 425 && escenario == 2) {
    jugador1.escuelaSkin1 = loadImage("electronica.png");
    skin11 = true;
    contorno2 = true;
    contorno1 = contorno3 = contorno4 = false;
  } else if (mouseX > 75 && mouseX < 225 && mouseY > 475 && mouseY < 625 && escenario == 2) {
    jugador1.escuelaSkin1 = loadImage("sistemas.png");
    skin11 = true;
    contorno3 = true;
    contorno1 = contorno2 = contorno4 = false;
  } else if (mouseX > 275 && mouseX < 425 && mouseY > 475 && mouseY < 625 && escenario == 2) {
    jugador1.escuelaSkin1 = loadImage("teleco.png");
    skin11 = true;
    contorno4 = true;
    contorno1 = contorno2 = contorno3 = false;
  } else if (mouseX > 175 && mouseX < 325 && mouseY > 125 && mouseY < 275 && escenario == 2) {
    skin11 = false;
    contorno1 = contorno2 = contorno3 = contorno4 = false;
  }
  
  if (mouseX > 625 && mouseX < 775 && mouseY > 275 && mouseY < 425 && escenario == 2) {
    jugador2.escuelaSkin2 = loadImage("cs.png");
    skin22 = true;
    contorno5 = true;
    contorno6 = contorno7 = contorno8 = false;
  } else if (mouseX > 825 && mouseX < 975 && mouseY > 275 && mouseY < 425 && escenario == 2) {
    jugador2.escuelaSkin2 = loadImage("electronica.png");
    skin22 = true;
    contorno6 = true;
    contorno5 = contorno7 = contorno8 = false;
  } else if (mouseX > 625 && mouseX < 775 && mouseY > 475 && mouseY < 625 && escenario == 2) {
    jugador2.escuelaSkin2 = loadImage("sistemas.png");
    skin22 = true;
    contorno7 = true;
    contorno5 = contorno6 = contorno8 = false;
  } else if (mouseX > 825 && mouseX < 975 && mouseY > 475 && mouseY < 625 && escenario == 2) {
    jugador2.escuelaSkin2 = loadImage("teleco.png");
    skin22 = true;
    contorno8 = true;
    contorno5 = contorno6 = contorno7 = false;
  } else if (mouseX > 725 && mouseX < 875 && mouseY > 125 && mouseY < 275 && escenario == 2) {
    skin22 = false;
    contorno5 = contorno6 = contorno7 = contorno8 = false;
  }
}
