//would come out of the shooter enemy
class EnemyProjectile {
  float xpos, ypos, zpos;
  PVector location;
  PVector velocity;
  float PlocX, PlocZ;
  float differenceX, differenceZ;

  EnemyProjectile(float camX, float camZ, float camY, float xpos, float zpos) {
    this.PlocX = camX;
    this.PlocZ = camZ;
    this.ypos = camY;
    this.xpos = xpos;
    this.zpos = zpos;
    location = new PVector (xpos, zpos);
    //reverse from bullet
    differenceX = camX-xpos;
    differenceZ = camZ-zpos;
    xpos = location.x;
    zpos = location.y;
  }
  void follow() {
    //follow player
    velocity = new PVector (differenceX/100, differenceZ/100);
    location.add(velocity);
  }
  void make() {
    pushMatrix();
    fill(255, 0, 0);
    translate(location.x, ypos, -location.y);
    sphere(30);
    popMatrix();
  }
}
