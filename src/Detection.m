//
//  Detection.m
//  example
//
//  Created by Roy Macdonald on 20-03-24.
//

#import <Foundation/Foundation.h>
#include "Detection.h"

@implementation Detection


- (instancetype)init {
    self = [super init];
    if(self) {
        
//        facePoseRequest = [[VNDetectFaceLandmarksRequest alloc] init];
//        facePoseRequest.revision = VNDetectFaceRectanglesRequestRevision3;
        
        
        animalReq = nil;
        textReq  = nil;
        handReq = nil;
        faceReq = nil;
        bodyReq = nil;
        body3DReq = nil;
//        faceReq = [VNDetectFaceLandmarksRequest new];
        
        
//        handler = [[VNSequenceRequestHandler alloc] init];
        
    }
    return self;
}




-(BOOL)detect:(CGImageRef)image detectAnimal:(BOOL) bAnimal detectText:(BOOL) bText detectHand:(BOOL) bHand detectFace:(BOOL) bFace detectBody:(BOOL) bBody detectBody3D:(BOOL)bBody3D {
    
    if(!animalReq && bAnimal) { animalReq = [VNRecognizeAnimalsRequest new];}else if(animalReq && !bAnimal){animalReq = nil;}
    if(!textReq && bText ) { textReq  = [VNRecognizeTextRequest new];}else if(textReq && !bText ){textReq = nil;}
    if(!handReq && bHand ) { handReq = [VNDetectHumanHandPoseRequest new];}else if(handReq && !bHand ){handReq = nil;}
    if(!faceReq && bFace ) { faceReq = [VNDetectFaceLandmarksRequest new];
        faceReq.revision = VNDetectFaceRectanglesRequestRevision3;
    }else if(faceReq && !bFace ){faceReq = nil;}
    if(!bodyReq && bBody) { bodyReq = [VNDetectHumanBodyPoseRequest new];}else if(bodyReq && !bBody){bodyReq = nil;}
    if(!body3DReq && bBody3D) { body3DReq = [[VNDetectHumanBodyPose3DRequest alloc]init];}else if(body3DReq && !bBody3D){body3DReq = nil;}


    
    NSMutableArray *requests = [[NSMutableArray alloc]init];
    
    if(animalReq != nil) [requests addObject:animalReq];
    if(textReq != nil) [requests addObject:textReq];
    if(handReq != nil) [requests addObject:handReq];
    if(faceReq != nil) [requests addObject:faceReq];
    if(bodyReq != nil) [requests addObject:bodyReq];
    if(body3DReq != nil) [requests addObject:body3DReq];

    if([requests count] == 0) return NO;
    
//    if([handler  performRequests:@[faceReq] onCGImage: image error:nil]){
    
    NSError *error =nil;
    
    NSDictionary *d = [[NSDictionary alloc] init] ;
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:image options:d];

    if([handler performRequests:requests error:&error]){
        return YES;
    }
    
//    if([handler  performRequests:requests onCGImage: image error:&error]){
//        return YES;
//    }
    if (error) {
        NSLog(@"ofxVision::Detection error: %@", [error localizedDescription]);
    }
    
                                

    return NO;
}
-(NSArray * ) animalResults{ return animalReq.results;}
-(NSArray * ) textResults{ return textReq.results;}
-(NSArray * ) handResults{ return handReq.results;}
-(NSArray * ) faceResults{ return faceReq.results;}
-(NSArray * ) bodyResults{ return bodyReq.results;}
-(NSArray * ) body3DResults{ return body3DReq.results;}


@end
