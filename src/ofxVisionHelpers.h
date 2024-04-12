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
