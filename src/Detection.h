//
//  Detection.h
//  example
//
//  Created by Roy Macdonald on 20-03-24.
//

#pragma once


#import <Foundation/Foundation.h>
#import <Vision/Vision.h>
#import <AVKit/AVKit.h>
#include "ofxVisionConstants.h"

@interface Detection
: NSObject
{
    
//    VNSequenceRequestHandler *handler;
    
    VNRecognizeAnimalsRequest *animalReq;
    VNRecognizeTextRequest *textReq ;
    VNDetectHumanHandPoseRequest *handReq;
    VNDetectFaceLandmarksRequest *faceReq;
    VNDetectHumanBodyPoseRequest *bodyReq;
#ifdef OFX_VISON_ENABLE_3D_BODY
    VNDetectHumanBodyPose3DRequest *body3DReq;
#endif
}

-(NSArray * ) animalResults;
-(NSArray * ) textResults;
-(NSArray * ) handResults;
-(NSArray * ) faceResults;
-(NSArray * ) bodyResults;
-(NSArray * ) body3DResults;
#ifdef OFX_VISON_ENABLE_3D_BODY
-(BOOL)detect:(CGImageRef)image detectAnimal:(BOOL) bAnimal detectText:(BOOL) bText detectHand:(BOOL) bHand detectFace:(BOOL) bFace detectBody:(BOOL) bBody detectBody3D:(BOOL) bBody3D;
#else
-(BOOL)detect:(CGImageRef)image detectAnimal:(BOOL) bAnimal detectText:(BOOL) bText detectHand:(BOOL) bHand detectFace:(BOOL) bFace detectBody:(BOOL) bBody;
#endif


@end


