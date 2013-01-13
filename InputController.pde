class InputController {
  
  InputController(){
  }
  
  void dragging(int x, int y){
    graphics.mouseIsDragging(x, y);
  }
  
  void moved(int x, int y){
    graphics.findMouseOver(x, y);
  }
  
  void released(int x, int y){
    graphics.clicked(x, y);
  }
  
  //---------------------------------------------------------------------=
  
  //mod: $r$, $g$, $b$, $a1$, $a255$, $hex$, $ahex$, $h$, $s$, $b$
    
  void clipboard(color c){
    String modifierText = textEditor.viewText();
    String[] splitText = split(modifierText, "$");
    
    for(int i = 0; i < splitText.length; i++){
      if(splitText[i].equals("r")){
        splitText[i] = nf( int( red(c) ), 3);
        
      } else if(splitText[i].equals("g")){
        splitText[i] = nf( int( green(c) ), 3);
        
      } else if(splitText[i].equals("b")){
        splitText[i] = nf( int( blue(c) ), 3);
        
      } else if(splitText[i].equals("a1")){
        String a = "" + alpha(c) / 255.0;
        if(a.length() > 5){
          splitText[i] = a.substring(0, 5);
        } else {
          splitText[i] = a;
        }
        
      }  else if(splitText[i].equals("a255")){
        splitText[i] = nf( int(alpha(c)), 3);
        
      } else if(splitText[i].equals("hex")){
        String h = hex(c);
        splitText[i] = h.substring(2, h.length());
        
      } else if(splitText[i].equals("ahex")){
        splitText[i] = hex(c);
        
      } else if(splitText[i].equals("h")){
        splitText[i] = nf( int( hue(c) ), 3);
        
      } else if(splitText[i].equals("s")){
        splitText[i] = nf( int( saturation(c) ), 3);
        
      } else if(splitText[i].equals("b")){
        splitText[i] = nf( int( brightness(c) ), 3);
      }
    }
    
    String finished = "";
    for(int i = 0; i < splitText.length; i++){
      finished += splitText[i];
    }
    
    pushToClipboard(finished);
  }
  
  void pushToClipboard(String s){
    StringSelection data = new StringSelection( s );
    Clipboard clipboard = Toolkit.getDefaultToolkit().getSystemClipboard();
    clipboard.setContents(data, data);
  }
  
}
