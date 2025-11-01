
// Variables de entrada
volatile boolean cruceCero = 0;

int triac1 = 3;
int triac2 = 4;
int triac3 = 5;
int triac4 = 6;
int triac5 = 7;
int triac6 = 8;

// contador
int x = 1;
int POT;
int dim;
float phaseAcumulator = 0;

// Configuración inicial
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  for (int i = 3; i <= 8; i++){
    // Estableciendo los pines [3, 8] como salida
    pinMode(i, OUTPUT);
  }
  // Creando una interrupción
  // 0, pin2 para sensar las interrupciones
  // Cuando se detecte una interrupcion RISING (Salto) a la función definida
  // RISING (Salto) ocurre cuando se tiene un cambio de valor bajo a alto
  attachInterrupt(0, deteccionCruceCero, RISING);
}

void deteccionCruceCero(){
  cruceCero = true;
  // Conteo, se utiliza para contar las señales rectificadas
  // Para el monofasico se tiene un total de señales equivalente a 2 (y tal valor delimita al contador)
  if (x == 6){
    x = 1;
  }
  x++;  
  Serial.println(x);
  digitalWrite(triac1, LOW);
  digitalWrite(triac2, LOW);
}

void loop() {
  // Lectura de POT y realizar una equivalencia entre los valores leidos de 0 a 8.3
  POT = analogRead(A0);
  // Con estos valores se define el tiempo de disparo para los SRC (Tiristores)
  // Freq = 60Hz -> T = 16.66ms & T/2 = 8.33ms que es el tiempo máximo para poder enviar el pulso de activación

  // Limite de simulación se encuentra 
  // 6.5 representa el límite max de 150 grados para la rectificación
  dim = map(POT, 0, 1023, 0, 6.5);
  phaseAcumulator = 0;
  phaseAcumulator = 1.38+dim;
  // Envía los pulsos según el valor actual del pot para el tiempo

  if ( x == 1 && cruceCero == true){
    conmutarTh(triac1);
  }
  if ( x == 2 && cruceCero == true){
    conmutarTh(triac2);
  }
  if ( x == 3 && cruceCero == true){
    conmutarTh(triac3);
  }
  if ( x == 4 && cruceCero == true){
    conmutarTh(triac4);
  }
  if ( x == 5 && cruceCero == true){
    conmutarTh(triac5);
  }
  if ( x == 6 && cruceCero == true){
    conmutarTh(triac6);
  }
}

void conmutarTh(int th){
  delay(phaseAcumulator);
  phaseAcumulator += 1.38;
  digitalWrite(th, HIGH);
  delay(1);
  digitalWrite(th, LOW);
  cruceCero = false;
}






























