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
class Animal{
public:

    void processResults(NSArray*  results, float imgWidth, float imgHeight);
    
    ofxVision::RectsCollection  detections;
    
    void draw(){
//        for(auto & d: detections){
//            d.draw( true, false, false);
//        }
    }
};
}
//#endif /* animal_h */
