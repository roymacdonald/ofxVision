//
//  ofxVisionDetection.h
//  example
//
//  Created by Roy Macdonald on 20-03-24.
//

#ifndef ofxVisionDetection_h
#define ofxVisionDetection_h

#include "ofPixels.h"
#include "ofParameter.h"
#include "ofMain.h"

//#include "ofParameterGroup.h"

#ifdef __OBJC__
//#include "face.h"
//#include "body.h"
//#include "text.h"
//#include "hand.h"
//#include "animal.h"

//#import "Detection.h"
#import "ObjectRecognition.h"
#endif

#include "ofxVisionDetections.h"

class ofxVisionDetection{
public:
    ofxVisionDetection();
    void detect(ofPixels & image);


//    ofParameter<bool> detectAnimal = {"Detect Animal", false};
//    ofParameter<bool> detectText = {"Detect Text", false};
//    ofParameter<bool> detectHand = {"Detect Hand", false};
//    ofParameter<bool> detectFace = {"Detect Face", true};
//    ofParameter<bool> detectBody = {"Detect Body", false};
//    
//    ofParameterGroup parameters = {"ofxVision Detect", detectAnimal, detectText, detectHand, detectFace, detectBody};
    
    
    void draw(const ofRectangle& rect);
    
    bool loadModel(const std::string& modelPath);
    ofxVision::RectsCollection objectDetections;
    
protected:
    
    
//    ofPixels segmentationMask;
//    ofTexture segmentationTexture;
    
#ifdef __OBJC__
    ObjectRecognition * objectRecognition;
//    Detection* detection ;
//    ofxVision::Animal  animalResults;
//    std::unique_ptr<ofxVision::Face>  faceResults = nullptr;
//    ofxVision::FaceDetectionsCollection faceDetections;
    
//
//    std::vector<glm::vec3> points;
//    ofxVision::Body  bodyResults;
//    ofxVision::Text  textResults;
//    ofxVision::Hand  handResults;
//    ofxVision::Face  faceResults;
    
//    VNSequenceRequestHandler *handler;
    
#else
    void * objectRecognition;
//    void * detection;
#endif
    
    
//    ofxVision::Animal  animalResults;
};

#endif /* ofxVisionDetection_h */
