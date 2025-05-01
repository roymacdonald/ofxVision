//
//  ofxVisionDepth.hpp
//  example-depth-anything
//
//  Created by Roy Macdonald on 30-04-25.
//

#pragma once
#include "ofMain.h"
#ifdef __OBJC__

#import <CoreML/CoreML.h>

#endif


class ofxVisionDepth{
public:
    bool loadModel(const std::string& modelUrl);
    void detect(ofPixels& pixels);
    void draw(const ofRectangle & rect = ofRectangle(0,0,0,0));
    static constexpr int resultWidth = 518;
    static constexpr int resultHeight = 392;
    const ofShortImage& getDepthImage(){return depthImage;}
    const ofShortPixels& getDepthPixels(){return depthImage.getPixels();}
private:
    ofShortImage depthImage;
    bool bPixelsUpdated = false;
    bool bModelLoaded = false;
    int _pixWidth = 0;
    int _pixHeight = 0;
#ifdef __OBJC__
    MLModel *model;
#else
    void *model;
#endif
};
