// volatile se usa para definir una variable a ser usada en una
volatile boolean cruceCero = false;

int numeroCruces = 0;
int lamp = 3;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);

  // Pin de salida
  pinMode(lamp, OUTPUT);

  // Definir el pin 2 para la interrupción
  attachInterrupt(digitalPinToInterrupt(2), deteccionCruceCero, RISING);

  Serial.println("Interruptor inteligente iniciado");
  Serial.println("Parpadero cada 0.5s");
}

void loop() {
  // Código para la implementación
  if (numeroCruces == 60 ){
    digitalWrite(lamp, HIGH);
    delay(1);
    digitalWrite(lamp, LOW);
    cruceCero = false;
    Serial.println("Lampara prendida");
  }
}

void deteccionCruceCero(){
  cruceCero = true;
  numeroCruces++;
  if (numeroCruces == 61){
    numeroCruces = 0;
  }
  Serial.println(numeroCruces);
}