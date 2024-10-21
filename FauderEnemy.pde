// original enemy: blue squares
class FauderEnemy {
  //fauder enemy variables
  float xpos, ypos, zpos;
  PVector location;
  PVector velocity;
  float PlocX, PlocZ;
  float ElocX, ElocY, ElocZ;
  float hx1, hx2, hz1, hz2, hy1, hy2;
  float size;
  float health;
  float hb;
  float differenceX, differenceZ;
  boolean dead = false;

  FauderEnemy(float camX, float camZ, float camY) {
    //Ploc = player location (camera location)
    this.PlocX = camX;
    this.PlocZ = camZ;
    this.ypos = camY;
    xpos = random(100);
    health = 0;
    zpos = random(100);
    hb = 100;
    size = 30;
    location = new PVector (1*width, 1*height);
  }

  void update(float camX, float camZ) {
    //using differences to find the correct angle
    differenceX = camX-xpos;
    differenceZ = camZ-zpos;
    //PVector for smoothness
    xpos = location.x;
    zpos = location.y;
  }
  void hit(float Bxpos, float Bypos, float Bzpos) {
    //this is for if it gets hit by a bullet
    this.ElocX = Bxpos;
    this.ElocY = Bypos;
    this.ElocZ = Bzpos;
    hx1 = ElocX + hb;
    hx2 = ElocX - hb;
    hy1 = ElocY + hb;
    hy2 = ElocY - hb;
    hz1 = ElocZ + hb;
    hz2 = ElocZ - hb;
    //the bullet location has to fit all of these parameters for this to run
    if (hx1 >= xpos && xpos >= hx2 && hz1 >= zpos && zpos >= hz2 && hy1 >= ypos && ypos >= hy2) {
      size+=10;
      health++;
      //bullet delete if it hits something
      for ( Bullet work : bullets) {
        work.die();
        if (health >= 4) {
          //will delete if hit enough
          dead = true;
        }
      }
    }
  }
  void follow() {
    //how the enemy follows the player
    //velocity is how it actually moves
    velocity = new PVector (differenceX/100, differenceZ/100);
    location.add(velocity);
  }
  void make() {
    pushMatrix();
    fill(0, 0, 255);
    translate(location.x, -ypos, -location.y);
    box(size);
    popMatrix();
  }
}
