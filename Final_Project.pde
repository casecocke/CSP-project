//terrain
Terrain T = new Terrain();
// camera place
float camX;
float  camY;
float camZ;
// camera center
float degreeofX;
float degreeofZ;
float degreeofY;
//movement
float sensitivity;
float speed, sprint;
//keys
boolean Wpressed = false;
boolean Spressed = false;
boolean Apressed = false;
boolean Dpressed = false;
boolean Spacepressed = false;
boolean SHIFTpressed = false;
boolean CNTRLpressed = false;
//classes
ArrayList<FauderEnemy> fauders = new ArrayList<FauderEnemy>();
ArrayList<ShooterEnemy> shooters = new ArrayList<ShooterEnemy>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<SummonerEnemy> summoners = new ArrayList<SummonerEnemy>();
ArrayList<TankEnemy> tanks = new ArrayList<TankEnemy>();
float size;
float Bxpos, Bypos, Bzpos;
void setup() {
  //size(1000, 800, P3D);
  fullScreen(P3D);
  noStroke();
  //variable setup
  sensitivity = 5.0;
  speed = 8;
  sprint = speed;
  camX = 1*width/2;
  camZ = -1*height/2;
  camY = noise(camX, camZ)+80;
  // add enemies
  for (int i = 0; i < 1; i++) {
    fauders.add(new FauderEnemy(camX, camY, camZ));
  }
  for (int i = 0; i < 1; i++) {
    shooters.add(new ShooterEnemy(camX, camY, camZ));
  }
  for (int i = 0; i < 20; i++) {
    summoners.add(new SummonerEnemy(camX, camY, camZ));
  }
  for (int i = 0; i < 1; i++) {
    tanks.add(new TankEnemy(camX, camY, camZ));
  }
}

void draw() {
  clear();
  background(220);



  fill(255, 255, 255);

  //camera sphere
  degreeofX = (sin(radians(mouseY/sensitivity))*cos(radians(-mouseX/sensitivity)))/2;
  degreeofZ = (sin(radians(mouseY/sensitivity))*sin(radians(-mouseX/sensitivity)))/2;
  degreeofY = cos(-mouseY/(sensitivity*20));
  camera(camX, camY, camZ, ((degreeofX)+camX), degreeofY+camY, (degreeofZ)+camZ, 0.0, -1.0, 0.0);
  rotateX(PI);
  //crosshair
  pushMatrix();
  translate((sin(radians(mouseY/sensitivity))*cos(radians(-mouseX/sensitivity)))/2*1000+camX, -cos(mouseY/(sensitivity*20))*1000-camY, -(sin(radians(mouseY/sensitivity))*sin(radians(-mouseX/sensitivity)))/2*1000-camZ);
  sphere(3);
  popMatrix();

  //class runs
  pushMatrix();
  fill(200, 150, 150);
  T.createterrain();
  popMatrix();
  //Fauder commands
  for (int i = 0; i < fauders.size(); i++) {
    FauderEnemy work = fauders.get(i);
    work.update(camX, camZ);
    work.follow();
    work.make();
    if ( work.dead == true) {
      fauders.remove(i);
    }
  }
  //Shooter commands
  for ( int i = 0; i < shooters.size(); i++) {
    ShooterEnemy work = shooters.get(i);
    work.update(camX, camZ);
    work.follow();
    work.job();
    work.make();
    if (work.dead == true) {
      shooters.remove(i);
    }
  }
  //summoner commands
  for ( SummonerEnemy work : summoners) {
    work.update(camX, camZ);
    work.follow();
    work.summon(tanks, fauders);
    work.make();
  }
  //tank commands
  for (int i = 0; i < tanks.size(); i++) {
    TankEnemy work = tanks.get(i);
    work.update(camX, camZ);
    work.follow();
    work.make();
    if ( work.dead == true) {
      tanks.remove(i);
    }
  }
  //bullet commands
  for ( int i = 0; i < bullets.size(); i++) {
    Bullet work = bullets.get(i);
    work.doyourjob();
    work.render();
    work.hit(fauders, summoners, shooters, tanks);
    if (work.Bdead == true) {
      bullets.remove(i);
    }
  }

  //movement commands
  if (Spacepressed) {
    camY+=3;
  }
  if (SHIFTpressed) {
    camY-=3;
  }
  if (Wpressed) {
    camZ+=sin(radians(-mouseX/sensitivity))*sprint;
    camX+=cos(radians(-mouseX/sensitivity))*sprint;
  }

  if (Spressed) {
    camZ-=sin(radians(-mouseX/sensitivity))*sprint;
    camX-=cos(radians(-mouseX/sensitivity))*sprint;
  }

  if (Apressed) {
    camZ+=sin(radians(90+(-mouseX/sensitivity)))*sprint;
    camX+=cos(radians(90+(-mouseX/sensitivity)))*sprint;
  }

  if (Dpressed) {
    camZ-=sin(radians(90+(-mouseX/sensitivity)))*sprint;
    camX-=cos(radians(90+(-mouseX/sensitivity)))*sprint;
  }
  //println(camY);
  axis();
}

void keyPressed() {
  if (keyCode == SHIFT) {
    SHIFTpressed = true;
  } else if (keyCode == 'W') {
    Wpressed = true;
  } else if (keyCode == 'S') {
    Spressed = true;
  } else if (keyCode == 'A') {
    Apressed = true;
  } else if (keyCode == 'D') {
    Dpressed = true;
  } else if (keyCode == ' ') {
    Spacepressed = true;
    //sprint key on
  } else if (keyCode == CONTROL) {
    sprint = speed*4;
  }
}

void keyReleased() {
  if (keyCode == SHIFT) {
    SHIFTpressed = false;
  } else if (keyCode == 'W') {
    Wpressed = false;
  } else if (keyCode == 'S') {
    Spressed = false;
  } else if (keyCode == 'A') {
    Apressed = false;
  } else if (keyCode == 'D') {
    Dpressed = false;
  } else if (keyCode == ' ') {
    Spacepressed = false;
    //sprint key off
  } else if (keyCode == CONTROL) {
    sprint = speed;
  }
}
void mousePressed() {
  if (mouseButton == LEFT) {
    bullets.add(new Bullet(camX, camY, camZ));
  }
  if (mouseButton == RIGHT) {
    fauders.remove(new FauderEnemy(camX, camY, camZ));
  }
}

void axis() {
  stroke(0);
  strokeWeight(1);
}




class Terrain {
  //terrain variables
  float sizenoise;
  float scalenoise;
  int z;
  int x;
  float camX;
  float camY;
  float camZ;

  Terrain() {
    //terrain size and scale
    sizenoise = 800;
    scalenoise = 3000;
  }
  void createterrain() {
    beginShape(TRIANGLES);
    for (float x = -10000; x < 20*width; x+=sizenoise) {
      for (float y = -10000; y < 20*height; y+=sizenoise) {
        //color
        fill(noise(x, y)*200, noise(x, y)*200, noise(x, y)*200);
        //triangles
        vertex(x, scalenoise*noise(x, y), y);
        vertex(x, scalenoise*noise(x, y+sizenoise), y+sizenoise);
        vertex(x+sizenoise, scalenoise*noise(x+sizenoise, y), y);
        vertex(x, scalenoise*noise(x, y+sizenoise), y+sizenoise);
        vertex(x+sizenoise, scalenoise*noise(x+sizenoise, y+sizenoise), y+sizenoise);
        vertex(x+sizenoise, scalenoise*noise(x+sizenoise, y), y);
      }
    }
    endShape();
  }
}
