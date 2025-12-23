class Player {
  PVector position;
  int size;
  int lives;
  int score;
  int highScore;
  
  Player(PVector position, int size, int lives) {
    this.position = position;
    this.size = size;
    this.lives = lives;
  }
  
  void display() {
    fill(10,255,0);
    square(int(position.x - (size/2)), int(position.y - (size/2)), size);//will be changed later
    rect(int(position.x - (1.5 * size/2)), int(position.y), 1.5*size, size/2);
  }
  
  void getHit() {
    fill(30,255,0);
    delay(1);
    fill(10,255,0);
  }
    
}
  

class Projectile {
  int xpos, ypos;
  int origin;
  int yVelocity;
  int type;
  int w, h;
  //for player, ellipse of width 4, height 25 
  boolean onScreen;
  Projectile(int origin, int type) {
    this.origin = origin;
    this.type = type;
  }
  void fire(int xpos, int ypos) {
    this.xpos = xpos;
    this.ypos = ypos;
    this.onScreen = true;
  }
  void display() {
    fill(255);
    if (onScreen) {
      if (type == LASER) {
        if (origin == playerProjectile) {
          this.w = 2;
          this.h = 25;
          ellipse(xpos, ypos, w, h);
        }
        else {
          this.w = 4;
          this.h = 4;
          ellipse(xpos, ypos, w, h);
        } 
      }
    }
  }
  
  void move() {
    if (origin == playerProjectile) {
      yVelocity = -20;
    }
    if (origin == enemyProjectile) {
      yVelocity = 7;
    }
    ypos += yVelocity;  
    
    if ((ypos < 0) || (ypos > height)) {
      onScreen = false;
    }
  }
  
  boolean playerCollisionCheck(Player p) { //needs to be run by each projectile of the 3 shooter enemies
    return ((dist(p.position.x, p.position.y, this.xpos, this.ypos + this.h/2) <= p.size) && (this.origin == enemyProjectile));
  }
  
  
}

class Enemy {
  PVector position; //assigned
  int variant; //assigned
  Projectile enemyBullet = new Projectile(enemyProjectile, LASER);
  Projectile[] bossBeams = new Projectile[10];
  int bossHealth = 50;
  float speed;
  boolean isAlive;
  
  int rank;
  int hitsTaken;
  
  boolean isBoss;
  
  Enemy(PVector position, boolean isBoss) {
    this.position = position;
    this.variant = variant;
    this.isAlive = true;
    
    this.isBoss = isBoss;
    
    if (isBoss) {
      this.speed = bossSpeed;
      this.bossHealth = 50;
      for (int b = 0; b < bossBeams.length; b++) {
        bossBeams[b] = new Projectile(enemyProjectile, BEAM);
      }
      
    }
    else {
      this.speed = alienSpeed;
    }
    
  }
  
  void display() {
    if (isAlive) {
      if (rank == 0) {
        fill(255);
      }
      if (rank == 1) {
        fill(10,255,0);
      }
      if (rank == 2) {
        fill(0,0,255);
      }
      if (rank == 3) {
        fill(255,127,0);
      }
    }
    else {
      fill(0);
    }
    if (!isBoss) {
      circle(position.x, position.y, alienSize);
    }
    else {
      circle(position.x, position.y, bossSize);
    }
    
    
  }
  
  void move() {
    position.x += speed;
  }
  
  void enemyShoot() {
    if (!isBoss) {
      this.enemyBullet.fire(int(position.x), int(position.y));
    }
    else {
      this.enemyBullet.fire(int(position.x), int(position.y));
      this.enemyBullet.fire(int(position.x), int(position.y));
    }
    
  }
  
  boolean enemyCollision(Projectile p) { 
    return ((dist(this.position.x, this.position.y, p.xpos, p.ypos - p.h/2) <= alienSize/2) && (p.origin == playerProjectile));
  }
  
}
