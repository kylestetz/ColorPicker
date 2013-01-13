class AlphaBar {
  
  int x, y, w, h;
  int id = 106;
  
  int locator = 0;
  
  AlphaBar(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void draw(){
    if(locator < h/2){
      stroke(255);
    } else {
      stroke(0);
    }
    line(x, y + locator + 7, x + 7, y + locator);
  }
  
  void mouseIsDragging(int mx, int my){
    my -= y;
    my = constrain(my, 0, h - 1);
    locator = my;
    graphics.setAlpha(255 - locator);
  }
  
}
