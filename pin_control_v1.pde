
char inString[7] = "000000";
char s_pin[4] = "000";
char s_val[4] = "000";
int tick = 0;
int myPins[] = {0,0,0,0};

void setup() {
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(7, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
  Serial.begin(9600);
}

void fetch_string() {
  int index = 0;
  char s_pin[4] = "000";
  char s_val[4] = "000";
  char inChar;
  while (Serial.available() > 0)
    {
      if (index >= 0 && index < 3) {
        inChar = Serial.read();
        s_pin[index] = inChar;
        inString[index] = '\0';
      }
      else if (index >= 3) {
        inChar = Serial.read();
        s_val[index-3] = inChar;
        inString[index] = '\0';
      }
      else {
        Serial.read();
      }
    index++;
    }
    if (index > 0) {
      Serial.println(s_pin);
      Serial.println(s_val);
      int pin;
      int val;
      spin_motor(atoi(s_pin), atoi(s_val));
    }
    Serial.flush();
}

void spin_motor(int  pin, int value) {
  Serial.println("SPINING MOTORS!");
  if (pin < 4) {
    Serial.println("Pin was less than 4!");
    myPins[pin] = value;
  }
  else {
    Serial.print("Pin was: ");
    Serial.print(pin);
    Serial.print("\n");
  }
}

void loop() {
  tick++;
  Serial.println(tick);
  fetch_string();
  strcpy (inString, "000000");
  for (int p = 0; p<4; p++) {
    if (tick%myPins[p] == 0) {
      Serial.print("Spinning! ");
      Serial.print(p);
      Serial.print("\n");
      Serial.println(tick%myPins[p]);
      digitalWrite(p+1,1);
      }  
     else {
      Serial.print("Not spinning! ");
      Serial.print(p);
      Serial.print("\n");
      digitalWrite(p+1,0);
    }
  }
  delay(10);
  if (tick == 100) {
    tick = 1;
  }
}
