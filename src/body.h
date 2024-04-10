//
//  hand.h
//  CoreMLHand
//
//  Created by lingdong on 10/19/21.
//  based on https://github.com/pierdr/ofxiosfacetracking
//       and https://github.com/pambudi02/objc_handgesture


#pragma once

#import <Foundation/Foundation.h>

#include "ofxVisionDetections.h"


namespace ofxVision{
class Body{
public:
//    Body();
    void processResults(NSArray*  results, float imgWidth, float imgHeight);
    
//    std::vector<std::vector<ofxVision::PointDetection >> detections;
    std::vector<ofxVision::PointsDetection> detections;
    //  ofVec3f detections[MAX_DET][BODY_N_PART];
//    std::vector<float> scores;
    //  int n_det = 0;
    
    void draw(){
        for(auto & d: detections){
//            d.draw(true, true, false, false);
        }
    }
    
protected:
    
//    void setDetection(size_t index, VNRecognizedPoint * point, float imgWidth, float imgHeight);
    
    
//    Body* tracker;
    
};
}
//#endif /* body_h */
