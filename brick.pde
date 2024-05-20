class Brick {
  PVector position;
  boolean destroyed;
  final int w = 100, h = 50;
  final float darkenAmount = 0.4;
  int col_number;
  color darkerColor, brighterColor;
  final color[] colors = {
    color(235, 0, 0),     // Red
    color(235, 150, 0),   // Orange
    color(235, 235, 0),   // Yellow
    color(0, 235, 0),     // Green
    color(0, 235, 235),   // Cyan
    color(0, 0, 235),     // Blue
    color(255, 0, 255),   // Magenta
  };
  
  Brick(PVector pos, int color_number) {
    reset(pos, color_number);
  }
  
  void destroy() {
    destroyed = true;
  }
  
  void reset(PVector pos, int color_number) {
    position = new PVector(pos.x, pos.y);
    destroyed = false;
    col_number = color_number;
  }
  
  void draw() {
    if(!destroyed) {
      darkerColor = lerpColor(colors[col_number], color(0), darkenAmount);
      brighterColor = lerpColor(colors[col_number], color(255), darkenAmount);
      
      fill(darkerColor);
      rect(position.x, position.y, w, h);
      
      fill(brighterColor);
      triangle(position.x, position.y, position.x + w, position.y, position.x, position.y + h);
      
      fill(colors[col_number]);    
      rect(position.x + w / 9, position.y + h / 8, w / 9 * 7, h / 8 * 6);
    }
  }
}
