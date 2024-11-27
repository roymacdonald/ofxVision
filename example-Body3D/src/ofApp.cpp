#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
    camera.setPosition(0, 0, 5);
    camera.setNearClip(0.0001);
#ifdef TARGET_OPENGLES
    grabber.setDeviceID(1); // TrueDepth camera
    grabber.setup(480, 640);
#else
    grabber.setup(640, 480);
#endif
    detection.detectFace.set(false);
    detection.recognizeObjects.set(false);
#ifdef OFX_VISON_ENABLE_3D_BODY
    detection.detectBody3D.set(true);
#else
    ofLogError("ofApp::setup") << "3D body detection is either disabled or not available on your system. needs macos >= 14.0 or ios >= 17.0";
#endif
}

//--------------------------------------------------------------
void ofApp::update(){
    grabber.update();
    
    if(grabber.isFrameNew())
    {
        detection.detect(grabber.getPixels());
    }
}

//--------------------------------------------------------------
void ofApp::draw(){
    float w = ofGetWidth();
    float h = grabber.getHeight() * w / grabber.getWidth();
    float x = 0;
    float y = (ofGetHeight() - h) * 0.5;
    
    if(!show_3d)
    {
        grabber.draw(x, y, w, h);
        detection.draw(ofRectangle(x, y, w, h));
    }
    else
    {
        camera.begin();
        ofPushStyle();
        ofSetColor(255);
        
        ofxVision::Body3DCollection results = detection.getBody3DResults();
        for(auto & body: results.detections)
        {
            body.camera.draw();
            for(int i = 0; i < body.points.size(); i++)
            {
                ofDrawSphere(body.points3D[i].getGlobalPosition(), 0.01);
            }
        }
        ofPopStyle();
        camera.end();
    }
    
    ofDrawBitmapString("show 3d: " + ofToString(show_3d), 50, ofGetHeight() - 50);
}

//--------------------------------------------------------------
void ofApp::exit(){

}

#ifdef TARGET_OPENGLES
//--------------------------------------------------------------
void ofApp::touchDown(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchMoved(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchUp(ofTouchEventArgs & touch){

}

//--------------------------------------------------------------
void ofApp::touchDoubleTap(ofTouchEventArgs & touch){
    show_3d = !show_3d;
}

//--------------------------------------------------------------
void ofApp::touchCancelled(ofTouchEventArgs & touch){
    
}

//--------------------------------------------------------------
void ofApp::lostFocus(){

}

//--------------------------------------------------------------
void ofApp::gotFocus(){

}

//--------------------------------------------------------------
void ofApp::gotMemoryWarning(){

}

//--------------------------------------------------------------
void ofApp::deviceOrientationChanged(int newOrientation){

}

//--------------------------------------------------------------
void ofApp::launchedWithURL(std::string url){

}
#else
//--------------------------------------------------------------
void ofApp::keyPressed(int key){
    if(key == ' ')
    {
        show_3d = !show_3d;
    }
}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){

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
void ofApp::mouseScrolled(int x, int y, float scrollX, float scrollY){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}
#endif
