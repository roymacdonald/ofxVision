#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

    ofDisableArbTex();
    cam.setup(640, 480);

    setViews();
    
    gui.setup(segmentation.parameters);
    

    if(ofIsGLProgrammableRenderer()){
        shader.load("shadersGL3/shader");
    }else{
        shader.load("shadersGL2/shader");
    }

}

//--------------------------------------------------------------
void ofApp::update(){
  cam.update();
  if (cam.isFrameNew()){
      segmentation.detect(cam.getPixels());

  }
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    cam.draw(camRect);
    
    segmentation.drawMask(maskRect);
    
   
    
    ofDrawRectangle(compositeRect);
    if(segmentation.getMaskTexture().isAllocated()){
        shader.begin();
        shader.setUniformTexture("imageMask", segmentation.getMaskTexture(), 1);
        cam.draw(compositeRect);
        shader.end();
    }
    
    
    if(bDrawGui){
        gui.draw();
    }
}


//--------------------------------------------------------------
void ofApp::setViews(){
    
    // Just getting a fancier layout.
    
    float w =  ofGetWidth()/3;
    leftView.set(0,0, 2 *w, ofGetHeight());
    rightView.set(2 *w, 0, w, ofGetHeight());
    
    camRect.set(0,0,cam.getWidth(), cam.getHeight());
    camRect.scaleTo(leftView);
    
    maskRect = camRect;
    maskRect.scaleTo(rightView, OF_ASPECT_RATIO_KEEP,OF_ALIGN_HORZ_CENTER, OF_ALIGN_VERT_CENTER,  OF_ALIGN_HORZ_CENTER, OF_ALIGN_VERT_BOTTOM);
    
    compositeRect = camRect;
    compositeRect.scaleTo(rightView, OF_ASPECT_RATIO_KEEP,OF_ALIGN_HORZ_CENTER, OF_ALIGN_VERT_CENTER,  OF_ALIGN_HORZ_CENTER, OF_ALIGN_VERT_TOP);
    
    
}


//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){
    setViews();
}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
