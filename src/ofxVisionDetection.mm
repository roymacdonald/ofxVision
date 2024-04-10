//
//  ofxVisionDetection.m
//  example
//
//  Created by Roy Macdonald on 20-03-24.
//
#include "ofxVisionDetection.h"
#include "ofxVisionHelpers.h"

//#pragma clang diagnostic ignored "-Wunguarded-availability"



ofxVisionDetection::ofxVisionDetection(){
    
//    NSString * s = [NSString stringWithUTF8String:""];
//    objectRecognition = [[ObjectRecognition alloc] initWithModelPath: ];
//    detection = [[Detection alloc] init];
//  tracker = [[Face alloc] init];
}

bool ofxVisionDetection::loadModel(const std::string& modelPath){
   
    NSString * s = [NSString stringWithUTF8String:modelPath.c_str()];
    objectRecognition = [[ObjectRecognition alloc] initWithModelPath: s];
    return (objectRecognition != nil);
    
}

//const ofPixels&
void ofxVisionDetection::detect(ofPixels &pix)
{
    if(!objectRecognition){
        ofLogError("ofxVisionDetection::detect", "model not loaded. Call ofxVisionDetection::loadModel(...) before calling this method");
        return;
    }
//    cout << "ofxVisionDetection::detect...";
    CGImageRef image = ofxVisionHelper::CGImageRefFromOfPixels(pix,(int)pix.getWidth(),(int)pix.getHeight(),(int)pix.getNumChannels());
    
    if([objectRecognition process:image]){
        objectDetections.detections.clear();
        for(VNRecognizedObjectObservation *observation in [objectRecognition results]){
            
            CGFloat x = observation.boundingBox.origin.x;
            CGFloat y = (1-observation.boundingBox.origin.y-observation.boundingBox.size.height);
            CGFloat w = observation.boundingBox.size.width;
            CGFloat h = observation.boundingBox.size.height;
            
            
            ofxVision::RectDetection det(x,y,w,h,0);
            
            
            if (observation.labels.count > 0){
                det.label =  [observation.labels[0].identifier UTF8String];
                det.score =  observation.labels[0].confidence ;
            }
//            det.print();
            objectDetections.detections.push_back(det);
        }
    }
//    [detection detect:image
//         detectAnimal: this->detectAnimal.get()
//           detectText: this->detectText.get()
//           detectHand: this->detectHand.get()
//           detectFace: this->detectFace.get()
//           detectBody: this->detectBody.get() ];
//    
//        float p_w = pix.getWidth();
//        float p_h = pix.getHeight();

//    if( this->detectFace.get() && !faceResults) { faceResults = std::make_unique<ofxVision::Face>();}
    
//        if( this->detectAnimal.get() ) { animalResults.processResults([detection animalResults], w, h); }
//        if( this->detectText.get() ) { textResults.processResults([detection textResults], w, h); }
//        if( this->detectHand.get() ) { handResults.processResults([detection handResults], w, h); }
//        if( this->detectFace.get() ) { faceResults->processResults([detection faceResults], p_w, p_h); }
//        if( this->detectBody.get() ) { bodyResults.processResults([detection bodyResults], w, h); }
//    cout << "done\n";
//    points.resize(2);
 
    
    
    
    CGImageRelease(image);
}
void ofxVisionDetection::draw(const ofRectangle& rect){
    objectDetections.draw(rect, true, true);
//    if( this->detectAnimal.get() ) { animalResults.draw(); }
//    if( this->detectText.get() ) { textResults.draw(); }
//    if( this->detectHand.get() ) { handResults.draw(); }
//    if( this->detectFace.get() && faceResults ) { faceResults->draw(); }
//    if( this->detectBody.get() ) { bodyResults.draw(); }
    
//    if( this->detectFace.get() ){ faceDetections.draw(); }
    
}
// const ofTexture& ofxVisionDetection::getMaskTexture(){
//     return segmentationTexture;
// }
// const ofPixels& ofxVisionDetection::getMask(){
//     return segmentationMask;
// }

// void ofxVisionDetection::drawMask(const ofRectangle& rect){
//     drawMask(rect.x, rect.y, rect.width, rect.height);
// }

// void ofxVisionDetection::drawMask(const glm::vec2& pos, float width, float height){
//     drawMask(pos.x, pos.y, width, height);
// }

// void ofxVisionDetection::drawMask(float x, float y, float width, float height){
//     if(segmentationTexture.isAllocated()){
//         segmentationTexture.draw(x, y, width, height);
//     }
// }

