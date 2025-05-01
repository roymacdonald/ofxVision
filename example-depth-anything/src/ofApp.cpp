#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

    auto res = ofSystemLoadDialog("Select DepthAnythingV2SmallF16.mlpackage");
    if(res.bSuccess){
        if(!depth.loadModel(res.getPath())){
            ofExit();
        }
    }

    ofDisableArbTex();
    cam.setup(640, 480);

    setViews();
    

}

//--------------------------------------------------------------
void ofApp::update(){
  cam.update();
  if (cam.isFrameNew()){
      depth.detect(cam.getPixels());
  }
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    cam.draw(camRect);

    depth.draw(depthRect);
 
}


//--------------------------------------------------------------
void ofApp::setViews(){
    
    // Just getting a fancier layout.
    
    float w =  ofGetWidth()/2;
    leftView.set(0,0, w, ofGetHeight());
    rightView.set(w, 0, w, ofGetHeight());
    
    camRect.set(0,0,cam.getWidth(), cam.getHeight());
    camRect.scaleTo(leftView);
    depthRect.set(0,0, ofxVisionDepth::resultWidth, ofxVisionDepth::resultHeight);
    depthRect.scaleTo(rightView);
    
    
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
