//
//  hand.m
//  CoreMLHand
//
//  Created by lingdong on 10/19/21.
//  based on https://github.com/pierdr/ofxiosfacetracking
//       and https://github.com/pambudi02/objc_handgesture

#include "text.h"
#import <Vision/Vision.h>


namespace ofxVision {

void Text::processResults(NSArray *  results, float imgWidth, float imgHeight)
{
    detections.clear();
        
    for(VNRecognizedTextObservation *observation in results){
        
        
        CGFloat x = imgWidth*observation.boundingBox.origin.x;
        CGFloat y = imgHeight*(1-observation.boundingBox.origin.y-observation.boundingBox.size.height);
        CGFloat w = imgWidth*observation.boundingBox.size.width;
        CGFloat h = imgHeight*observation.boundingBox.size.height;
        
        detections.push_back(ofxVision::RectDetection(x,y,w,h, observation.confidence) );
        
        VNRecognizedText* recognizedText = [observation topCandidates: 1] [0];
        
        detections.back().label += std::string([recognizedText.string UTF8String]);
        
        
    }
    
//    CGImageRelease(image);
}
}
