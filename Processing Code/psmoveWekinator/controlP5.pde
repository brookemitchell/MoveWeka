class GuiToggles {

  boolean toggleValue = false;

  color bground = #4C7893;
  color fground = #1655A5;
  color active = #113F79;


  GuiToggles(String tog1Label, String tog2Label, String bang3Label, String tog4Label) {

    cp5.addToggle("toggle1")
      .setColorBackground(bground)
        .setColorForeground(fground)
          .setColorActive(#EA4747)
            .setPosition(10, 620)
              .setSize(50, 40)
                .setLabel(tog1Label)
                  ;

    cp5.addToggle("toggle2")
      .setPosition(70, 620)
        .setSize(50, 40)
          .setColorBackground(bground)
            .setColorForeground(fground)
              .setColorActive(#EA4747)
                .setLabel(tog2Label)
                  ;

    cp5.addToggle("bang3")
      .setPosition(130, 620)
        .setSize(50, 40)
          .setLabel(bang3Label)
            .setColorBackground(bground)
              .setColorForeground(fground)
                .setColorActive(#EA4747)
                  ;

    cp5.addToggle("toggle4")
      .setPosition(190, 620)
        .setSize(50, 40)
          .setLabel(tog4Label)
            .setColorBackground(bground)
              .setColorForeground(fground)
                .setColorActive(#EA4747)
                  ;
  }
}
int i = 0;

void toggle1(boolean theFlag) {
  if (theFlag==true) {

    //   msg.oscSend1(chuckControl, "/control", "startSound", 1);
    msg.oscSend(maxPatch , "/preset", i);
        msg.oscSend(maxPatch , "/OSCSynth/startSendingParams", 1);

  //  println(i);
    i = (i+ 1) % 7;
    delay(150);
  } 
  
  else {
    //   msg.oscSend1(chuckControl,  "/control", "stopSound", 0);
  //  msg.oscSend(wekaOSCFeatExtract, "/control/OSCplayscore", 0);
  }
}
void toggle2(boolean theFlag) {
  if (theFlag==true) {

    msg.oscSend(wekaOSCFeatExtract, "/control/OSCrecord", 1);
    // "extract");
  } 
  else {
    msg.oscSend(wekaOSCFeatExtract, "/control/OSCrecord", 0);
  }
}

void bang3(boolean theFlag) {
  if (theFlag==true) {
        msg.oscSend(maxPatch , "/OSCSynth/startSendingParams", 0);
    msg.oscSend(wekaOSCFeatExtract, "/control/OSCtrain", 1);
  } 
  else {
  }
}

void toggle4(boolean theFlag) {
  if (theFlag==true) {
    msg.oscSend(wekaOSCFeatExtract, "/control/OSCstartrun", 1);
  } 
  else {
    msg.oscSend(wekaOSCFeatExtract, "/control/OSCstartrun", 0);
  }
}

