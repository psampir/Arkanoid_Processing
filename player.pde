class Player {
  PVector position;
  int health, score = 0;
  final float stripe_w = 40 * gUnit, circle_w = 20 * gUnit, small_c_w = 15 * gUnit;
  final float w = 150 * gUnit, h = 30 * gUnit, velocity = 24 * gUnit;
  final float darkenAmount = 0.4;
  color darkerColor, brighterColor;
  final color base_col = color(200, 200, 200), 
              stripe_col = color(255, 60, 60),
              circle_col = color(0, 155, 255),
              small_c_col = color(0, 205, 255);
  
  Player() {
    reset();
  }

  void move(String direction) {
    if (direction.equals("LEFT"))
      position.x -= velocity;
    else if (direction.equals("RIGHT"))
      position.x += velocity;
  }
  
  void moveMouse() {
    position.x = mouseX - w / 2;
  }

  void checkBounds() {
    if (position.x > width - margin - w) // right bound
      position.x = width - margin - w;
    else if (position.x < margin) // left bound
      position.x = margin;
  }
  
  void reset() {
    position = new PVector(width / 2 - w / 2, height - h / 2 - 50);
    health = 2;
    score = 0;
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
