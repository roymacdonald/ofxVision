//
//  Segmentation.m
//  example
//
//  Created by Roy Macdonald on 19-03-24.
//

#include "ofxVisionSegmentation.h"
#include "ofxVisionHelpers.h"

//#pragma clang diagnostic ignored "-Wunguarded-availability"



ofxVisionSegmentation::ofxVisionSegmentation(){
    
    segmentation = [[Segmentation alloc] init];
//  tracker = [[Face alloc] init];
}

//const ofPixels& 
void ofxVisionSegmentation::detect(ofPixels &pix)
{
    CGImageRef image = ofxVisionHelper::CGImageRefFromOfPixels(pix,(int)pix.getWidth(),(int)pix.getHeight(),(int)pix.getNumChannels());
    

    ofxVisionHelper::ofPixelsFromCVPixelBufferRef([segmentation detect:image], segmentationMask);
 
    if(segmentationMask.isAllocated()){
        if(segmentationTexture.isAllocated() || (segmentationMask.getWidth() != segmentationTexture.getWidth()) || (segmentationMask.getHeight() != segmentationTexture.getHeight())){
            if(segmentationMask.getWidth() > 0 && segmentationMask.getHeight() > 0){
                
                segmentationTexture.allocate(segmentationMask);
            }
        }
    }
    CGImageRelease(image);
}

const ofTexture& ofxVisionSegmentation::getMaskTexture(){
    return segmentationTexture;
}
const ofPixels& ofxVisionSegmentation::getMask(){
    return segmentationMask;
}

void ofxVisionSegmentation::drawMask(const ofRectangle& rect){
    drawMask(rect.x, rect.y, rect.width, rect.height);
}

void ofxVisionSegmentation::drawMask(const glm::vec2& pos, float width, float height){
    drawMask(pos.x, pos.y, width, height);
}

void ofxVisionSegmentation::drawMask(float x, float y, float width, float height){
    if(segmentationTexture.isAllocated()){
        segmentationTexture.draw(x, y, width, height);
    }
}
