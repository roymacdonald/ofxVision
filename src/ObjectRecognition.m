//
//  ObjectRecognition.m
//  example
//
//  Created by Roy Macdonald on 09-04-24.
//


#include "ObjectRecognition.h"

@implementation ObjectRecognition

- (id) initWithModelPath:(NSString *)modelPath loadLabels:(BOOL)bLoadLabels{
    
        self = [super init];
        if(self) {
            
            bModelLoaded = NO;
            NSString * s = [[modelPath stringByExpandingTildeInPath] stringByResolvingSymlinksInPath];
            
            
            NSError *error =nil;
            
            NSURL *compiledModelURL = [MLModel compileModelAtURL:[NSURL fileURLWithPath:s] error:&error];
            if (error) {
                NSLog(@"ObjectRecognition compile MLModel Error: %@", [error localizedDescription]);
                return nil;
            }
            
            if(![self loadModel:compiledModelURL loadLabels:bLoadLabels]){
                return nil;
            }
        }
    
    return self;
}


NSArray<NSString *> *extractClassLabelsFromModel(MLModel *model) {
    // Get the model description
    MLModelDescription *modelDescription = model.modelDescription;

    // Check if class labels are available
    
    NSDictionary* metadata = [modelDescription.metadata objectForKey:@"MLModelCreatorDefinedKey"];
    if(metadata){
        NSString* names = [metadata objectForKey:@"names"];
        if(names){
            NSLog(@"Metadata names  %@", names);
        }
    }
    NSArray<id> *classLabels = modelDescription.classLabels;
    if (classLabels && classLabels.count > 0) {
        // Convert the class labels to NSString array if needed
        NSMutableArray<NSString *> *labelArray = [NSMutableArray array];
        for (id label in classLabels) {
            if ([label isKindOfClass:[NSString class]]) {
                [labelArray addObject:(NSString *)label];
            } else if ([label isKindOfClass:[NSNumber class]]) {
                // Convert NSNumber to NSString if labels are numeric
                [labelArray addObject:[(NSNumber *)label stringValue]];
            }
        }
        NSLog(@"Loaded labels count: %d", (int)[labelArray count]);
        return [labelArray copy];
    }

    NSLog(@"No class labels found in the model description.");
    return nil;
}

-(BOOL) loadModel:(NSURL *)compiledModelURL loadLabels:(BOOL)bLoadLabels{
    
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
    
    if(bLoadLabels){
        labels = extractClassLabelsFromModel(model);
    }else{
        labels = nil;
    }
    
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


-(NSArray<NSString *> *) getLabels{ return labels;}

-(NSArray * ) results{ return objectRecognitionRequest.results;}
@end

