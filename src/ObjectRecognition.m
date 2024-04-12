//
//  ObjectRecognition.m
//  example
//
//  Created by Roy Macdonald on 09-04-24.
//


#include "ObjectRecognition.h"

@implementation ObjectRecognition

- (id) initWithModelPath:(NSString *)modelPath {
//- (instancetype)init {
    self = [super init];
    if(self) {
        
        bModelLoaded = NO;
        
//        NSString * s = [NSString stringWithUTF8String:""];
        NSString * s = [[modelPath stringByExpandingTildeInPath] stringByResolvingSymlinksInPath];
        
        
        NSError *error =nil;
        
//#if (MAC_OS_X_VERSION_MAX_ALLOWED >= MAC_OS_X_VERSION_13_0)
//        [MLModel compileModelAtURL:[NSURL fileURLWithPath:s]
//                                    completionHandler:^(NSURL *compiledModelURL, NSError *error){
//            if (error) {
//                NSLog(@"ObjectRecognition compile MLModel Error: %@", [error localizedDescription]);
//            }
//            [self loadModel:compiledModelURL];
//            
//        }];
//        
//#else
        
        NSURL *compiledModelURL = [MLModel compileModelAtURL:[NSURL fileURLWithPath:s] error:&error];
        if (error) {
            NSLog(@"ObjectRecognition compile MLModel Error: %@", [error localizedDescription]);
            return nil;
        }
        
        if(![self loadModel:compiledModelURL]){
            return nil;
        }
            
        
        
//#endif


//        handler = [[VNSequenceRequestHandler alloc] init];
        
    }
    return self;
}


-(BOOL) loadModel:(NSURL *)compiledModelURL{
    
    NSError *error =nil;
    
    
    MLModel * model = [MLModel modelWithContentsOfURL:compiledModelURL error:&error];
    if (error) {
        NSLog(@"ObjectRecognition init MLModel Error: %@", [error localizedDescription]);
        return NO;
    }
    
    
    error =nil;
    visionModel = [VNCoreMLModel modelForMLModel: model error:&error];
    
    if (error) {
        NSLog(@"ObjectRecognition loadin VNCoreMLModel Error: %@", [error localizedDescription]);
        return NO;
    }
    
    objectRecognitionRequest = [[VNCoreMLRequest alloc] initWithModel:visionModel ];
    
    bModelLoaded = YES;
    return YES;
}

-(BOOL)process:(CGImageRef)image{
    if(!bModelLoaded){
        return NO;
    }
    
    NSDictionary *d = [[NSDictionary alloc] init] ;
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCGImage:image options:d];
    NSError *error =nil;
    if([handler performRequests:@[objectRecognitionRequest] error:&error]){
        return YES;
    }
    
    if (error) {
        NSLog(@"ofxVision::ObjectRecognition error: %@", [error localizedDescription]);
    }
    
    
                             
    return NO;

}




-(NSArray * ) results{ return objectRecognitionRequest.results;}
@end

