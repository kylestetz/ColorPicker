/*

COLOR PICKER v1.0
created by Kyle Stetz

this here's your run of the mill color picker, optimized for programmers
and web developers. it can copy a user-formatted string to your clipboard,
and if you are nice to it (e.g. use the escape key to quit) it will save
the swatches you've been adding and load them on the next launch.

---> questions/comments/let's collaborate: kylestetz@gmail.com

this uses Peter Lager's G4P (guicomponents) library. Thanks Peter.
---> http://lagers.org.uk/g4p/index.html

*/

import java.awt.*;
import java.awt.datatransfer.*;
import java.awt.Color;
import guicomponents.*;

Graphics graphics;
InputController inputController;
GTextField textEditor;

PImage bg;
boolean comKey = false;

boolean event = true;

void setup(){
  size(450, 500);
  
  GComponent.globalFont = GFont.getFont(this, "Courier", 14);
  textEditor = new GTextField(this, "color($r$, $g$, $b$, $a255$);", 20, 445, 296, 20, false);
  
  graphics = new Graphics();
  inputController = new InputController();
  
  bg = loadImage("/data/bg.png");
  
  noSmooth();
}

void draw(){
  if(event){
    textSize(12);
    background(bg);
    graphics.draw();
    
    fill(50);
    textSize(10);
    text("mod: $r$, $g$, $b$, $a1$, $a255$, $hex$, $ahex$, $h$, $s$, $b$", 20, 490);
    
    event = false;
  }
}

///////////////////////////////////////////

void mouseDragged(){
  inputController.dragging(mouseX, mouseY);
  event = true;
}

void mouseMoved(){
  inputController.moved(mouseX, mouseY);
  event = true;
}

void mousePressed(){
  //graphics.focus();
  inputController.dragging(mouseX, mouseY);
  event = true;
}

void mouseReleased(){
  inputController.released(mouseX, mouseY);
  event = true;
}

void keyPressed(){
  if(key == CODED){
    if(keyCode == LEFT){
      graphics.swatchViewer.left();
    } else if(keyCode == RIGHT){
      graphics.swatchViewer.right();
    } else if(keyCode == DOWN){
      graphics.swatchViewer.down();
    } else if(keyCode == UP){
      graphics.swatchViewer.up();
    }
    event = true;
  }
}

void exit(){
  graphics.swatchViewer.saveSwatches();
  super.exit();
}
