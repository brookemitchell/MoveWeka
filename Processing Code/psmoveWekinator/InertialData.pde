class UpdateIMU {

    SimpleIMUFilter imuFilter;
  
  int x=0, oldX=0;

  int oldAX_y=100, oldAY_y=100, oldAZ_y=100;
  int oldGX_y=300, oldGY_y=300, oldGZ_y=300; 
  int oldMX_y=500, oldMY_y=500, oldMZ_y=500;


  float RawAccelX=0, RawAccelY=0, RawAccelZ=0;
  float AccelX=0, AccelY=0, AccelZ=0;
  float RawGyroX=0, RawGyroY=0, RawGyroZ=0;
  float GyroX=0, GyroY=0, GyroZ=0;
  float FilteredAccelX=0, FilteredAccelY=0, FilteredAccelZ=0;
  float RawMagX=0, RawMagY=0, RawMagZ=0;

  long lastTime;
  long interval = 5;

  // Constant for converting raw accelerometer values to 9.8m/s^2, i.e. rawAccel/gConst=accel (in G's)
  float gConst = 4326f; 

  // Constant for converting raw gyro values to radians/s, i.e. rawGyro/rConst=gyro (in rad/s)
  float rConst = 7509.8f;

  void setupInertialData()
  {
    imuFilter = new SimpleIMUFilter();
    lastTime = System.currentTimeMillis();
  }

  float[] udpateInertialData(PSMove move)
  {
    float[] imuVals = new float [3];
    long now = System.currentTimeMillis();
    float dt = (float)(now - lastTime);


    lastTime = now;

    // Move inertial data cursor forward
    oldX = x;  
    x += 5;

    if (x >= WIDTH) 
    {
      x = 0;
      oldX = 0;
      disp.drawBackgrounds();
    }  

    RawAccelX = move.getAx();
    RawAccelY = move.getAy();
    RawAccelZ = move.getAz();

    RawGyroX = move.getGx();
    RawGyroY = move.getGy();
    RawGyroZ = move.getGz();

    RawMagX =  move.getMx();
    RawMagY =  move.getMy();
    RawMagZ =  move.getMz();

    AccelX = RawAccelX/gConst;
    AccelY = RawAccelY/gConst;
    AccelZ = RawAccelZ/gConst;

    GyroX = RawGyroX/rConst;
    GyroY = RawGyroY/rConst;
    GyroZ = RawGyroZ/rConst;

    imuFilter.UpdateIMU(GyroX, GyroY, GyroZ, AccelX, AccelY, AccelZ, dt);

    imuVals[0] = imuFilter.RwEstx;
    imuVals[1]  = imuFilter.RwEsty;
    imuVals[2]  = imuFilter.RwEstz;
    
 // drawInertialData(imuVals);
 
return imuVals;
  }


  void drawInertialData(float [] xyz, int i)
  {
   
    //  stroke(255,0,0); // Red
    stroke(255, 255, 0); // Red
    int MX_y = (int)map(xyz[0], -6f, 6f, 200+ i, 399+ i);
    line(oldX, oldMX_y, x, MX_y);
    oldMX_y = MX_y;

    //  stroke(0,255,0); // Green
    stroke(255, 0, 255); // Green
    int MY_y = (int)map(xyz[1], -6f, 6f, 200+ i, 399 + i);
    line(oldX, oldMY_y, x, MY_y);
    oldMY_y = MY_y;

    //  stroke(0,16,255); // Blue
    stroke(0, 255, 128); // Blue
    int MZ_y = (int)map(xyz[2], -6f, 6f, (200+ i), 399 + i);
    line(oldX, oldMZ_y, x, MZ_y);
    oldMZ_y = MZ_y;
    
    
    
  
}
}
