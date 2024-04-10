//
//  hand.h
//  CoreMLHand
//
//  Created by lingdong on 10/19/21.
//  based on https://github.com/pierdr/ofxiosfacetracking
//       and https://github.com/pambudi02/objc_handgesture

//#ifndef text_h
//#define text_h

#pragma once
//#include "ofMain.h"
#import <Foundation/Foundation.h>
//#import <Vision/Vision.h>
//#import <AVKit/AVKit.h>

//#include "constants.h"
#include "ofxVisionDetections.h"

namespace ofxVision{
class Text{
public:
//    Text(){}
    void processResults(NSArray *  results, float imgWidth, float imgHeight);
    
    std::vector<ofxVision::RectDetection > detections;
    
    void draw(){
        for(auto & d: detections){
            d.draw(true, true, false);
        }
    }
};
}
//#endif /* text_h */
