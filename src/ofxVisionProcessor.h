//
//  Segmentation.h
//  example
//
//  Created by Roy Macdonald on 19-03-24.
//

#ifndef Segmentation_h
#define Segmentation_h


#include "ofMain.h"

#ifdef __OBJC__
#import "Segmentation.h"

#endif

#include "ofxVisionDetections.h"



class ofxVisionProcessor{
public:
    ofxVisionProcessor();
    void detect(ofPixels & image);

    const ofPixels& getMask();
    const ofTexture& getMaskTexture();
    
    void drawMask(const ofRectangle& rect);
    void drawMask(const glm::vec2& pos, float width, float height);
    void drawMask(float x, float y, float width, float height);
    
    void drawFaceDet(const ofRectangle& offset);
    
    
    
    
    ofParameter<bool> bSegmentIndividuals = {"Segment individual persons", false};
    ofParameter<int> segmentationQuality = {"Quality", 1, 1, 3  };
    
    ofParameterGroup segmentationParamGroup = {"Segmentation", bSegmentIndividuals, segmentationQuality};
    
    ofParameter<bool> detectAnimal = {"Detect Animal", false};
    ofParameter<bool> detectText = {"Detect Text", false};
    ofParameter<bool> detectHand = {"Detect Hand", false};
    ofParameter<bool> detectFace = {"Detect Face", true};
    ofParameter<bool> detectBody = {"Detect Body", false};
    
    ofParameterGroup detectionParamGroup = {"Detection", detectAnimal, detectText, detectHand, detectFace, detectBody};
    
    ofParameterGroup parameters = {"ofxVision", detectionParamGroup, segmentationParamGroup};
    
    
protected:

    ofEventListener qualityListener;
    ofxVision::FaceDetectionsCollection faceDet;
    
    void processFaceDet();
    
    ofPixels segmentationMask;
    ofTexture segmentationTexture;
    
#ifdef __OBJC__
    Segmentation* segmentation ;
#else
    void * segmentation;
#endif
    
    int inputImgW, inputImgH;
    
};


#endif /* Segmentation_h */
