class Ball {
  PVector position, velocity;
  boolean sticky, bounced;
  int start_dir = 0;
  final int r = 15, speed = 5;
  final float eff_vel = sqrt(pow(speed, 2) * 2);
  final int perimeter_w = 3, lift_h = 30, offset = 0;
  float test_x, test_y, dist_x, dist_y, dist, overlapLeft, overlapRight, overlapTop, overlapBottom, minOverlap;
  float[] overlaps = new float[4];
  final color inner_col = color(255, 255, 255), 
              outer_col = color(130, 130, 130);
  
  Ball() {
    reset();
  }
  
  void reset() {
    sticky = true;
    start_dir = int(random(0, 2));
    
    if(start_dir == 0)
      velocity = new PVector(-speed, -speed); // move left
    else
      velocity = new PVector(speed, -speed); // move right
      
    //velocity = new PVector(0, speed); // for testing
  }
  
  void checkSticky() {
    if(sticky)
      stick();
  }
  
  void stick() {
    position = new PVector(player.position.x + player.w / 2 + offset, player.position.y - lift_h);
  }
  
  void move() {
    if(!sticky)
      position.add(velocity);
  }
  
  void checkBounds() {
    if(position.y + r >= height) { // bottom
      reset();
      player.health --;
    }
    
    if(!bounced) {
      if(position.y - r <= 0) { // top
        bounced = true;
        velocity.y = abs(velocity.y) * -1;
        print(frameCount + " hit top bound... \n");
      }
      
      if((position.x - r <= 0)) { // left
        bounced = true;
        velocity.x = abs(velocity.x);
        print(frameCount + " hit left bound... \n");
      }
      
      if((position.x + r >= width)) { // right
        bounced = true;
        velocity.x = abs(velocity.x) * - 1;
        print(frameCount + " hit right bound... \n");
      }
      
    }
  }
  
  void checkCollisionPlayer() {
    if(position.y + r >= player.position.y // is between top edge
    && position.y - r < player.position.y + player.h / 2 // and half height
    && position.x + r > player.position.x // is between left edge 
    && position.x - r < player.position.x + player.w) { // and right edge
      print(frameCount + " hit player... \n");
      velocity.y = -speed;
      rebouncePlayer();
    }
  } 

  void checkCollisionBrick(Brick brick) {
    String collisionType = collision(brick.position, brick.w, brick.h);
    if(collisionType != null && !brick.destroyed && !bounced) {
        rebounceBrick(collisionType);
        print(frameCount + " hit brick... \n");
        brick.destroy();
        player.score ++;
    }     
  }
  
  void rebouncePlayer() {
    int direction;
    float player_cent_w = player.position.x + player.w / 2; 
    float distance = position.x - player_cent_w; // calculate the distance between the center of the player and the center of the ball
    print(frameCount + " dist: " + distance + "\n"); // max-right = 89, max-left = -89
        
    if(distance < 0) // set direction of rebouncing
      direction = -1;
    else
      direction = 1;   
    
    if(abs(distance) < 10) // set vertical velocity depending on the distance
      velocity.x = 1 * direction;
    else if(abs(distance) < 20)
      velocity.x = 2 * direction;
    else if(abs(distance) < 30)
      velocity.x = 3 * direction;
    else if(abs(distance) < 40)
      velocity.x = 4 * direction;
    else if(abs(distance) < 50)
      velocity.x = 5 * direction;
    else if(abs(distance) < 60)
      velocity.x = 6 * direction;
    else if(abs(distance) < 70)
      velocity.x = 6.5 * direction;
    else
      velocity.x = 6.9 * direction;
       
    velocity.y = calcVerticalVelocity(velocity.x, eff_vel);
    
    print(frameCount + " vel E: " + eff_vel + "\n");
    print(frameCount + " vel X: " + velocity.x + "\n");
    print(frameCount + " vel Y: " + velocity.y + "\n");
  }
  
   // calculate vertical velocity based on horizontal and effective velocities
  float calcVerticalVelocity(float x_vel, float eff_vel) { 
     float y_vel_sqr = pow(eff_vel, 2) - pow(x_vel, 2);
     return -1 * sqrt(y_vel_sqr);
   }

  void rebounceBrick(String collisionType) { // ball rebounce logic based on collisionType
    bounced = true;
    if(collisionType.equals("left") || collisionType.equals("right")) {
        velocity.x *= -1; // invert x direction
    } else if(collisionType.equals("top") || collisionType.equals("bottom")) {
        velocity.y *= -1; // Invert y direction
    } 
  }

  String collision(PVector rect_pos, int rect_w, int rect_h) {
    test_x = position.x; 
    test_y = position.y;
    
    // check the closest edge
    if(position.x < rect_pos.x)
        test_x = rect_pos.x; // left edge
    else if(position.x > rect_pos.x + rect_w)
        test_x = rect_pos.x + rect_w; // right edge
    
    if(position.y < rect_pos.y)
        test_y = rect_pos.y; // top edge 
    else if(position.y > rect_pos.y + rect_h)
        test_y = rect_pos.y + rect_h; // bottom edge
      
    dist_x = position.x - test_x;
    dist_y = position.y - test_y;
    dist = sqrt(pow(dist_x, 2) + pow(dist_y, 2));
          
    if(dist <= r) { // determine the collision side
        overlaps[0] = position.x - (rect_pos.x - r); // left
        overlaps[1] = (rect_pos.x + rect_w + r) - position.x; // right
        overlaps[2] = position.y - (rect_pos.y - r); // top
        overlaps[3] = (rect_pos.y + rect_h + r) - position.y; // bottom
      
        minOverlap = min(overlaps);
        
        if (minOverlap == overlaps[0]) 
          return "left";
        if (minOverlap == overlaps[1]) 
          return "right";
        if (minOverlap == overlaps[2]) 
          return "top";
        if (minOverlap == overlaps[3]) 
          return "bottom";
    }
    return null;
  }

  void draw(PVector position, int radius) {
    fill(outer_col);
    circle(position.x, position.y, radius * 2);
    
    fill(inner_col);
    circle(position.x, position.y, radius * 2 - radius * 0.2);
  }
}
