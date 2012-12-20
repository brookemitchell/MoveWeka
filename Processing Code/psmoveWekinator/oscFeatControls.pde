class OscFeatControls {

  void sendNames() {
    OscMessage myMessage = new OscMessage("/oscCustomFeaturesNames");
    myMessage.add("1SimpleIMUX");   
    myMessage.add("1SimpleIMUY");   
    myMessage.add("1SimpleIMUZ");  
        myMessage.add("2SimpleIMUX");   
    myMessage.add("2SimpleIMUY");   
    myMessage.add("3SimpleIMUZ");  


    oscP5.send(myMessage, wekaOSCFeatExtract);
  }

  void oscSend(float[] features) {
    OscMessage myMessage = new OscMessage("/oscCustomFeatures");
    for (int i = 0; i< features.length; i++) {
      myMessage.add(features[i]);
    }
    oscP5.send(myMessage, wekaOSCFeatExtract);
  }
}

class OscMessages {

          OscBundle myBundle = new OscBundle();

  void oscSend(NetAddress Address, String message, int i) {
        
    OscMessage newMessage = new OscMessage(message);

   // newMessage.add(command);   
    newMessage.add(i);  


// newMessage.setTimetag(newMessage.now());

  oscP5.send(newMessage, Address);
  }


  void oscSend1(NetAddress Address, String message, String args, int i) {


    OscMessage newMessage = new OscMessage(message);
    newMessage.add(args);  
    newMessage.add(i);  


    //  newMessage.add(o); 
    //  newMessage.add(i);  
    oscP5.send(newMessage, Address);
  }
}

