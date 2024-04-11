////
////  hand.m
////  CoreMLHand
////
////  Created by lingdong on 10/19/21.
////  based on https://github.com/pierdr/ofxiosfacetracking
////       and https://github.com/pambudi02/objc_handgesture
//
//#include "animal.h"
//#import <Vision/Vision.h>
//
//namespace ofxVision {
//
//
//void Animal::processResults(NSArray *  results, float imgWidth, float imgHeight)
//{
//    
////    detections.clear();
////    for(VNRecognizedObjectObservation *observation in results){
////        CGFloat x = imgWidth*observation.boundingBox.origin.x;
////        CGFloat y = imgHeight*(1-observation.boundingBox.origin.y-observation.boundingBox.size.height);
////        CGFloat w = imgWidth*observation.boundingBox.size.width;
////        CGFloat h = imgHeight*observation.boundingBox.size.height;
//////        int N = 0;
////        
////        detections.push_back(ofxVision::RectDetection(x,y,w,h, observation.confidence) );
////        
////        for (int i = 0; i < observation.labels.count; i++){
////            std::string text = [observation.labels[i].identifier UTF8String];
////            if(i < observation.labels.count -1){
////                text += ", ";
////            }
////            detections.back().label += text;
////        }
////        
//        
////        detections[n_det] = ofRectangle();
////        scores[n_det] = observation.confidence;
////        n_det++;
////    }
//    
////    CGImageRelease(image);
//}
//
//
//}
//    
