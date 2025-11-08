int btnSwitch = 2;
int lamp = 3;

int stateButton;
bool stateLamp = false;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(btnSwitch, INPUT);
  pinMode(lamp, 3);
  Serial.println("Interruptor inteligente iniciado");
}

void loop() {
  // put your main code here, to run repeatedly:
  stateButton = digitalRead(btnSwitch);
  if (stateButton == HIGH){
    Serial.println("Boton presionado");
    if (stateLamp){
      digitalWrite(lamp, LOW);
      stateLamp = false;
    }else{
      digitalWrite(lamp, HIGH);
      stateLamp = true;
    }
  }
}