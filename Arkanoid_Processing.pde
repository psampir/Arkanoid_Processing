boolean[] keysDown;
boolean menu = false, game_over = false;
Player player;
Ball ball;
int brick_w = 100, brick_h = 50;
ArrayList<Brick> bricks;
int block_no;
color bg_color = color(0, 0, 50);

void setup() {
  size(1200, 800);
  frameRate(120);
  keysDown = new boolean[256];
  player = new Player();
  ball = new Ball();
  bricks = new ArrayList<Brick>();
  
  block_no = 0;
  for(int i = 0; i < 12; i ++) {
    for(int j = 0; j < 7; j ++) {
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
  background(bg_color);
  noStroke();
  
  // Moving section
  
  if(!menu && !game_over) {
    if (keysDown[37]) // O
      player.move("LEFT");
    if (keysDown[39]) // L
      player.move("RIGHT");
 
    ball.move();
    
    if(keyPressed && key == ' ') {
      ball.sticky = false;
    }
  }
  
  // Checking section
  
  player.checkBounds();
  ball.checkSticky();
  ball.checkBounds();
  ball.checkCollisionPlayer();
  
  ball.bounced = false;
  ball.wait_bounce --;
  
  for(int i = 0; i < bricks.size(); i ++) {
    ball.checkCollisionBrick(bricks.get(i));
  }
  
  // Drawing section
  
  player.draw();
  
  block_no = 0;
  for(int i = 0; i < 12; i ++) { // draw bricks
    for(int j = 0; j < 7; j ++) {
      bricks.get(block_no).draw(j);
      block_no ++;
    }
  }
  
  ball.draw();
  
  fill(255);
  textSize(30);
  //textAlign(LEFT, CENTER);
  //text("ball_x: " + str(ball.position.x), width / 64, height / 32);
  //text("ball_y: " + str(ball.position.y), width / 64, height / 32 * 2.5);
  textAlign(RIGHT, CENTER);
  text("health: " + str(player.health), width / 64 * 64, height / 32);
  text("score: " + str(player.score), width / 64 * 64, height / 32 * 2.5);
}
