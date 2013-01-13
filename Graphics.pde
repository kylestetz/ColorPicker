class Graphics {
  
  PGraphics mouseMap;
  ColorViewer colorViewer;
  ColorBox colorBox;
  HueBar hueBar;
  SwatchViewer swatchViewer;
  CopyBox copyBox;
  AlphaBar alphaBar;
  
  
  boolean mouseIsOver = false;
  int mouseOverID = 0;
  
  int COLORVIEWER = 100;
  int HUEBAR = 101;
  int COLORBOX = 102;
  int SWATCHVIEWER = 103;
  int COPYBOX = 104;
  int TEXTBOX = 105;
  int ALPHABAR = 106;
  
  Graphics(){
    // 100
    colorViewer = new ColorViewer(20, 20);
    // 101
    hueBar = new HueBar(colorViewer.x + colorViewer.w + 20, colorViewer.y, 20, 256);
    // 102
    colorBox = new ColorBox(hueBar.x + 40, 20, width - hueBar.x - 60);
     // 104
    copyBox = new CopyBox(colorBox.x, colorViewer.y + colorViewer.h + 20, colorBox.w);
    // 103
    swatchViewer = new SwatchViewer(colorViewer.x, colorViewer.y + colorViewer.h + 20, hueBar.x, 128);
   
    // 106
    alphaBar = new AlphaBar(hueBar.x - 8, colorBox.y, 9, 256);
    
    mouseMap = createGraphics(width, height, JAVA2D);
    drawMouseMap();
  }
  
  void draw(){
    colorViewer.draw();
    colorBox.draw();
    hueBar.draw();
    swatchViewer.draw();
    copyBox.draw();
    alphaBar.draw();
    //image(mouseMap, 0, 0);
  }
  
  void findMouseOver(int x, int y){
    mouseMap.loadPixels();
    mouseOverID = mouseMap.pixels[x + y*mouseMap.width] & 0xFF;
    if(mouseOverID != 0){
      mouseIsOver = true;
    } else {
      mouseIsOver = false;
    }
    
    if( mouseOverID == TEXTBOX ){
      textEditor.setFocus(true);
    }
  }
  
  void mouseIsDragging(int x, int y){
    if(mouseIsOver){
      
      switch(mouseOverID){
        case 100:
          colorViewer.mouseIsDragging(x, y);
          break;
        case 101:
          hueBar.mouseIsDragging(x, y);
          break;
        case 103:
          swatchViewer.mouseIsDragging(x, y);
          break;
        case 106:
          alphaBar.mouseIsDragging(x, y);
          break;
        default:
          break;
      }
      
      if(mouseOverID != TEXTBOX){
        textEditor.setFocus(false);
      }
    }
  }
  
  void clicked(int x, int y){
    if(mouseOverID == COLORBOX){
      colorBox.clicked(x, y);
    } else if(mouseOverID == COPYBOX){
      copyBox.clicked(x, y);
    }
  }
  
  void setAlpha(float val){
    colorViewer.setAlpha(val);
  }
  
  //--------------------------------------------------------------------------=
  
  void addSwatch(color c){
    swatchViewer.addSwatch(c);
  }
  
  void removeSwatch(){
    swatchViewer.removeSwatch();
  }
  
  //--------------------------------------------------------------------------=
  
  void drawMouseMap(){
    mouseMap.beginDraw();
      mouseMap.background(0);
      mouseMap.noStroke();
      // color viewer
      mouseMap.fill(colorViewer.id);
      mouseMap.rect(colorViewer.x, colorViewer.y, colorViewer.w, colorViewer.h);
      
      // huebar
      mouseMap.fill(hueBar.id);
      mouseMap.rect(hueBar.x, hueBar.y, hueBar.w, hueBar.h);
      
      // color box 1
      mouseMap.fill(colorBox.id);
      mouseMap.rect(colorBox.x, colorBox.y, colorBox.w, colorBox.w);
      
      // swatch viewer
      mouseMap.fill(swatchViewer.id);
      mouseMap.rect(swatchViewer.x, swatchViewer.y, swatchViewer.w, swatchViewer.h);
      
      // copy box
      mouseMap.fill(copyBox.id);
      mouseMap.rect(copyBox.x, copyBox.y, copyBox.w, copyBox.h);
      
      // text editor
      mouseMap.fill(105);
      mouseMap.rect( textEditor.getX(), textEditor.getY(), textEditor.getWidth(), textEditor.getHeight() );
      
      mouseMap.fill(alphaBar.id);
      mouseMap.rect( alphaBar.x, alphaBar.y, alphaBar.w, alphaBar.h);
    mouseMap.endDraw();
  }
  
}
