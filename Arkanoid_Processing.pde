boolean[] keysDown;
boolean menu = false, game_over = false;
Player player;
int brick_w = 100, brick_h = 50;
ArrayList<Brick> bricks;

void setup() {
  size(1200, 800);
  frameRate(60);
  keysDown = new boolean[256];
  player = new Player();
  bricks = new ArrayList<Brick>();
  
  for(int i = 0; i < 12; i ++) {
    for(int j = 0; j < 6; j ++) {
      bricks.add(new Brick(new PVector(i * brick_w, j * brick_h + brick_h * 3))); 
      print("brick added: X=" + bricks.get(i * j).position.x + "; Y=" + bricks.get(i * j).position.y + "\n"); 
    }
  }
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
  
  for(int i = 0; i < bricks.size(); i ++) {
    bricks.get(i).draw(i % 9);
  }
  
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text(str(player.position.x), width / 10, height / 10);
}
