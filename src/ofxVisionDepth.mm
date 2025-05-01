//
//  ofxVisionDepth.cpp
//  example-depth-anything
//
//  Created by Roy Macdonald on 30-04-25.
//

#include "ofxVisionDepth.h"
#import <Foundation/Foundation.h>
#import <Vision/Vision.h>
#import <AVKit/AVKit.h>
#include "ofxVisionHelpers.h"
//static const CGSize kTargetSize = { 518, 392 };
#pragma mark -- Helpers

CVPixelBufferRef ResizePixelBufferWithCI(CVPixelBufferRef src,
                                         CGSize dstSize,
                                         CIContext *ciCtx)      // reuse a CIContext
{
    
    // 1. Wrap the source buffer in a CIImage — orientation stays intact.
    CIImage *ciSrc = [CIImage imageWithCVPixelBuffer:src];

    // 2. Scale with Lanczos (best quality).
    CGFloat sx = dstSize.width  / ciSrc.extent.size.width;
    CGFloat sy = dstSize.height / ciSrc.extent.size.height;
    CIImage *ciScaled = [ciSrc imageByApplyingFilter:@"CILanczosScaleTransform"
                                withInputParameters:@{
                                    kCIInputScaleKey       : @(sx),
                                    kCIInputAspectRatioKey : @(sy / sx)
                                }];

    // 3. Allocate an output pixel-buffer in the same 32-BGRA format.
    CVPixelBufferRef dst = NULL;
    CVPixelBufferCreate(kCFAllocatorDefault,
                        dstSize.width, dstSize.height,
                        kCVPixelFormatType_32BGRA,
                        NULL, &dst);

    // 4. Render into it.
    [ciCtx render:ciScaled
    toCVPixelBuffer:dst
            bounds:CGRectMake(0, 0, dstSize.width, dstSize.height)
        colorSpace:CGColorSpaceCreateDeviceRGB()];

    return dst;                       // caller CFRelease(dst) when done
}
static void PrintPixelBufferInfo(CVPixelBufferRef pb)
{
    if (!pb) { NSLog(@"<NULL pixel buffer>"); return; }

    OSType fmt = CVPixelBufferGetPixelFormatType(pb);
    char fcc[5];
    fcc[0] = (fmt>>24)&0xFF;
    fcc[1] = (fmt>>16)&0xFF;
    fcc[2] = (fmt>>8)&0xFF;
    fcc[3] = fmt&0xFF;
    fcc[4] = 0;
    

    NSLog(@"--- CVPixelBuffer %p ---", pb);
    NSLog(@"  Size:   %zu × %zu",
          CVPixelBufferGetWidth(pb),
          CVPixelBufferGetHeight(pb));
    NSLog(@"  Format: '%s' (0x%08X)", fcc, (unsigned)fmt);
    NSLog(@"  Planar: %@", CVPixelBufferIsPlanar(pb) ? @"YES" : @"NO");
    NSLog(@"  Planes: %zu", CVPixelBufferGetPlaneCount(pb));

    if (CVPixelBufferIsPlanar(pb)) {
        for (size_t i = 0; i < CVPixelBufferGetPlaneCount(pb); ++i) {
            NSLog(@"    Plane %zu: %zu×%zu, bytes/row=%zu",
                  i,
                  CVPixelBufferGetWidthOfPlane(pb,i),
                  CVPixelBufferGetHeightOfPlane(pb,i),
                  CVPixelBufferGetBytesPerRowOfPlane(pb,i));
        }
    } else {
        NSLog(@"  Bytes/row: %zu", CVPixelBufferGetBytesPerRow(pb));
    }
    NSLog(@"  Data size: %zu bytes", CVPixelBufferGetDataSize(pb));

    CFDictionaryRef atts =
        CVBufferGetAttachments(pb, kCVAttachmentMode_ShouldPropagate);
    if (atts && CFDictionaryGetCount(atts)) {
        NSLog(@"  Attachments: %@", atts);
    } else {
        NSLog(@"  Attachments: (none)");
    }
}

#pragma mark -- Main
//----------------------------------------------------------------------------------------------------
bool ofxVisionDepth::loadModel(const std::string& modelUrl){
    
    
    NSString * modelPath = [NSString stringWithUTF8String:modelUrl.c_str()];
    
    bModelLoaded = false;
    NSString * s = [[modelPath stringByExpandingTildeInPath] stringByResolvingSymlinksInPath];
    
    
    NSError *error =nil;
    
    NSURL *compiledModelURL = [MLModel compileModelAtURL:[NSURL fileURLWithPath:s] error:&error];
    if (error) {
        NSLog(@"ofxVisionDepth compile MLModel Error: %@", [error localizedDescription]);
        return false;
    }
    
    MLModelConfiguration *cfg = [MLModelConfiguration new];
    cfg.computeUnits = MLComputeUnitsCPUAndGPU;
    
    model = [MLModel modelWithContentsOfURL:compiledModelURL configuration:cfg error:&error];
    if (!model) {
        NSLog(@"Model loading failed: %@", error);
        return false;
    }
    
    bModelLoaded = true;
    return true;
}

//----------------------------------------------------------------------------------------------------
void ofxVisionDepth::detect(ofPixels& pixels){
    
    if(!bModelLoaded)return;
    auto  pixelBuffer = ofxVisionHelper::CVPixelBufferRefFromOfPixels(pixels);
    
          CIContext *ctx = [CIContext contextWithOptions:nil];
    CGSize kTargetSize = {resultWidth, resultHeight};
    CVPixelBufferRef resized = ResizePixelBufferWithCI(pixelBuffer, kTargetSize, ctx);
    

    NSError *err =nil;
    
      /******** 4. Run the model ********/
      MLFeatureValue *fv = [MLFeatureValue featureValueWithPixelBuffer:resized];
      MLDictionaryFeatureProvider *fp =
      [[MLDictionaryFeatureProvider alloc] initWithDictionary:@{ @"image": fv }
                                                        error:&err];
      if (!fp) {
          NSLog(@"Input provider error: %@", err);
          return;// EXIT_FAILURE;
      }

      id<MLFeatureProvider> pred =
      [model predictionFromFeatures:fp error:&err];
      if (!pred) {
          NSLog(@"Prediction failed: %@", err);
          return;// EXIT_FAILURE;
      }


      CVPixelBufferRef depthBuf =
      [[pred featureValueForName:@"depth"] imageBufferValue];
      if (!depthBuf) {
          NSLog(@"No “depth” output in prediction");
          return;// EXIT_FAILURE;
      }
    
    _pixWidth = pixels.getWidth();
    _pixHeight = pixels.getHeight();
//    NSLog(@"===============");
//    PrintPixelBufferInfo(depthBuf);
//    NSLog(@"---------------");
    ofxVisionHelper::ofPixelsFromCVPixelBufferRef(depthBuf, depthImage.getPixels());
    bPixelsUpdated = true;
    
    CVPixelBufferRelease(pixelBuffer);
    CVPixelBufferRelease(resized);
}
//----------------------------------------------------------------------------------------------------
void ofxVisionDepth::draw(const ofRectangle & rect){
    if(bPixelsUpdated){
        depthImage.update();
        bPixelsUpdated = false;
    }
    if(depthImage.isAllocated()){
        if(ofIsFloatEqual(rect.width, 0.0f) || ofIsFloatEqual(rect.height, 0.0f)){
            depthImage.draw(rect.x, rect.y, _pixWidth, _pixHeight);
        }else{
            depthImage.draw(rect);
        }
    }
}
