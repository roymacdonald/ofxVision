//
//  hand.m
//  CoreMLBody
//
//  Created by lingdong on 10/19/21.
//  based on https://github.com/pierdr/ofxiosfacetracking
//       and https://github.com/pambudi02/objc_handgesture

#include "body.h"
#include "constants.h"
#import <Vision/Vision.h>

namespace ofxVision{
//
void setDetection(std::vector<ofxVision::PointsDetection>& detections, size_t index, VNRecognizedPoint * point, float imgWidth, float imgHeight){
    detections.back().setPoint(index, point.location.x, point.location.y, point.confidence, imgWidth, imgHeight);
}

void Body::processResults(NSArray *  results, float imgWidth, float imgHeight)
{
    //  CGImageRef image = CGImageRefFromOfPixels(pix,(int)pix.getWidth(),(int)pix.getHeight(),(int)pix.getNumChannels());
    //  NSArray* arr = [tracker detect:image];
    NSError *err;
    
    detections.clear();
    
    for(VNHumanBodyPoseObservation *observation in results){
        NSDictionary <VNHumanBodyPoseObservationJointName, VNRecognizedPoint *> *allPts = [observation recognizedPointsForJointsGroupName:VNHumanBodyPoseObservationJointsGroupNameAll error:&err];
        detections.push_back(ofxVision::PointsDetection(BODY_N_PART));
        detections.back().score = observation.confidence;
        
        setDetection(detections, BODY_NOSE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameNose], imgWidth, imgHeight);
        setDetection(detections, BODY_LEFTEYE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftEye], imgWidth, imgHeight);
        setDetection(detections, BODY_RIGHTEYE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightEye], imgWidth, imgHeight);
        setDetection(detections, BODY_LEFTEAR  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftEar], imgWidth, imgHeight);
        setDetection(detections, BODY_RIGHTEAR  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightEar], imgWidth, imgHeight);
        setDetection(detections, BODY_LEFTWRIST  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftWrist], imgWidth, imgHeight);
        setDetection(detections, BODY_RIGHTWRIST  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightWrist], imgWidth, imgHeight);
        setDetection(detections, BODY_LEFTELBOW  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftElbow], imgWidth, imgHeight);
        setDetection(detections, BODY_RIGHTELBOW  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightElbow], imgWidth, imgHeight);
        setDetection(detections, BODY_LEFTSHOULDER  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftShoulder], imgWidth, imgHeight);
        setDetection(detections, BODY_RIGHTSHOULDER  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightShoulder], imgWidth, imgHeight);
        setDetection(detections, BODY_LEFTHIP  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftHip], imgWidth, imgHeight);
        setDetection(detections, BODY_RIGHTHIP  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightHip], imgWidth, imgHeight);
        setDetection(detections, BODY_LEFTKNEE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftKnee], imgWidth, imgHeight);
        setDetection(detections, BODY_RIGHTKNEE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightKnee], imgWidth, imgHeight);
        setDetection(detections, BODY_LEFTANKLE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftAnkle], imgWidth, imgHeight);
        setDetection(detections, BODY_RIGHTANKLE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightAnkle], imgWidth, imgHeight);
        
        detections.back().updateRect();
        
       
        
    }
}
}
