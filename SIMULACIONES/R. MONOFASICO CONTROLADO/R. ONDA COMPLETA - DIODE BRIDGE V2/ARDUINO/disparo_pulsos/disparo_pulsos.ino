// Variable de entrada asincrona (volatile)
volatile boolean cruceCero = false;

// Variables de salida
int p1 = 3;
int p2 = 4;
int p3 = 5;
int p4 = 6;

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
  pinMode(p3, OUTPUT);
  pinMode(p4, OUTPUT);
  // Asincronismo
  attachInterrupt(0, deteccionCruceCero, RISING);

  Serial.println("Rectificador Monofasico Controlando..");
  Serial.println("Programa Iniciado");
}

void loop() {
  
  // Iniciando
  pot = analogRead(A0);
  dim = map(pot, 0, 1023, 0, 500);

  if (x == 1 && cruceCero == true){
    delay(dim);
    digitalWrite(p1, HIGH);
    digitalWrite(p3, HIGH);
    delay(1);
    digitalWrite(p1, LOW);
    digitalWrite(p3, LOW);
    cruceCero = false;
  }

  if (x == 2 && cruceCero == true){
    delay(dim);
    digitalWrite(p4, HIGH);
    digitalWrite(p2, HIGH);
    delay(1);
    digitalWrite(p4, LOW);
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
  digitalWrite(p3, LOW);
  digitalWrite(p4, LOW);
}

