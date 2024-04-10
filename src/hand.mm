//
//  hand.m
//  CoreMLHand
//
//  Created by lingdong on 10/19/21.
//  based on https://github.com/pierdr/ofxiosfacetracking
//       and https://github.com/pambudi02/objc_handgesture

#include "hand.h"
#import <Vision/Vision.h>
//#pragma clang diagnostic ignored "-Wunguarded-availability"
//
//@implementation Hand
//
//-(NSArray*)detect:(CGImageRef)image{
//
//  VNDetectHumanHandPoseRequest *req = [VNDetectHumanHandPoseRequest new];
//  NSDictionary *d = [[NSDictionary alloc] init];
//  VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:image options:d];
//
//  [handler performRequests:@[req] error:nil];
//
//  return req.results;
//}
//@end
//
//HAND::HAND(){
//  tracker = [[Hand alloc] init];
//}

namespace ofxVision{
//void Hand::setDetection(size_t index, VNRecognizedPoint * point, float imgWidth, float imgHeight){
//    detections.back()[index].point.x = point.location.x * imgWidth;
//    detections.back()[index].point.y = (1- point.location.y) * imgHeight;
//    detections.back()[index].point.z = point.confidence;
//}
void setDetectionHand(std::vector<ofxVision::PointsDetection>& detections, size_t index, VNRecognizedPoint * point, float imgWidth, float imgHeight){
    detections.back().setPoint(index, point.location.x, point.location.y, point.confidence, imgWidth, imgHeight);
}

void Hand::processResults(NSArray *  results, float imgWidth, float imgHeight)
{
    
    //  CGImageRef image = CGImageRefFromOfPixels(pix,(int)pix.getWidth(),(int)pix.getHeight(),(int)pix.getNumChannels());
//    NSArray* arr = [tracker detect:image];
    NSError *err;
    
    detections.clear();
//    n_det = 0;
    for(VNHumanHandPoseObservation *observation in results){
        NSDictionary <VNHumanHandPoseObservationJointName, VNRecognizedPoint *> *allPts = [observation recognizedPointsForJointsGroupName:VNHumanHandPoseObservationJointsGroupNameAll error:&err];
        
        detections.push_back(ofxVision::PointsDetection(HAND_N_PART));
        detections.back().score = observation.confidence;

        
        setDetectionHand(detections, HAND_WRIST, [allPts objectForKey:VNHumanHandPoseObservationJointNameWrist    ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_THUMB0, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbCMC ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_THUMB1, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbMP  ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_THUMB2, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbIP  ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_THUMB3, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbTip ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_INDEX0, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexMCP ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_INDEX1, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexPIP ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_INDEX2, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexDIP ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_INDEX3, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexTip ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_MIDDLE0,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleMCP], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_MIDDLE1,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddlePIP], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_MIDDLE2,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleDIP], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_MIDDLE3,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleTip], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_RING0, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingMCP  ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_RING1, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingPIP  ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_RING2, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingDIP  ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_RING3, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingTip  ], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_PINKY0,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleMCP], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_PINKY1,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittlePIP], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_PINKY2,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleDIP], imgWidth, imgHeight);
        setDetectionHand(detections, HAND_PINKY3,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleTip], imgWidth, imgHeight);
        
        detections.back().updateRect();

        
    }
//    CGImageRelease(image);
}
}
