boolean[] keysDown;
boolean menu = false, game_over = false, game_won = false, mouse_ctrl = true;;
Player player;
Ball ball;
int brick_w = 100, brick_h = 50;
ArrayList<Brick> bricks;
int block_no;
color bg_color = color(0, 0, 50);

void setup() {
  print("Initialization...\n");
  size(1200, 1000);
  frameRate(120);
  keysDown = new boolean[256];
  player = new Player();
  ball = new Ball();
  bricks = new ArrayList<Brick>();
  
  block_no = 0;
  for(int i = 0; i < 12; i ++) {
    for(int j = 0; j < 7; j ++) {
      bricks.add(new Brick(new PVector(i * brick_w, j * brick_h + brick_h * 2), j)); 
      print("brick " + (block_no + 1) + " added: X=" + bricks.get(block_no).position.x + "; Y=" + bricks.get(block_no).position.y + "\n"); 
      block_no ++; 
    }
  }
  print("Ready.\n");
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
  
  if(!mouse_ctrl) {
    if(!menu && !game_over) {
      if (keysDown[37]) // O
        player.move("LEFT");
      if (keysDown[39]) // L
        player.move("RIGHT");
      }
  } else {
    player.moveMouse();
  }
  
  ball.move();
    
  if(keyPressed && key == ' ' || mousePressed && (mouseButton == LEFT)) {
      ball.sticky = false;
  }
  
  // Checking section
  
  player.checkBounds();
  ball.checkSticky();
  ball.checkBounds();
  ball.checkCollisionPlayer();
  
  ball.bounced = false;
  
  for(int i = 0; i < bricks.size(); i ++) {
    ball.checkCollisionBrick(bricks.get(i));
  }
  
  if(player.score >= 84)
    game_won = true;
    
  // Drawing section
  
  player.draw();
  
  for(int i = 0; i < bricks.size(); i ++) {
    bricks.get(i).draw();
  }
  
  ball.draw();
  
  fill(255);
  textSize(30);
  //textAlign(LEFT, CENTER);
  //text("ball_x: " + str(ball.position.x), width / 64, height / 32);
  //text("ball_y: " + str(ball.position.y), width / 64, height / 32 * 2.5);
  textAlign(RIGHT, CENTER);
  text("health: " + str(player.health), width / 64 * 64, height / 32);
  text("score: " + str(player.score), width / 64 * 64, height / 32 * 2.1);
}
