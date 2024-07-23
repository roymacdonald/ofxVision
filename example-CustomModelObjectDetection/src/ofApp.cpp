#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

    auto res = ofSystemLoadDialog("choose the model to use");
    if(res.bSuccess){
        if(!detection.loadModel(res.getPath())){
            
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
      detection.detect(cam.getPixels());
  }
}

//--------------------------------------------------------------
void ofApp::draw(){
    cam.draw(camRect);
//    detection.draw(camRect);
    stringstream ss;
    auto& res = detection.getDetectionResults();
    if(res.detections.size()){
        for(auto& d: res.detections){
            ss << "Label: " << d.label << " score: " << d.score << "\n";
        }
    }else{
        ss << "Nothing detected!";
    }
    ofDrawBitmapStringHighlight(ss.str(), 20,30);
}


//--------------------------------------------------------------
void ofApp::setViews(){
    
    ofRectangle s(0,0, ofGetWidth(), ofGetHeight());
    
    camRect.set(0,0,cam.getWidth(), cam.getHeight());
    camRect.scaleTo(s);

    
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
