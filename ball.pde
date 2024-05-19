class Ball {
  PVector position, velocity;
  int speed = 4;
  boolean sticky, bounced;
  int wait_bounce;
  int start_dir = 0;
  final float r = 15;
  final color inner_col = color(255, 255, 255), 
              outer_col = color(130, 130, 130);
  final int perimeter_w = 3, lift_h = 30;
  
  float test_x, test_y, dist_x, dist_y, dist, 
  overlapLeft, overlapRight, overlapTop, overlapBottom, minOverlap;
  float[] overlaps = new float[4];
  
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
  }
  
  void checkSticky() {
    if(sticky)
      position = new PVector(player.position.x + player.w / 2, player.position.y - lift_h);
  }
  
  void move() {
    if(!sticky)
      position.add(velocity);
  }
  
  void checkBounds() {
    if(position.y - r < 0) // top
      velocity.y *= -1;
    else if(position.y + r > height){ // bottom
      reset();
      player.health --;
    }
    if((position.x - r < 0 || position.x + r > width)) // left & right
      velocity.x *= -1;
  }
  
  void checkCollisionPlayer() {
    if(position.y + r >= player.position.y // is between top edge
    && position.y - r < player.position.y + player.h / 2 // and half height
    && position.x + r > player.position.x // is between left edge 
    && position.x - r < player.position.x + player.w // and right edge
    && wait_bounce <= 0) {
      print(frameCount + " hit player... \n");
      velocity.y = -speed;
      wait_bounce = 10;
    }
    
    
    //String collisionType = collision(player.position, player.w, player.h);
    //if(collisionType != null && wait_bounce <= 0) {
    //    print(frameCount + " hit player... \n");
    //    wait_bounce = 10;
    //    rebounce(collisionType);
    //}     
  }

  void checkCollisionBrick(Brick brick) {
    String collisionType = collision(brick.position, brick.w, brick.h);
    if(collisionType != null && brick.destroyed == false && bounced == false) {
        rebounce(collisionType);
        print(frameCount + " hit brick... \n");
        brick.destroy();
        player.score ++;
    }     
  }

  void rebounce(String collisionType) { // ball rebounce logic based on collisionType
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
          
    if(dist <= r) {
        // determine the collision side
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

  
  void draw() {
    fill(outer_col);
    circle(position.x, position.y, r * 2);
    
    fill(inner_col);
    circle(position.x, position.y, r * 2 - perimeter_w);
  }
  
}
