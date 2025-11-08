// Variable de entrada asincrona (volatile)
volatile boolean cruceCero = false;

// Variables de salida
int p1 = 3;
int p2 = 4;

// Adicionales
int dim = 0;
int pot = A0;
int x = 0;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  // Entrada
  // Salida
  pinMode(p1, OUTPUT);
  pinMode(p2, OUTPUT);

  // Asincronismo
  attachInterrupt(0, deteccionCruceCero, RISING);

  Serial.print("Rectificador Monofasico Controlando..");
  Serial.print("Programa Iniciado");
}

void loop() {
  
  // Iniciando
  pot = analogRead(A0);

  dim = map(pot, 0, 1023, 0, 8.3);
  if (x == 1 && cruceCero == true){
    delay(dim);
    digitalWrite(p1, HIGH);
    delay(1);
    digitalWrite(p1, LOW);
    cruceCero = false;
  }

  if (x == 2 && cruceCero == true){
    delay(dim);
    digitalWrite(p2, HIGH);
    delay(1);
    digitalWrite(p2, LOW);
    cruceCero = false;
  }

}

void deteccionCruceCero(){
  // 
  cruceCero = true;
  if (x == 2){
    x = 0;
  }
  x++;
  Serial.println(x);
  digitalWrite(p1, LOW);
  digitalWrite(p2, LOW);
}
