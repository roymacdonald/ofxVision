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

//const ofPixels& 
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
    
//    processFaceDet();
  
    
}
//void ofxVisionProcessor::processFaceDet(){
//    faceDet.detections.clear();
//    for(VNFaceObservation *observation in [segmentation faceResults]){
//        
////            CGFloat x = observation.boundingBox.origin.x;
////            CGFloat y = (1-observation.boundingBox.origin.y-observation.boundingBox.size.height);
////            CGFloat w = observation.boundingBox.size.width;
////            CGFloat h = observation.boundingBox.size.height;
//
//            auto r = ofxVisionHelper::toOf(observation.boundingBox);
//        
//            faceDet.detections.push_back({});
//            faceDet.detections.back().orientation.x = 0;
//            faceDet.detections.back().orientation.y = [observation.yaw floatValue];
//            faceDet.detections.back().orientation.z = [observation.roll floatValue];
//
//            VNFaceLandmarkRegion2D* landmarks = observation.landmarks.allPoints;
//            const CGPoint * points = landmarks.normalizedPoints;
//            for (int i = 0; i < landmarks.pointCount; i++){
//                faceDet.detections.back().points[i].x = points[i].x * r.width + r.x;
//                faceDet.detections.back().points[i].y = (1-points[i].y) * r.height + r.y;
//                faceDet.detections.back().points[i].z = [landmarks.precisionEstimatesPerPoint[i] floatValue];
//            }
//
//            faceDet.detections.back().updateRect();
//            faceDet.detections.back().score = observation.confidence;
//    }
//}



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
//void ofxVisionProcessor::drawFaceDet(const ofRectangle& rect){
//    faceDet.draw(rect);
//}
