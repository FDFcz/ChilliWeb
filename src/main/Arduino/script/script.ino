#include <Ethernet.h>
#include <EthernetUdp.h>
#include <CO2Sensor.h>
//TaskHandle_t measurementTask; TaskHandle_t controlTask;

//Seting ethernet interface_____________________________________
byte mac[] = {0xDE, 0xAD, 0xBE, 0xEF, 0xFE, 0xED};
IPAddress ip(192, 168, 10, 10);
unsigned int portForParameters = 8888;      // local port to listen on
unsigned int portForDiagnostic = 8889; 
//______________________________________________________________


//UDP__________________________________________________________________________
// buffers for receiving and sending data
char packetBuffer[UDP_TX_PACKET_MAX_SIZE];  // buffer to hold incoming packet,
char ReplyBuffer[] = "acknowledged";        // a string to send back
EthernetUDP UdpForParameters, UdpForDiagnostic; // An EthernetUDP instance to let us send and receive packets over UDP
//____________________________________________________________________


//inputs_____________________________________________________________
  const int ANALOG_INPUTS[] {A0,A1,A2,A3};
  const int DIGITAL_INPUTS[] {A4,A5,A6,A7};

//Ouputs____________________________________________________________
 // Define an array to hold the pin numbers for Opta's user LEDs.
 bool outputsValues[] = {false,false,false,false};
 const int USER_LEDS[] = {LED_D0, LED_D1, LED_D2, LED_D3};
 const int relayOutputs[] = {D0, D1, D2, D3};
 const int NUM_LEDS = 4; // Number of Opta's user LEDs
 //_________________________________________________________________

 //static__________________________________________________________
 byte data =0;
 int setHumidityPersent =0;
 float setTemperature=0;
 bool setLight = false;

 int actualHumidityPersents;
 float actulaTemperature;
 bool actualLight;

 int ActualCO2=-1;
  CO2Sensor co2Sensor(A2, 0.99, 100);

//_______________________SETUP_________________________________________________
 void setup()
  {
  Ethernet.begin(mac, ip);   // start the Ethernet
  UdpForParameters.begin(portForParameters);   // start UDP
  UdpForDiagnostic.begin(portForDiagnostic); 
 
  analogReadResolution(12);//analog input resolution confiq 12=4095


  for (int i = 0; i < NUM_LEDS; i++) //mapping ouputs
   {
    pinMode(USER_LEDS[i], OUTPUT);
    pinMode(relayOutputs[i], OUTPUT);
   } 
   //xTaskCreate(measurement, "Task2", 100, NULL, 1, &measurementTask);  
   //xTaskCreate(control, "Task3", 120, NULL, 3, &controlTask);
   co2Sensor.calibrate();
 }
 //*************************************************************************************

   void loop() //loop For communication
  {
    measure();
    checkUdpReceve();
    control();
    delay(100);
  }


 void checkUdpReceve() //store incoming data if avelible
{
 int packetSize = UdpForParameters.parsePacket();
  if (packetSize)
  {
    IPAddress remote = UdpForParameters.remoteIP();
    UdpForParameters.read(packetBuffer, UDP_TX_PACKET_MAX_SIZE);

    setTemperature = packetBuffer[0];
    setHumidityPersent = packetBuffer[1];
    setLight = packetBuffer[2];

    byte replyData[] = {0,0,0,0};
    replyData[0] = actulaTemperature;
    replyData[1] = actualHumidityPersents;
    replyData[2] = setLight;
    // send a reply to the IP address and port that sent us the packet we received
    UdpForParameters.beginPacket(remote, UdpForParameters.remotePort());
    UdpForParameters.write(replyData[0]);
    UdpForParameters.write(replyData[1]);
    UdpForParameters.write(replyData[2]);
    //UdpForParameters.write(replyData[3]);
    UdpForParameters.endPacket();
  }
}
void measure()
{

  
    int humidityInput = analogRead(A1)-1230;//-1230 3v
    if(humidityInput<0)actualHumidityPersents=0;
    else actualHumidityPersents =100- ((100*humidityInput)/2470);

    int tempInput = analogRead(A0); //-40°C ,190°C = 0-4095, 0°C = 712
    actulaTemperature = ((tempInput/409.5)*19.0)-35.0; //(hodnota/hodnota_1v)*10% => procento na vstupu,(procento na vstupu*1%z190°C) -40°c
  
    ActualCO2 = co2Sensor.read();
    

}
void control()
{
  //temperature---------------
  if(actulaTemperature<setTemperature-1) outputsValues[0] = true;
  else if(actulaTemperature>setTemperature) outputsValues[0] = false;

  //light---------
  outputsValues[1] = setLight;
  
  //humidity-----------
  if(actualHumidityPersents<setHumidityPersent && actualHumidityPersents>0) outputsValues[2] = true;
  else outputsValues[2] = false;

  //Fan--------------
  if (ActualCO2 > 1000 || ActualCO2 < 100) outputsValues[4] = false;
  else outputsValues[4] = false;

  
  for(int i = 0;i<NUM_LEDS;i++)//--------set reles and leds
  {
    digitalWrite(relayOutputs[i],outputsValues[i]);
    digitalWrite(USER_LEDS[i], outputsValues[i]);
  }
}






