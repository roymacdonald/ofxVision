//
//  ofxVisionHelpers.h
//  example
//
//  Created by Roy Macdonald on 19-03-24.
//

#pragma once
#include "ofPixels.h"
#include "ofMath.h"

#import <AVKit/AVKit.h>
#include "ofRectangle.h"

class ofxVisionHelper{
public:
    static CGImageRef CGImageRefFromOfPixels( ofPixels & img, int width, int height, int numberOfComponents );
    
    static void ofPixelsFromCVPixelBufferRef(CVPixelBufferRef buff, ofPixels& pixels);
  
    static ofRectangle toOf(const CGRect &rect);
    
    
};

class ofxVisionAngleColors {
public:
    float red;
    float blue;
    float green;
    
    static float convert(float value, float minValue, float maxValue) {
        
        maxValue = maxValue * 0.8;
        minValue = minValue + (maxValue * 0.2);
        
        if(ofIsFloatEqual(0.0f, maxValue - minValue)){ return 0; } // protect from zero division
        
        return ofMap(value, minValue, maxValue, 0, 1, true);
    }
    
    
    void init(float roll, float pitch, float yaw) {
        auto pi = glm::pi<float>();
        auto halfPi = pi *0.5f;
        red = convert(roll, - pi, pi);
        blue = convert( pitch, -halfPi,  halfPi);
        green = convert( yaw, -halfPi, halfPi);
    }
};

