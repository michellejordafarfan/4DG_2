import processing.pdf.*;

boolean record;
PFont myfont;
float angleOffset = 0; // Desplazamiento de ángulo
color espiralColor; // Color de la espiral

void setup() {
  frameRate(20); // Aumentar la tasa de frames para un movimiento más suave
  size(568, 843);
  myfont = createFont("IBMPlexMono-Medium.ttf", 48);
  textFont(myfont);
  espiralColor = color(random(255), random(255), random(255)); // Color inicial aleatorio
}

void draw() {
  if (record) {
    beginRecord(PDF, "espiral-####.pdf");
  }
  
  background(255);
  fill(0);
  textSize(8);
  
  // Llama a volen en cada frame
  volen();  
  // Llama a espiga
  espiga(); 
  // Y llama a espiral
  espiral();
  // Y llama a la columna vertical
  columnaVertical();

  // Cambia el color de la espiral
  espiralColor = color(0); // Actualiza el color
  
saveFrame("png/onomatopeia-####.png");
  
  if (record) {
    endRecord();
    record = false;
  }
}

void volen() {
  for (int y = 20; y <= height - 20; y += 20) { // Recorre el eje Y
    for (int x = 20; x <= width - 20; x += 40) { // Recorre el eje X
      if (random(1) > 0.5) { // Probabilidad del 50% para dibujar "click"
        fill(0); // Color aleatorio
        text("click", x, y); // Dibuja "click" en la posición (x, y)
      }
    }
  }
}

void espiga() {
  for (int y = 120; y <= 170; y += 25) {
    for (int x = 20; x <= width - 20; x += 25) {
      fill(0);
      if ((x % 10) == 0) {
        text("click", x + 8, y - 8);
      } else {
        text("click", x + 8, y + 8);
      }
    }
  }
}

void espiral() {
  float angle = angleOffset; // Usa el desplazamiento de ángulo
  float radius = 0; // Radio inicial

  for (int i = 0; i < 200; i++) {
    float x = width / 2 + cos(angle) * radius;
    float y = height / 2 + sin(angle) * radius;
    
    if (x > 0 && x < width && y > 0 && y < height) {
      fill(espiralColor); // Usa el color de la espiral
      text("click", x, y);
    }

    angle += 0.2; // Incrementa el ángulo
    radius += 4; // Incrementa el radio
  }

  angleOffset += 0.05; // Aumenta la velocidad de rotación
}

void columnaVertical() {
  float startX = width / 2; // Posición X centrada
  float startY = height / 2 + 100; // Posición Y justo debajo de la espiral

  for (int i = 0; i < 30; i++) { // Ajusta el número de "click"
    fill(0);
    text("click", startX, startY + i * 20); // Dibuja "click" en una columna
  }
}

void mousePressed() {
  record = true; // Cambia el estado a guardando
}
