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


@interface Detection
: NSObject
{
    
//    VNSequenceRequestHandler *handler;
    
    VNRecognizeAnimalsRequest *animalReq;
    VNRecognizeTextRequest *textReq ;
    VNDetectHumanHandPoseRequest *handReq;
    VNDetectFaceLandmarksRequest *faceReq;
    VNDetectHumanBodyPoseRequest *bodyReq;
    VNDetectHumanBodyPose3DRequest *body3DReq;

}

-(NSArray * ) animalResults;
-(NSArray * ) textResults;
-(NSArray * ) handResults;
-(NSArray * ) faceResults;
-(NSArray * ) bodyResults;
-(NSArray * ) body3DResults;

-(BOOL)detect:(CGImageRef)image detectAnimal:(BOOL) bAnimal detectText:(BOOL) bText detectHand:(BOOL) bHand detectFace:(BOOL) bFace detectBody:(BOOL) bBody detectBody3D:(BOOL) bBody3D;

@end


