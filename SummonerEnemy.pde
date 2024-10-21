//summoner enemy can't die
//red square; always spawns new blue squares for more enemies for the player
class SummonerEnemy {
  float xpos, ypos, zpos;
  PVector location;
  PVector velocity;
  float PlocX, PlocZ;
  float differenceX, differenceZ;
  float ElocX, ElocY, ElocZ;
  float hx1, hx2, hz1, hz2, hy1, hy2;
  float clock;
  float hb;
  float sumchance;
  float size;
  float whichenemy;
  SummonerEnemy(float camX, float camZ, float camY) {
    //Ploc is player location
    this.PlocX = camX;
    this.PlocZ = camZ;
    this.ypos = camY;
    xpos = random(100);
    hb = 100;
    size = 50;
    zpos = 0;
    clock = 0;
    location = new PVector (1*width, -1*height);
  }

  void update(float camX, float camZ) {
    //how it tracks the player
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
    }
  }
  void follow() {

    velocity = new PVector (differenceX/600, differenceZ/600);
    location.add(velocity);


    //println(-location.y + " locZ ", camZ + " camZ ", location.x + " locX ", camX + "camX");
  }
  void make() {
    pushMatrix();
    fill(255, 0, 0);
    translate(location.x, ypos, -location.y);
    box(size);
    popMatrix();
  }
  void summon(ArrayList<TankEnemy> tanks, ArrayList<FauderEnemy> fauders) {
    //this is how it spawns enemies
    //every 1.5 seconds, has a 10% chance of spawning a new enemy
    clock++;
    sumchance = random(0, 100);
    if (clock > 90) {
      if (sumchance > 90) {
        whichenemy = floor(random(1, 3.5));
        // choice between two types of enemies
        if (whichenemy == 1) {
          for (int i = 0; i<2; i++) {
            fauders.add(new FauderEnemy(camX, camZ, camY));
          }
          for (int i = 0; i<1; i++) {
            tanks.add(new TankEnemy(camX, camZ, camY));
          }
        }
        if (whichenemy == 2) {
          for (int i = 0; i<1; i++) {
            fauders.add(new FauderEnemy(camX, camZ, camY));
          }
          for (int i = 0; i<2; i++) {
            tanks.add(new TankEnemy(camX, camZ, camY));
          }
        }
        if (whichenemy == 1) {
          for (int i = 0; i<1; i++) {
            fauders.add(new FauderEnemy(camX, camZ, camY));
          }
          for (int i = 0; i<1; i++) {
            tanks.add(new TankEnemy(camX, camZ, camY));
          }
        }
        sumchance = 0;
      }
      clock = 0;
    }
    println(whichenemy);
  }
}
