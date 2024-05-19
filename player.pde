class Player {
  PVector position;
  int health;
  final color 
    base_col = color(200, 200, 200), 
    stripe_col = color(255, 60, 60),
    circle_col = color(0, 155, 255),
    small_c_col = color(0, 205, 255);
  final int stripe_w = 40, circle_w = 20, small_c_w = 15;
  
  final int w = 150, h = 30, velocity = 12;
  final float darkenAmount = 0.4;
  color darkerColor, brighterColor;
  

  Player() {
    reset();
  }

  void move(String direction) {
    if (direction.equals("LEFT"))
      position.x -= velocity;
    else if (direction.equals("RIGHT"))
      position.x += velocity;
  }

  void checkBounds() {
    if (position.x > width - w) // right bound
      position.x = width - w;
    else if (position.x < 0) // left bound
      position.x = 0;
  }
  
  void reset() {
    position = new PVector(width / 2 - w / 2, height - h / 2 - 50);
    health = 3;
  }

  void draw() {
    fill(circle_col);
    circle(position.x + circle_w / 4, position.y + h / 2, circle_w);
    circle(position.x + w - circle_w / 4, position.y + h / 2, circle_w);
    
    fill(small_c_col);
    circle(position.x + circle_w / 4, position.y + h / 2, small_c_w);
    circle(position.x + w - circle_w / 4, position.y + h / 2, small_c_w);
    
    darkerColor = lerpColor(stripe_col, color(0), darkenAmount);
    brighterColor = lerpColor(stripe_col, color(255), darkenAmount);
    
    fill(darkerColor);
    rect(position.x, position.y, w, h);
    
    fill(brighterColor);
    triangle(position.x, position.y, position.x + w, position.y, position.x, position.y + h);
    
    fill(stripe_col);
    rect(position.x + w / 12, position.y + h / 10, w - 2 * (w / 12), h - 2 * (h / 10));
    
    darkerColor = lerpColor(base_col, color(0), darkenAmount);
    brighterColor = lerpColor(base_col, color(255), darkenAmount);
    
    fill(darkerColor);
    rect(position.x + stripe_w, position.y + h / 2, w - 2 * stripe_w, h / 2);
    
    fill(brighterColor);
    rect(position.x + stripe_w, position.y, w - 2 * stripe_w, h / 2);
    
    fill(base_col);
    rect(position.x + stripe_w, position.y + h / 10, w - 2 * stripe_w, h - 2 * (h / 10));
  }
}
