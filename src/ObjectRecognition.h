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

    NSArray<NSString *> * labels;
    NSString * imgsz;
}


- (NSString*) getImgsz;
-(BOOL) loadModel:(NSURL *)compiledModelURL  loadLabels:(BOOL)bLoadLabels;

- (id) initWithModelPath:(NSString *)modelPath   loadLabels:(BOOL)bLoadLabels;


-(NSArray * ) results;

-(BOOL)process:(CGImageRef)image;


-(NSArray<NSString *> *) getLabels;

@end


