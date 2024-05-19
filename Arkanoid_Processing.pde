boolean[] keysDown;
boolean menu = false, game_over = false;
Player player;
int brick_w = 100, brick_h = 50;
ArrayList<Brick> bricks;
int block_no;

void setup() {
  size(1200, 800);
  frameRate(60);
  keysDown = new boolean[256];
  player = new Player();
  bricks = new ArrayList<Brick>();
  
  block_no = 0;
  for(int i = 0; i < 12; i ++) {
    for(int j = 0; j < 6; j ++) {
      bricks.add(new Brick(new PVector(i * brick_w, j * brick_h + brick_h * 2))); 
      print("brick " + (block_no + 1) + " added: X=" + bricks.get(block_no).position.x + "; Y=" + bricks.get(block_no).position.y + "\n"); 
      block_no ++; 
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
  
  block_no = 0;
  for(int i = 0; i < 12; i ++) {
    for(int j = 0; j < 6; j ++) {
      bricks.get(block_no).draw(j);
      block_no ++;
    }
  }
  
  fill(255);
  textSize(40);
  textAlign(LEFT, CENTER);
  text("p-pos: " + str(player.position.x), width / 64, height / 32);
}
