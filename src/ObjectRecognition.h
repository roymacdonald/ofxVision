//
//  ObjectRecognition.h
//  example
//
//  Created by Roy Macdonald on 09-04-24.
//


#pragma once


#import <Foundation/Foundation.h>
#import <Vision/Vision.h>
#import <AVKit/AVKit.h>


@interface ObjectRecognition
: NSObject
{
    VNCoreMLRequest* objectRecognitionRequest;
    
    VNCoreMLModel * visionModel;
    
//    VNSequenceRequestHandler *handler;
    
    BOOL bModelLoaded;
    
}

-(BOOL) loadModel:(NSURL *)compiledModelURL;

- (id) initWithModelPath:(NSString *)modelPath;



-(NSArray * ) results;

-(BOOL)process:(CGImageRef)image;




@end


