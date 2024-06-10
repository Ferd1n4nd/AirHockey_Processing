Minim minim;
AudioPlayer song;
FFT fft;

class Vmenu{
  void draw() {
    // Avanzar la canción. Con draw() para cada "frame" de la canción...
    fft.forward(song.mix);
    
    // Cálculo de "puntajes" (potencia) para tres categorías de sonido
    // Primero guarde los valores antiguos
    oldScoreLow = scoreLow;
    oldScoreMid = scoreMid;
    oldScoreHi = scoreHi;
    
    // Restablecer valores
    scoreLow = 0;
    scoreMid = 0;
    scoreHi = 0;
   
    // Calcular las nuevas "puntuaciones"
    for(int i = 0; i < fft.specSize()*specLow; i++) {
      scoreLow += fft.getBand(i);
    }
    
    for(int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++) {
      scoreMid += fft.getBand(i);
    }
    
    for(int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++) {
      scoreHi += fft.getBand(i);
    }
    
    // Reduzca la velocidad del descenso.
    if (oldScoreLow > scoreLow) {
      scoreLow = oldScoreLow - scoreDecreaseRate;
    }
    
    if (oldScoreMid > scoreMid) {
      scoreMid = oldScoreMid - scoreDecreaseRate;
    }
    
    if (oldScoreHi > scoreHi) {
      scoreHi = oldScoreHi - scoreDecreaseRate;
    }
    
    // Volumen para todas las frecuencias en este momento, con los sonidos más altos más prominentes.
    // Esto permite que la animación vaya más rápido para sonidos más agudos, que son más perceptibles.
    float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
    
    // Color sutil de fondo
    background(scoreLow/100, scoreMid/100, scoreHi/100);
     
    // Cubo para cada banda de frecuencia
    for(int i = 0; i < nbCubes; i++) {
      // Valor de la banda de frecuencia
      float bandValue = fft.getBand(i);
      
      // El color se representa de la siguiente manera: rojo para graves, verde para medios y azul para agudos
      // La opacidad está determinada por el volumen de la banda y el volumen general
      cubes[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
    }
    
    // Línea de las paredes, aquí hay que mantener el valor de la banda anterior y la siguiente para conectarlas entre sí
    float previousBandValue = fft.getBand(0);
    
    // Distancia entre cada punto de línea, negativa porque en la dimensión z
    float dist = -25;
    
    // Multiplica la altura por esta constante
    float heightMult = 2;
    
    // Para cada banda
    for(int i = 1; i < fft.specSize(); i++) {
      // Valor de la banda de frecuencia, multiplicamos más las bandas para que sean más visibles
      float bandValue = fft.getBand(i)*(1 + (i/50));
      
      // Selección de colores según la fuerza de los diferentes tipos de sonidos.
      stroke(100+scoreLow, 100+scoreMid, 100+scoreHi, 255-i);
      strokeWeight(1 + (scoreGlobal/100));
      
      // Línea inferior izquierda
      line(0, height-(previousBandValue*heightMult), dist*(i-1), 0, height-(bandValue*heightMult), dist*i);
      line((previousBandValue*heightMult), height, dist*(i-1), (bandValue*heightMult), height, dist*i);
      line(0, height-(previousBandValue*heightMult), dist*(i-1), (bandValue*heightMult), height, dist*i);
      
      // Línea superior izquierda
      line(0, (previousBandValue*heightMult), dist*(i-1), 0, (bandValue*heightMult), dist*i);
      line((previousBandValue*heightMult), 0, dist*(i-1), (bandValue*heightMult), 0, dist*i);
      line(0, (previousBandValue*heightMult), dist*(i-1), (bandValue*heightMult), 0, dist*i);
      
      // Línea inferior derecha
      line(width, height-(previousBandValue*heightMult), dist*(i-1), width, height-(bandValue*heightMult), dist*i);
      line(width-(previousBandValue*heightMult), height, dist*(i-1), width-(bandValue*heightMult), height, dist*i);
      line(width, height-(previousBandValue*heightMult), dist*(i-1), width-(bandValue*heightMult), height, dist*i);
      
      // Línea superior recta
      line(width, (previousBandValue*heightMult), dist*(i-1), width, (bandValue*heightMult), dist*i);
      line(width-(previousBandValue*heightMult), 0, dist*(i-1), width-(bandValue*heightMult), 0, dist*i);
      line(width, (previousBandValue*heightMult), dist*(i-1), width-(bandValue*heightMult), 0, dist*i);
      
      // Guardar valor para el próximo giro de bucle
      previousBandValue = bandValue;
    }
    
    // Paredes rectangulares
    for(int i = 0; i < nbMurs; i++) {
      // A cada muro se le asigna una banda y se le envía su fuerza.
      float intensity = fft.getBand(i%((int)(fft.specSize()*specHi)));
      murs[i].display(scoreLow, scoreMid, scoreHi, intensity, scoreGlobal);
    }
  }
}
// Clase para cubos flotando en el espacio
class Cube {
  // Posición Z de inicio y posición Z máxima
  float startingZ = -10000;
  float maxZ = 1000;
  
