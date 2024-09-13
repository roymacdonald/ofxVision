#pragma once

#include "ofMain.h"
#include "ofxVisionDetection.h"

#ifdef TARGET_OPENGLES
#include "ofxiOS.h"
class ofApp : public ofxiOSApp {
#else
class ofApp : public ofBaseApp {
#endif
public:
    ofxVisionDetection detection;
    ofVideoGrabber grabber;
    ofEasyCam camera;
    bool show_3d = false;
    void setup();
    void update();
    void draw();
    void exit();
#ifdef TARGET_OPENGLES
    void touchDown(ofTouchEventArgs & touch) override;
    void touchMoved(ofTouchEventArgs & touch) override;
    void touchUp(ofTouchEventArgs & touch) override;
    void touchDoubleTap(ofTouchEventArgs & touch) override;
    void touchCancelled(ofTouchEventArgs & touch) override;

    void lostFocus() override;
    void gotFocus() override;
    void gotMemoryWarning() override;
    void deviceOrientationChanged(int newOrientation) override;
    void launchedWithURL(std::string url) override;
#else
    void keyPressed(int key);
    void keyReleased(int key);
    void mouseMoved(int x, int y);
    void mouseDragged(int x, int y, int button);
    void mousePressed(int x, int y, int button);
    void mouseReleased(int x, int y, int button);
    void mouseScrolled(int x, int y, float scrollX, float scrollY);
    
    void mouseEntered(int x, int y);
    void mouseExited(int x, int y);
    void windowResized(int w, int h);
    void gotMessage(ofMessage msg);
    void dragEvent(ofDragInfo dragInfo);
#endif
};
