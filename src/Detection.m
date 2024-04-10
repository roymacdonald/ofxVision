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
        
//        segmentationRequest = [VNGeneratePersonSegmentationRequest new];
//        segmentationRequest.qualityLevel = VNGeneratePersonSegmentationRequestQualityLevelBalanced;
//        segmentationRequest.outputPixelFormat = kCVPixelFormatType_OneComponent8;
        
        animalReq = nil;
        textReq  = nil;
        handReq = nil;
//        faceReq = nil;
        bodyReq = nil;
        faceReq = [VNDetectFaceLandmarksRequest new];
        
        
        handler = [[VNSequenceRequestHandler alloc] init];
        
    }
    return self;
}




-(BOOL)detect:(CGImageRef)image detectAnimal:(BOOL) bAnimal detectText:(BOOL) bText detectHand:(BOOL) bHand detectFace:(BOOL) bFace detectBody:(BOOL) bBody{
    
    
//    
//    if(!animalReq && bAnimal) { animalReq = [VNRecognizeAnimalsRequest new];}else if(animalReq && !bAnimal){animalReq = nil;}
//    if(!textReq && bText ) { textReq  = [VNRecognizeTextRequest new];}else if(textReq && !bText ){textReq = nil;}
//    if(!handReq && bHand ) { handReq = [VNDetectHumanHandPoseRequest new];}else if(handReq && !bHand ){handReq = nil;}
//    if(!faceReq && bFace ) { faceReq = [VNDetectFaceLandmarksRequest new];
//        faceReq.revision = VNDetectFaceRectanglesRequestRevision3;
//    }else if(faceReq && !bFace ){faceReq = nil;}
//    if(!bodyReq && bBody) { bodyReq = [VNDetectHumanBodyPoseRequest new];}else if(bodyReq && !bBody){bodyReq = nil;}
//
//
//    
//    NSMutableArray *requests = [[NSMutableArray alloc]init];
//    
//    if(animalReq) [requests addObject:animalReq];
//    if(textReq) [requests addObject:textReq];
//    if(handReq) [requests addObject:handReq];
//    if(faceReq) [requests addObject:faceReq];
//    if(bodyReq) [requests addObject:bodyReq];
//    
//    if([requests count] == 0) return NO;
    
    if([handler  performRequests:@[faceReq] onCGImage: image error:nil]){
//    if([handler  performRequests:requests onCGImage: image error:nil]){
        return YES;
//        if( [segmentationRequest.results count ] ){
//            if([segmentationRequest.results firstObject]){
//                return [segmentationRequest.results firstObject].pixelBuffer;
//                
//            }
//        }
    }
                                

    return NO;
}
-(NSArray * ) animalResults{ return animalReq.results;}
-(NSArray * ) textResults{ return textReq.results;}
-(NSArray * ) handResults{ return handReq.results;}
-(NSArray * ) faceResults{ return faceReq.results;}
-(NSArray * ) bodyResults{ return bodyReq.results;}


@end