  // Valores de posición
  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;
  
  // Constructor
  Cube() {
    // Haz que el cubo aparezca en un lugar aleatorio
    x = random(0, width);
    y = random(0, height);
    z = random(startingZ, maxZ);
    
    // Dale al cubo una rotación aleatoria.
    rotX = random(0, 1);
    rotY = random(0, 1);
    rotZ = random(0, 1);
  }
  
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    // Selección de color, opacidad determinada por intensidad (volumen de banda)
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, intensity*5);
    fill(displayColor, 255);
    
    // Líneas de color, desaparecen con la intensidad individual del cubo
    color strokeColor = color(255, 150-(20*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/300));
    
    // Creación de una matriz de transformación para realizar rotaciones, ampliaciones
    pushMatrix();
    
    // Cambio
    translate(x, y, z);
    
    // Cálculo de la rotación según la intensidad para el cubo.
    sumRotX += intensity*(rotX/1000);
    sumRotY += intensity*(rotY/1000);
    sumRotZ += intensity*(rotZ/1000);
    
    // Aplicación de rotación
    rotateX(sumRotX);
    rotateY(sumRotY);
    rotateZ(sumRotZ);
    
    // Creación de la caja, tamaño variable en función de la intensidad para el cubo
    box(100+(intensity/2));
    
    // Aplicación de la matriz
    popMatrix();
    
    // Cambio Z
    z+= (1+(intensity/5)+(pow((scoreGlobal/150), 2)));
    
    // Vuelva a colocar la caja en la parte posterior cuando ya no sea visible
    if (z >= maxZ) {
      x = random(0, width);
      y = random(0, height);
      z = startingZ;
    }
  }
}


// Clase para mostrar las líneas en los lados.
class Mur {
  // Posición minima y maxima de Z
  float startingZ = -10000;
  float maxZ = 50;
  
  // Valores de la posición
  float x, y, z;
  float sizeX, sizeY;
  
  // Constructor
  Mur(float x, float y, float sizeX, float sizeY) {
    // Hacer que la línea aparezca en el lugar especificado
    this.x = x;
    this.y = y;
    // Profundidad aleatoria
    this.z = random(startingZ, maxZ);  
    
    // Determinamos el tamaño porque las paredes de los pisos tienen un tamaño diferente a las de los lados
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  // Función de visualización
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal) {
    // Color determinado por sonidos bajos, medios y altos
    // Opacidad determinada por el volumen total
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, scoreGlobal);
    
    // Haz que las líneas desaparezcan en la distancia para dar una ilusión de niebla.
    fill(displayColor, ((scoreGlobal-5)/1000)*(255+(z/25)));
    noStroke();
    
    // Primera banda, la que se mueve según la fuerza
    // Matriz de transformación
    pushMatrix();
    
    // Cambio
    translate(x, y, z);
    
    // Aumento
    if (intensity > 100) intensity = 100;
    scale(sizeX*(intensity/100), sizeY*(intensity/100), 20);
    
    // Creacion de la "caja"
    box(1);
    popMatrix();
    
    // Segunda banda, la que siempre tiene el mismo tamaño
    displayColor = color(scoreLow*0.5, scoreMid*0.5, scoreHi*0.5, scoreGlobal);
    fill(displayColor, (scoreGlobal/5000)*(255+(z/25)));
    // Matriz de transformación
    pushMatrix();
    
    // Cambio
    translate(x, y, z);
    
    // Aumento
    scale(sizeX, sizeY, 10);
    
    // Creación de la caja
    box(1);
    popMatrix();
    
    // Cambio Z
    z+= (pow((scoreGlobal/150), 2));
    if (z >= maxZ) {
      z = startingZ;  
    }
  }
}
