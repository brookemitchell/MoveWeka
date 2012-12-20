class DisplayDraw {

  DisplayDraw() {
  } 

  void drawBackgrounds()
  {


    background(0);  
    stroke(160, 160, 160);
    fill(46);

    rect(0, 0, WIDTH, sensorRowHeight);
    fill(96);

    rect(0, sensorRowHeight, WIDTH, sensorRowHeight);
    rect(0, sensorRowHeight*2, WIDTH, sensorRowHeight);
    fill(255);

    text("Controller 1::::", 50, 220);
    text("Controller 2::::", 50, 420);


}
}

