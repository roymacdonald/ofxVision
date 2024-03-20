//
//  Segmentation.m
//  example
//
//  Created by Roy Macdonald on 19-03-24.
//


#include "Segmentation.h"

@implementation Segmentation


- (instancetype)init {
    self = [super init];
    if(self) {
        
//        facePoseRequest = [[VNDetectFaceLandmarksRequest alloc] init];
//        facePoseRequest.revision = VNDetectFaceRectanglesRequestRevision3;
        
        segmentationRequest = [VNGeneratePersonSegmentationRequest new];
        segmentationRequest.qualityLevel = VNGeneratePersonSegmentationRequestQualityLevelBalanced;
        segmentationRequest.outputPixelFormat = kCVPixelFormatType_OneComponent8;
        handler = [[VNSequenceRequestHandler alloc] init];
        
    }
    return self;
}



-(CVPixelBufferRef)detect:(CGImageRef)image{
    
    // Create a request to detect face rectangles.
//    VNDetectFaceLandmarksRequest* facePoseRequest = [[VNDetectFaceLandmarksRequest
//                                                      alloc] init];
    //                                                      { [weak self] request, _ in
    //        guard let face = request.results?.first as? VNFaceObservation else { return }
    //        // Generate RGB color intensity values for the face rectangle angles.
    //        self?.colors = AngleColors(roll: face.roll, pitch: face.pitch, yaw: face.yaw)
    //    }
    
    
    // Create a request to segment a person from an image.

    
//    NSDictionary *d = [[NSDictionary alloc] init]];
    //  VNImageRequestHandler *handler = [[[VNImageRequestHandler alloc] initWithCGImage:image options:d] autorelease];
    
    
//    VNGeneratePersonSegmentationRequest* segmentationRequest = [VNGeneratePersonSegmentationRequest new];
//    segmentationRequest.qualityLevel = VNGeneratePersonSegmentationRequestQualityLevelBalanced;
//    segmentationRequest.outputPixelFormat = kCVPixelFormatType_OneComponent8;
//    VNSequenceRequestHandler *handler = [[VNSequenceRequestHandler alloc] init];
    
//  [handler performRequests:@[req] error:nil];
//    if([handler  performRequests:@[facePoseRequest, segmentationRequest] onCGImage: image error:nil]){
    if([handler  performRequests:@[ segmentationRequest] onCGImage: image error:nil]){
        if( [segmentationRequest.results count ] ){
            if([segmentationRequest.results firstObject]){
                return [segmentationRequest.results firstObject].pixelBuffer;
                
            }
        }
    }
                                

    return nil;
//    return req.results;
}
@end
