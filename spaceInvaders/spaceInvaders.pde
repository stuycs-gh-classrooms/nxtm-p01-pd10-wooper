PVector playerInitPos;
Player ship;//believe in ship, because ship believes in you
boolean west, east; //test to see which directions are being inputted

int cooldown = 30;
int cooldownTime = 0;


int enemyShootCooldown = 60;
int enemyShootTimer = 0;

//phases:
int stage1 = 1;
int stage2 = 2;
int winScreen = 3; //win screen score summary

int pauseScreen = 10;
int gameOver = 20;

boolean game;

int phase;

int paused = 0;

Projectile[] playerBullets = new Projectile[100];

//grid for the first horde, and then the second horde, which has a boss
Enemy[][] firstHorde = new Enemy[5][9];
Enemy[][] bossHorde = new Enemy[5][9];

PVector initFirstHordePos, initBossHordePos, initBossPos;
PVector newFirstHordePos;
int spacing = 100;
int alienSize = 30;
int bossSize = 100;
float alienSpeed = 0.75;
float bossSpeed = 0.5;

//decides direction of projectile
int playerProjectile = 0;
int enemyProjectile = 1;

//projectile types
int LASER = 0;
int BEAM = 1;

void setup() {
  size(600, 800);
  frameRate(60);
  playerInitPos = new PVector(width/2, int(height * 0.87));
  ship = new Player(playerInitPos, 30, 5);
  west = east = false;

  for (int p = 0; p < playerBullets.length; p++) {
    playerBullets[p] = new Projectile(playerProjectile, LASER);
  }

  textSize(30);

  initFirstHordePos = new PVector((width/2) - ((firstHorde[0].length/2) * alienSize) - (spacing/firstHorde[0].length), 2*alienSize);
  
  initBossHordePos = initFirstHordePos;
  
  
  phase = stage2;

  makeHorde(firstHorde);
  makeHorde(bossHorde);


  game = true;
}

