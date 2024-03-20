//
//  Segmentation.h
//  example
//
//  Created by Roy Macdonald on 19-03-24.
//

#pragma once


#import <Foundation/Foundation.h>
#import <Vision/Vision.h>
#import <AVKit/AVKit.h>


@interface Segmentation
: NSObject
{
//    VNDetectFaceLandmarksRequest* facePoseRequest;
    VNGeneratePersonSegmentationRequest* segmentationRequest;
    VNSequenceRequestHandler *handler;
}

-(CVPixelBufferRef)detect:(CGImageRef)image;

@end

