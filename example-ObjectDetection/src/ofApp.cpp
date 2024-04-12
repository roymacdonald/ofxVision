#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){

    auto res = ofSystemLoadDialog("choose the model to use");
    if(res.bSuccess){
        if(!detection.loadModel(res.getPath())){
            
            ofExit();
        }
    }

    gui.setup(detection.parameters);
    
    ofDisableArbTex();
    cam.setup(640, 480);

    setViews();
    

}

//--------------------------------------------------------------
void ofApp::update(){
  cam.update();
  if (cam.isFrameNew()){
      detection.detect(cam.getPixels());
      /*
      if(detection.detectHand){
          auto & hands = detection.getHandResults();
          //hands.detections.size() gives you the number of detected hands
          for(auto& hand: hands.detections){
              // hand.points[HAND_WRIST]. this is a glm::vec3 use the defines in ofxVisionConstants.h to access the different parts of the hand.
            // the z coordinate contains the confidence value of the detected part. ignore it for calculations or drawing
                            
          }
      }
      //*/
      /*
      if(detection.recognizeObjects){
          
          
          for(auto& object : detection.getObjectDetections().detections){
              /// you can filter here based on any of the following
              object.label; //std::string
              object.rect; // ofRectangle // IMPORTANT. the values of these are normalized. you need to multiply by the size of the image in order to get it in pixelspace.
              object.score; // float. I think it is normalized. higher values mean more possibility that the object is the one in the label
          }
          
          
      }
      
   //*/
  }
}

//--------------------------------------------------------------
void ofApp::draw(){
    
    cam.draw(camRect);
    
    detection.draw(camRect);

    
    if(bDrawGui){
        gui.draw();
    }
}


//--------------------------------------------------------------
void ofApp::setViews(){
    
    ofRectangle leftView(0,0, ofGetWidth(), ofGetHeight());
    
    camRect.set(0,0,cam.getWidth(), cam.getHeight());
    camRect.scaleTo(leftView);

    
}


//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
    if(key == 'g'){bDrawGui ^= true;}
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