void draw() {
  background(0);

  if (ship.lives <= 0) {
    game = false;
  }

  if (game) {

    noStroke();
    for (int p = 0; p < playerBullets.length; p++) {
      if (playerBullets[p].onScreen) {
        playerBullets[p].display();
        playerBullets[p].move();
      }
    }

    textAlign(LEFT);
    text("Score: "+ship.score, 0, int(height*0.95));
    text("Highscore:"+ship.highScore, 0, int(height*0.98));
    text("Lives: "+ship.lives, width - 100, int(height*.95));

    ship.display();
    if ((west) && (ship.position.x > (ship.size/2))) { // actually causes fluid movement, funny how long this took me to figure out
      //these booleans, whose states are determined by the event listeners
      ship.position.x -= ship.size/10;
    } else if ((east) && (ship.position.x < width - (ship.size/2))) {
      ship.position.x += ship.size/10;
    }

    if (phase == stage1) {
      for (int i = 0; i < firstHorde.length; i++) {
        for (int j = 0; j < firstHorde[i].length; j++) {
          firstHorde[i][j].enemyBullet.display();
          firstHorde[i][j].enemyBullet.move();

          if ((firstHorde[i][j].enemyBullet.onScreen) && (firstHorde[i][j].enemyBullet.playerCollisionCheck(ship))) {

            firstHorde[i][j].enemyBullet.onScreen = false;
            ship.lives--;
            ship.getHit();
          }
        }
      }
      drawHorde(firstHorde);
      moveHorde(firstHorde);
      Enemy shooter1 = firstHorde[int(random(0, firstHorde.length))][int(random(0, firstHorde.length))];
      Enemy shooter2 = firstHorde[int(random(0, (evaluateAlive(firstHorde)/firstHorde[0].length)))][int(random(0, (evaluateAlive(firstHorde)/firstHorde.length)))];
      for (int i = 0; i < firstHorde.length; i++) {
        for (int j = 0; j < firstHorde[i].length; j++) {
          for (int p = 0; p < playerBullets.length; p++) {
            if ((firstHorde[i][j].enemyCollision(playerBullets[p])) && (firstHorde[i][j].isAlive) && (playerBullets[p].onScreen)) {
              
              playerBullets[p].onScreen = false;
              firstHorde[i][j].rank--;
              firstHorde[i][j].hitsTaken++;
              if (firstHorde[i][j].rank < 0) {
                  firstHorde[i][j].isAlive = false;
                  ship.score += int(random( ((firstHorde[i][j].hitsTaken-1) * 50) + 90, ((firstHorde[i][j].hitsTaken-1) * 50) + 111));
              }
              
            }
          }
          if (((firstHorde[i][j] == shooter1) || (firstHorde[i][j] == shooter2)) && (enemyShootTimer <= 0)) {
            if (shooter1.isAlive) {
              shooter1.enemyShoot();
            }
            if (shooter2.isAlive) {
              shooter2.enemyShoot();
            }
            enemyShootTimer = enemyShootCooldown;
            break;
          }
        }
      }

      //ship movement
     if (int(frameCount) % 1 == 0) {
       cooldownTime--;
       enemyShootTimer--;
     }
     if (evaluateAlive(firstHorde) == 0) {
       phase = stage2;
     }
    }//phase 1


    if (phase == stage2) {
      
      for (int i = 0; i < bossHorde.length; i++) {
        for (int j = 0; j < bossHorde[i].length; j++) {
          bossHorde[i][j].enemyBullet.display();
          bossHorde[i][j].enemyBullet.move();

          if ((bossHorde[i][j].enemyBullet.onScreen) && (bossHorde[i][j].enemyBullet.playerCollisionCheck(ship))) {

            bossHorde[i][j].enemyBullet.onScreen = false;
            ship.lives--;
            ship.getHit();
          }
        }
      }
      drawHorde(bossHorde);
      moveHorde(bossHorde);
      Enemy shooter1 = bossHorde[int(random(0, firstHorde.length))][int(random(0, firstHorde.length))];
      Enemy shooter2 = bossHorde[int(random(0, (evaluateAlive(firstHorde)/firstHorde[0].length)))][int(random(0, (evaluateAlive(firstHorde)/firstHorde.length)))];
      for (int i = 0; i < bossHorde.length; i++) {
        for (int j = 0; j < bossHorde[i].length; j++) {
          for (int p = 0; p < playerBullets.length; p++) {
            if ((bossHorde[i][j].enemyCollision(playerBullets[p])) && (bossHorde[i][j].isAlive) && (playerBullets[p].onScreen)) {
              playerBullets[p].onScreen = false;
              bossHorde[i][j].rank--;
              bossHorde[i][j].hitsTaken++;
              if (bossHorde[i][j].rank < 0) {
                  bossHorde[i][j].isAlive = false;
                  ship.score += int(random( ((bossHorde[i][j].hitsTaken-1) * 50) + 90, ((bossHorde[i][j].hitsTaken-1) * 50) + 111));
              }
            }
          }
          if (((bossHorde[i][j] == shooter1) || (bossHorde[i][j] == shooter2)) && (enemyShootTimer <= 0)) {
            if (shooter1.isAlive) {
              shooter1.enemyShoot();
            }
            if (shooter2.isAlive) {
              shooter2.enemyShoot();
            }
            enemyShootTimer = enemyShootCooldown;
            break;
          }
        }
      }

      //ship movement
     if (int(frameCount) % 1 == 0) {
       cooldownTime--;
       enemyShootTimer--;
     }
    
     if (evaluateAlive(bossHorde) == 0) {
       phase = winScreen;
     }
    
    }
  
    if (phase == winScreen) {
      game = false;
    }
  
  }
  
  else if (phase == winScreen) {
    fill(255);
    rect(width/2 - 200/2, height/2 - 100/2, 200, 100); 
    textAlign(CENTER, CENTER);
    fill(0);
    text("You won!", width/2, height/2 - 50);
    text("Score: "+ship.score, width/2, height/2);
    noLoop();
  }
}
//game loop

