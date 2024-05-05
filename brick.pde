class Brick {
  PVector position;
  final float w = 100, h = 50;
  final color[] colors = {
    color(255, 0, 0),     // Red
    color(255, 165, 0),   // Orange
    color(255, 255, 0),   // Yellow
    color(0, 255, 0),     // Green
    color(0, 0, 255),     // Blue
    //color(128, 0, 128),   // Purple
    color(255, 192, 203), // Pink
    color(255, 140, 0),   // Dark Orange
    color(0, 255, 255),   // Cyan
    color(255, 0, 255)    // Magenta
  };
  float darkenAmount = 0.5;
  color darkerColor, brighterColor;
  
  Brick(PVector pos) {
    position = new PVector(pos.x, pos.y);
  }
  
  void draw(int color_number) {
    darkerColor = lerpColor(colors[color_number], color(0), darkenAmount);
    brighterColor = lerpColor(colors[color_number], color(255), darkenAmount);
    
    fill(darkerColor);
    rect(position.x, position.y, w, h);
    
    fill(brighterColor);
    triangle(position.x, position.y, position.x + w, position.y, position.x, position.y + h);
    
    fill(colors[color_number]);    
    rect(position.x + w / 9, position.y + h / 8, w / 9 * 7, h / 8 * 6);
  }
}
