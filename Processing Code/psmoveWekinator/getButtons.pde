class PsButtons {

  int trigLastState;
  int trigCounter;
  boolean wasT1 = false;
  boolean wasT4 = false;

  boolean restart;
  int toggleSwitch = 0;


  PsButtons() {
  }

  int checkButtons() {
    //Trigger Setup
    int trigger1 = move1.get_trigger();
    int trigger2 = move2.get_trigger();

    if (trigger1 != 0 || trigger2 != 0) {
      cp5.controller("toggle2").setValue(1);
      trigLastState = 1;
    }

    else if (trigger1 == 0 & trigLastState == 1 || trigger2 == 0 & trigLastState == 1) {
      //    delay(90);
      cp5.controller("toggle2").setValue(0);

      move1.set_rumble(255);
      move2.set_rumble(255);
      trigLastState = 0;
      trigCounter++;
      //    println(trigCounter);
    }

    else { 
      move1.set_rumble(0);
      move2.set_rumble(0);
      //   println("stopped");
    }





    // !!! //
    //Buttons Setup

    int buttons1 = move1.get_buttons();
    int buttons2 = move2.get_buttons();

    //   println(buttons);


    //Move Button > Listen WAVEY 1
    if (buttons1 == 524288 & wasT1 == false || buttons2 == 524288 & wasT1 == false) {
            delay(25);

      cp5.controller("toggle1").setValue(1);
      wasT1 = true;
                       delay(25);

    }
    else if (buttons1 != 524288 & wasT1 == true || buttons2 != 524288 & wasT1 == true) {  
                 delay(25);

      cp5.controller("toggle1").setValue(0);
      wasT1 = false;
                       delay(25);


    }

    //Triangle > Train Toggle 3  
    if (buttons1 == 16 || buttons2 == 16) {     
      cp5.controller("bang3").setValue(1);
              cp5.controller("toggle4").setValue(0);

      trigCounter++;
    }


    if (buttons1 == 128 || buttons2 == 128) {
      // delay(50);

      //    println(toggleSwitch);

      switch(toggleSwitch) {
      case 0:
        cp5.controller("toggle4").setValue(1);
        cp5.controller("bang3").setValue(0);
        toggleSwitch = 1;

        delay(250);

        break;

      case 1:
        cp5.controller("toggle4").setValue(0);
        toggleSwitch = 0;

        delay(250);

        break;
      }
    }




    return 0;
  }
}

