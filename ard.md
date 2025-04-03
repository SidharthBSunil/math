#define MQ135_PIN A0   // MQ-135 analog output pin
#define BUZZER_PIN 13  // Buzzer pin
#define THRESHOLD 130  // Adjust based on your environment

void setup() {
    pinMode(BUZZER_PIN, OUTPUT);
    pinMode(MQ135_PIN, INPUT);
    Serial.begin(9600);
}

void loop() {
    int air_quality = analogRead(MQ135_PIN);  // Read MQ-135 sensor value
    Serial.print("Air Quality: ");
    Serial.println(air_quality);

    if (air_quality > THRESHOLD) {
        digitalWrite(BUZZER_PIN, HIGH);  // Turn buzzer ON
        Serial.println("Unhealthy Air! Buzzer ON.");
    } else {
        digitalWrite(BUZZER_PIN, LOW);   // Turn buzzer OFF
    }

    delay(1000);  // Wait 1 second
}