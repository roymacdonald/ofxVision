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

class ofxVisionSegmentation{
public:
    ofxVisionSegmentation();
    void detect(ofPixels & image);

    const ofPixels& getMask();
    const ofTexture& getMaskTexture();
    
    void drawMask(const ofRectangle& rect);
    void drawMask(const glm::vec2& pos, float width, float height);
    void drawMask(float x, float y, float width, float height);
    
protected:
    
    
    ofPixels segmentationMask;
    ofTexture segmentationTexture;
    
#ifdef __OBJC__
    Segmentation* segmentation ;
#else
    void * segmentation;
#endif
    
    
};


#endif /* Segmentation_h */
