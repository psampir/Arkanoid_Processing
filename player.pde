class Player {
  PVector position;
  String side;
  int health;
  final color base = color(255, 0, 0);
  final int w = 130, h = 20, velocity = 12;

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
    fill(base);
    rect(position.x, position.y, w, h);
  }
}
