
// Variables de entrada
volatile boolean cruceCero = 0;
int triac = 3;
int triac2 = 4;
int x = 1;
int POT;
int dim;

// Configuración inicial
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(triac, OUTPUT);
  pinMode(triac2, OUTPUT);
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
  x++;
  if (x == 3){
    x = 1;
  }
  Serial.println(x),
  digitalWrite(triac, LOW);
  digitalWrite(triac2, LOW);
}

void loop() {
  // Lectura de POT y realizar una equivalencia entre los valores leidos de 0 a 8.3
  POT = analogRead(A0);
  // Con estos valores se define el tiempo de disparo para los SRC (Tiristores)
  // Freq = 60Hz -> T = 16.66ms & T/2 = 8.33ms que es el tiempo máximo para poder enviar el pulso de activación
  dim = map(POT, 0, 1023, 0, 8.3);
  

  // Envía los pulsos según el valor actual del pot para el tiempo

  if ( x == 1 && cruceCero == true){
    delay(dim);
    digitalWrite(triac, HIGH);
    delay(1);
    digitalWrite(triac, LOW);
    cruceCero = false;
  }


  if ( x == 2 && cruceCero == true){
    delay(dim);
    digitalWrite(triac2, HIGH);
    delay(1);
    digitalWrite(triac2, LOW);
    cruceCero = false;
  }
}