void playerShoot() {//cycles through array of player projectiles to find the first non-fired one, and activate it
  for (int i = 0; i < playerBullets.length; i++) {
    if ((!playerBullets[i].onScreen) && (cooldownTime <= 0)) {
      playerBullets[i].fire(int(ship.position.x), int(ship.position.y));
      break;
    }
  }
}

void keyPressed() { // event listeners assign states of certain booleans
  if (game) {
  if ((keyCode == LEFT) || (key == 'a')) {
    west = true;
  } else if ((keyCode == RIGHT) || (key == 'd')) {
    east = true;
  }
  if (key == ' ') {
    playerShoot();
    cooldownTime = cooldown;
  }

  if (key == 'p') {
    paused++;
    if (paused % 2 == 1) {
      fill(255);
      rect(width/2 - 200/2, height/2 - 100/2, 200, 100);
      textAlign(CENTER, CENTER);
      fill(0);
      text("Paused", width/2, height/2);
      noLoop();
    } else if (paused % 2 == 0) {
      loop();
    }
  }
  }
}

void keyReleased() { //prevents movement stutter when going opposite direction
  if ((keyCode == LEFT) || (key == 'a')) {
    west = false;
  } else if ((keyCode == RIGHT) || (key == 'd')) {
    east = false;
  }
}




//enemy movement, if it works, don't touch it
void makeHorde(Enemy[][] invaders) {
    for (int i = 0; i < invaders.length; i++) {
      for (int j = 0; j < invaders[i].length; j++) {
        newFirstHordePos = new PVector(initFirstHordePos.x + (j * alienSize) + (j * (spacing/invaders[i].length)), initFirstHordePos.y + (i * (alienSize + (spacing/invaders.length))));
        invaders[i][j] = new Enemy(newFirstHordePos, false);
        if (invaders == firstHorde) {
          if ((i == 0)) {
            invaders[i][j].rank = 2;
          } else if (i == 1) {
            invaders[i][j].rank = 1;
          } else if (i >= 2) {
            invaders[i][j].rank = 0;
          }
        }
        else if (invaders == bossHorde) {
          if (i == 0) {
            invaders[i][j].rank = 3;
          }
          else if (i == 1) {
            invaders[i][j].rank = 2;
          }
          else if ((i == 2) || (i == 3)) {
            invaders[i][j].rank = 1;
          }
          else if (i == 4) {
            invaders[i][j].rank = 0;
          }
        }
      }
    }
  }
void drawHorde(Enemy[][] invaders) {
  for (int i = 0; i < invaders.length; i++) {
    for (int j = 0; j < invaders[i].length; j++) {
      invaders[i][j].display();
    }
  }
}
void moveHorde(Enemy[][] invaders) {

  for (int a = 0; a < invaders.length; a++) {
    for (int b = 0; b < invaders[a].length; b++) {
      invaders[a][b].move();
    }
  }

  if ((invaders == firstHorde) || (invaders == bossHorde)) {
    for (int i = 0; i < invaders.length; i++) {
      for (int j = 0; j < invaders[i].length; j++) {
        if ((invaders[i][0].position.x <= alienSize/2) || (invaders[i][invaders[i].length - 1].position.x >= width - (alienSize/2))) {
          invaders[i][j].speed *= -1;
          invaders[i][j].position.y += 3*(alienSize/4);
        }
      }
    }
  }
}

int evaluateAlive(Enemy[][] invaders) {
  int alive = 0;
  for (int i = 0; i < invaders.length; i++) {
    for (int j = 0; j < invaders[i].length; j++) {
      if (invaders[i][j].isAlive) {
        alive++;
      } else {
        continue;
      }
    }
  }
  return alive;
}
