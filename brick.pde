class Brick {
  PVector position;
  final float w = 100, h = 50;
  final color[] colors = {
    color(235, 0, 0),     // Red
    color(235, 150, 0),   // Orange
    color(235, 235, 0),   // Yellow
    color(0, 235, 0),     // Green
    color(0, 235, 235),   // Cyan
    color(0, 0, 235),     // Blue

    //color(128, 0, 128),   // Purple
    color(255, 192, 203), // Pink
    color(255, 140, 0),   // Dark Orange
    
    color(255, 0, 255)    // Magenta
  };
  final float darkenAmount = 0.4;
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
