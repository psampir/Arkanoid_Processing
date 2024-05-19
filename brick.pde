class Brick {
  PVector position;
  boolean destroyed;
  final int w = 100, h = 50;
  final float darkenAmount = 0.4;
  final color[] colors = {
    color(235, 0, 0),     // Red
    color(235, 150, 0),   // Orange
    color(235, 235, 0),   // Yellow
    color(0, 235, 0),     // Green
    color(0, 235, 235),   // Cyan
    color(0, 0, 235),     // Blue
    color(255, 0, 255),   // Magenta

    //color(128, 0, 128),   // Purple
    
    color(255, 140, 0),   // Dark Orange
    
        // Magenta
  };
  color darkerColor, brighterColor;
  
  Brick(PVector pos) {
    reset(pos);
  }
  
  void destroy() {
    destroyed = true;
  }
  
  void reset(PVector pos) {
    position = new PVector(pos.x, pos.y);
    destroyed = false;
  }
  
  void draw(int color_number) {
    if(!destroyed) {
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
}