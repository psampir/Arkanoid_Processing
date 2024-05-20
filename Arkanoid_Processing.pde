String version = "1.0.0";
boolean[] keysDown;
boolean title_screen = true, game_over = false, mouse_ctrl = true;;
Player player;
Ball ball;
int brick_w = 100, brick_h = 50;
ArrayList<Brick> bricks;
int block_no;
color bg_color = color(0, 0, 50);
final int FR = 120;

void setup() {
  print("Initialization...\n");
  size(1200, 1000);
  frameRate(FR);
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
  
  if(!game_over) {
    if(!mouse_ctrl) {
      if (keysDown[37]) // O
        player.move("LEFT");
      if (keysDown[39]) // L
        player.move("RIGHT");
    } else {
      player.moveMouse();
    }
    
    if(keyPressed && key == ' ' || mousePressed && mouseButton == LEFT)
      ball.sticky = false;
  }
  
  if(keyPressed && key == 'o')
    game_over = true;
    
  if(keyPressed && key == 'w')
    player.score = 100;
  
  ball.move();
  
  // Checking section
  
  player.checkBounds();
  ball.checkSticky();
  ball.checkBounds();
  ball.checkCollisionPlayer();
  
  ball.bounced = false;
  
  for(int i = 0; i < bricks.size(); i ++)
    ball.checkCollisionBrick(bricks.get(i));
  
  if(player.score >= 84 || player.health < 0)
    game_over = true;
    
  // Drawing section
  
  player.draw();
  
  for(int i = 0; i < bricks.size(); i ++)
    bricks.get(i).draw();
  
  if(player.health >= 0)
    ball.draw(ball.position, ball.r);
  
  if(player.health > 2)
    ball.draw(new PVector(width / 64.0 * 30.5, height / 64), 10);
  if(player.health > 1)
    ball.draw(new PVector(width / 64.0 * 32.0, height / 64), 10);
  if(player.health > 0)
    ball.draw(new PVector(width / 64.0 * 33.5, height / 64), 10);
  
  if(game_over) {
    title_screen = false;
    fill(0, 0, 0, 200);
    rect(0, height / 3, width, height / 3);
    fill(255, 255, 255);
    textSize(150);
    textAlign(CENTER, CENTER);
    
    text("GAME OVER", width / 2, height / 5.0 * 2.1);
    if(player.score >= 84) {
      text("YOU WIN!", width / 2, height / 5.0 * 2.8);
      bg_color = color(0, 200, 0);
    } else {
      text("YOU LOSE!", width / 2, height / 5.0 * 2.8);
      bg_color = color(200, 0, 0);
    }
    fill(255);
    textSize(40);
    textAlign(CENTER, CENTER);
    if(frameCount % FR * 2 < FR) {
      text("Press ENTER to continue", width / 2, height / 20 * 13.75);
    }
    if(keyPressed && key == ENTER) {
      game_over = false;
      title_screen = true;
      bg_color = color(0, 0, 50);
      player.reset();
      
      for(int i = 0; i < bricks.size(); i ++)
        bricks.get(i).destroyed = false;
    }
    
  }
  
  if(title_screen) {
    fill(255, 255, 0);
    textSize(200);
    textAlign(CENTER, CENTER);
    text("ARKANOID", width / 2, height / 20.0 * 11.0);
    textSize(20);
    textAlign(RIGHT, CENTER);
    fill(255);
    text("v" + version, width / 64.0 * 63.5, height / 64.0);
    
    textSize(40);
    textAlign(CENTER, CENTER);
    if(frameCount % FR * 2 < FR) {
      text("Press spacebar to play using arrows", width / 2, height / 20 * 13.25);
      text("or left click to play using the cursor", width / 2, height / 20 * 14.15);
    }
    fill(255, 255, 0);
    textSize(20);
    text("Made by Paweł Sampir (2024)", width / 2, height / 20.0 * 19.65);;
    
    if(keyPressed && key == ' ') {
      title_screen = false;
      mouse_ctrl = false;
    }
    else if(mousePressed && mouseButton == LEFT) {
      title_screen = false;
      mouse_ctrl = true;
    }
  } 
}
