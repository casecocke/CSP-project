class ShooterEnemy {
  //shooter variables
  //green circle
  float xpos, ypos, zpos;
  PVector location;
  PVector velocity;
  float ElocX, ElocY, ElocZ;
  float hx1, hx2, hz1, hz2, hy1, hy2;
  float size;
  float health;
  float hb;
  boolean dead = false;
  EnemyProjectile[] projectiles = new EnemyProjectile[2000];
  float timer = 0;
  float PlocX, PlocZ;
  float differenceX, differenceZ;

  ShooterEnemy(float camX, float camZ, float camY) {
    //Ploc = player location
    this.PlocX = camX;
    this.PlocZ = camZ;
    this.ypos = camY;
    xpos = 100;
    zpos = 0;
    health = 0;
    hb = 100;
    size = 30;
    location = new PVector (1*width, 1*height);
  }

  void update(float camX, float camZ) {
    differenceX = camX-xpos;
    differenceZ = camZ-zpos;
    xpos = location.x;
    zpos = location.y;
  }
  void hit(float Bxpos, float Bypos, float Bzpos) {
    this.ElocX = Bxpos;
    this.ElocY = Bypos;
    this.ElocZ = Bzpos;
    hx1 = ElocX + hb;
    hx2 = ElocX - hb;
    hy1 = ElocY + hb;
    hy2 = ElocY - hb;
    hz1 = ElocZ + hb;
    hz2 = ElocZ - hb;
    if (hx1 >= xpos && xpos >= hx2 && hz1 >= zpos && zpos >= hz2 && hy1 >= ypos && ypos >= hy2) {
      size+=10;
      health++;
      if (health >= 4) {
        dead = true;
      }
    }
  }
  void follow() {

    velocity = new PVector (differenceX/300, differenceZ/300);
    location.add(velocity);


    println(-location.y + " locZ ", camZ + " camZ ", location.x + " locX ", camX + "camX");
  }
  void job() {
    //every 1.6 seconds a new bullet should come out
    timer++;
    if (timer > 100) {
      timer = 0;
      shoot();
      for (int z = 0; z < projectiles.length; z++) {
        projectiles[z].follow();
      }
    }
  }
  void shoot() {
    //calling the projectile
    projectiles = new EnemyProjectile[1];
    for (int i = 0; i < projectiles.length; i++) {
      projectiles[i] = new EnemyProjectile(xpos, zpos, camX, camY, camZ);
    }
  }
  void make() {
    //making the shooter enemy
    pushMatrix();
    noStroke();
    fill(50, 170, 80);
    translate(location.x, ypos, -location.y);
    sphere(size);
    popMatrix();
  }
}
