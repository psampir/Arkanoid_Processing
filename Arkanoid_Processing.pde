boolean[] keysDown;
boolean menu = false, game_over = false;
Player player;

void setup() {
  size(1200, 800);
  frameRate(60);
  keysDown = new boolean[256];
  player = new Player();
}

void keyPressed() {
  if (keyCode < 256) 
    keysDown[keyCode] = true;
}

void keyReleased() {
  if (keyCode < 256) 
    keysDown[keyCode] = false;
}

void draw() {
  background(0);
  noStroke();
  
  // Moving section:
  
  if(!menu && !game_over) {
    if (keysDown[37]) // O
      player.move("LEFT");
    if (keysDown[39]) // L
      player.move("RIGHT");
 
    //ball.move();
  }
  
  // Checking section:
  player.checkBounds();
  
  // Drawing section:
  
  player.draw();
  
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text(str(player.position.x), width / 10, height / 10);
}
