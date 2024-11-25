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
#import <AVKit/AVKit.h>
#endif




template<typename resultsType>
class ofxVisionObjectDetection_{
public:
    //    ofxVisionObjectDetection_();
    virtual void detect(ofPixels & image);
    
    ///\brief load a core ML model.
    ///\param modelPath file path to the model to load
    ///\param resultsType The type of result that the model will generate. this depends purely on the model you use. For example, yolo uses DETECTION_RECT.
    ///\param loadLabels load the labels from the MLModel (YOLO has)
    ///\return true if successfully loaded, false otherwise
    bool loadModel(const std::string& modelPath, bool loadLabels = false);
    
    const resultsType& getDetectionResults(){return detectionResults;}
    
    void draw(const ofRectangle& rect);
protected:
#ifdef __OBJC__
    void detect_(CGImageRef image);
    
    void processResults(NSArray* results);

    ObjectRecognition * objectRecognition;
    
#else
    void * objectRecognition;
    
#endif
    resultsType detectionResults;
};

class ofxVisionDetection:
public ofxVisionObjectDetection_<ofxVision::RectsCollection>
{
public:
    ofxVisionDetection();
    virtual void detect(ofPixels & image) override;

    ofParameter<bool> detectAnimal = {"Detect Animal", false};
    ofParameter<bool> detectText = {"Detect Text", false};
    ofParameter<bool> detectHand = {"Detect Hand", false};
    ofParameter<bool> detectFace = {"Detect Face", true};
    ofParameter<bool> detectBody = {"Detect Body", false};
    ofParameter<bool> detectBody3D = {"Detect Body3D", false};
    ofParameter<bool> recognizeObjects = {"Recognize Objects", true};
    ofParameterGroup parameters = {"ofxVision Detect", recognizeObjects, detectAnimal, detectText, detectHand, detectFace, detectBody, detectBody3D};
    
    
    void draw(const ofRectangle& rect);
    
    ///\brief load a core ML model.
    ///\param modelPath file path to the model to load
    ///\param resultsType The type of result that the model will generate. this depends purely on the model you use. For example, yolo uses DETECTION_RECT.
    ///\return true if successfully loaded, false otherwise
//    bool loadModel(const std::string& modelPath);
    

    const ofxVision::RectsCollection& getObjectDetections(){return getDetectionResults();}
    const ofxVision::RectsCollection & getAnimalResults(){return animalResults;}
    const ofxVision::PointsCollection& getBodyResults(){return bodyResults;}
    const ofxVision::Body3DCollection& getBody3DResults(){return body3DResults;}
    const ofxVision::RectsCollection& getTextResults(){return textResults;}
    const ofxVision::PointsCollection& getHandResults(){return handResults;}
    const ofxVision::FaceDetectionsCollection& getFaceResults(){return faceResults;}
    
protected:
//    ofxVision::DetectionResultsType objectResultsType = ofxVision::DETECTION_RECT_COLLECTION;
#ifdef __OBJC__
//    ObjectRecognition * objectRecognition;
    Detection* detection ;
    
    
#else
//    void * objectRecognition;
    void * detection;
#endif
    
    
//    ofxVision::RectsCollection rectObjectDetections;
    
        ofxVision::RectsCollection  animalResults;
        ofxVision::PointsCollection bodyResults;
        ofxVision::Body3DCollection body3DResults;
        ofxVision::RectsCollection textResults;
        ofxVision::PointsCollection handResults;
        ofxVision::FaceDetectionsCollection faceResults;
        
};
//#endif


