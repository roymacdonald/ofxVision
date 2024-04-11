//
//  ofxVisionDetection.h
//  example
//
//  Created by Roy Macdonald on 20-03-24.
//

#pragma once

#include "ofxVisionResults.h"


#ifdef __OBJC__

#import "Detection.h"
#import "ObjectRecognition.h"
#endif



class ofxVisionDetection{
public:
    ofxVisionDetection();
    void detect(ofPixels & image);


    ofParameter<bool> detectAnimal = {"Detect Animal", false};
    ofParameter<bool> detectText = {"Detect Text", false};
    ofParameter<bool> detectHand = {"Detect Hand", false};
    ofParameter<bool> detectFace = {"Detect Face", true};
    ofParameter<bool> detectBody = {"Detect Body", false};
    ofParameter<bool> recognizeObjects = {"Recognize Objects", true};
    ofParameterGroup parameters = {"ofxVision Detect", recognizeObjects, detectAnimal, detectText, detectHand, detectFace, detectBody};
    
    
    void draw(const ofRectangle& rect);
    
    bool loadModel(const std::string& modelPath);
    
    ofxVision::RectsCollection objectDetections;
    
    
protected:
    
    
//    ofPixels segmentationMask;
//    ofTexture segmentationTexture;
    
#ifdef __OBJC__
    ObjectRecognition * objectRecognition;
    Detection* detection ;
    
//    ofxVision::Animal  animalResults;
    
//    std::unique_ptr<ofxVision::Face>  faceResults = nullptr;
//    ofxVision::FaceDetectionsCollection faceDetections;
    
//

    
#else
    void * objectRecognition;
    void * detection;
#endif
    
    //    std::vector<glm::vec3> points;
        ofxVision::RectsCollection  animalResults;
        ofxVision::PointsCollection bodyResults;
        ofxVision::RectsCollection textResults;
        ofxVision::PointsCollection handResults;
        ofxVision::FaceDetectionsCollection faceResults;
        
};
//#endif


