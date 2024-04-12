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
    
    
    
    const ofxVision::RectsCollection& getObjectDetections(){return objectDetections;}
    const ofxVision::RectsCollection & getAnimalResults(){return animalResults;}
    const ofxVision::PointsCollection& getBodyResults(){return bodyResults;}
    const ofxVision::RectsCollection& getTextResults(){return textResults;}
    const ofxVision::PointsCollection& getHandResults(){return handResults;}
    const ofxVision::FaceDetectionsCollection& getFaceResults(){return faceResults;}
    
protected:
    
#ifdef __OBJC__
    ObjectRecognition * objectRecognition;
    Detection* detection ;
    
    
#else
    void * objectRecognition;
    void * detection;
#endif
    
    
    ofxVision::RectsCollection objectDetections;
    
        ofxVision::RectsCollection  animalResults;
        ofxVision::PointsCollection bodyResults;
        ofxVision::RectsCollection textResults;
        ofxVision::PointsCollection handResults;
        ofxVision::FaceDetectionsCollection faceResults;
        
};
//#endif


