//
//  Segmentation.m
//  example
//
//  Created by Roy Macdonald on 19-03-24.
//

#include "ofxVisionProcessor.h"
#include "ofxVisionHelpers.h"

//#pragma clang diagnostic ignored "-Wunguarded-availability"



ofxVisionProcessor::ofxVisionProcessor(){
    
    segmentation = [[Segmentation alloc] init];
    
    
    qualityListener = segmentationQuality.newListener([&](int& quality){
        [segmentation setQualityLevel: quality];
    });
}

void ofxVisionProcessor::detect(ofPixels &pix)
{
    
    inputImgW = pix.getWidth();
    inputImgH = pix.getHeight();
        
    
    CGImageRef image = ofxVisionHelper::CGImageRefFromOfPixels(pix,inputImgW, inputImgH,(int)pix.getNumChannels());
    

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


const ofTexture& ofxVisionProcessor::getMaskTexture(){
    return segmentationTexture;
}
const ofPixels& ofxVisionProcessor::getMask(){
    return segmentationMask;
}

void ofxVisionProcessor::drawMask(const ofRectangle& rect){
    drawMask(rect.x, rect.y, rect.width, rect.height);
}

void ofxVisionProcessor::drawMask(const glm::vec2& pos, float width, float height){
    drawMask(pos.x, pos.y, width, height);
}

void ofxVisionProcessor::drawMask(float x, float y, float width, float height){
    if(segmentationTexture.isAllocated()){
        segmentationTexture.draw(x, y, width, height);
    }
}
