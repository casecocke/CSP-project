class Bullet {
  //bullet variables
  float Bxpos, Bypos, Bzpos;
  float incX, incY, incZ;
  float hx1, hx2, hz1, hz2;
  float timer;
  float size;
  boolean Bdead = false;
  float ElocX, ElocZ;
  //FauderEnemy f = new FauderEnemy(camX, camY, camZ);
  Bullet(float camX, float camY, float camZ) {
    this.Bypos = camY;
    size = 30;
    this.Bxpos = camX;
    this.Bzpos = camZ;
    timer = 0;
    incX = (sin(radians(mouseY/sensitivity))*cos(radians(-mouseX/sensitivity)))/2;
    incY = cos(mouseY/(sensitivity*20));
    incZ = (sin(radians(mouseY/sensitivity))*sin(radians(-mouseX/sensitivity)))/2;
  }

  void doyourjob() {
    //this is how the bullet moves
    Bzpos+=incZ*300;
    Bxpos+=incX*300;
    Bypos+=incY*300;
  }

  void render() {
    //the bullet appears
    pushMatrix();
    fill(200, 200, 0);
    noStroke();
    translate(Bxpos, -Bypos, -Bzpos);
    sphere(4);
    popMatrix();
  }
  void hit(ArrayList<FauderEnemy> fauders, ArrayList<SummonerEnemy> summoners, ArrayList<ShooterEnemy> shooters, ArrayList<TankEnemy> tanks) {
    //these signal if a bullet has hit an enemy
    for ( FauderEnemy work : fauders) {
      work.hit(Bxpos, Bypos, Bzpos);
    }
    for ( SummonerEnemy work : summoners) {
      work.hit(Bxpos, Bypos, Bzpos);
    }
    for (ShooterEnemy work : shooters) {
      work.hit(Bxpos, Bypos, Bzpos);
    }
    for (TankEnemy work : tanks) {
      work.hit(Bxpos, Bypos, Bzpos);
    }
  }
  void die() {
    //bullet delete if it hits something
    Bdead = true;
  }
}
