//
//  ofxVisionHelpers.m
//  example
//
//  Created by Roy Macdonald on 19-03-24.
//
#include "ofxVisionHelpers.h"
#import <Foundation/Foundation.h>


CGImageRef ofxVisionHelper::CGImageRefFromOfPixels( ofPixels & img, int width, int height, int numberOfComponents ){
  
  int bitsPerColorComponent = 8;
  int rawImageDataLength = width * height * numberOfComponents;
  BOOL interpolateAndSmoothPixels = NO;
  CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
  CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
  CGDataProviderRef dataProviderRef;
  CGColorSpaceRef colorSpaceRef;
  CGImageRef imageRef;
  
  GLubyte *rawImageDataBuffer =  (unsigned char*)(img.getData());
  dataProviderRef = CGDataProviderCreateWithData(NULL,  rawImageDataBuffer, rawImageDataLength, nil);
  if(numberOfComponents>1)
  {
    colorSpaceRef = CGColorSpaceCreateDeviceRGB();
  }
  else
  {
    colorSpaceRef = CGColorSpaceCreateDeviceGray();
  }
  imageRef = CGImageCreate(width, height, bitsPerColorComponent, bitsPerColorComponent * numberOfComponents, width * numberOfComponents, colorSpaceRef, bitmapInfo, dataProviderRef, NULL, interpolateAndSmoothPixels, renderingIntent);
  
  CGDataProviderRelease(dataProviderRef);
  
  return imageRef;
}

//---------------------------------------------------------------------------------------------------------------------------------------

CVPixelBufferRef ofxVisionHelper::CVPixelBufferRefFromOfPixels(ofPixels& pixels){
    
    CVPixelBufferRef pb = NULL;
    NSDictionary *attrs = @{
        (id)kCVPixelBufferCGImageCompatibilityKey       : @YES,
        (id)kCVPixelBufferCGBitmapContextCompatibilityKey : @YES
    };
    
    OSType pixelFormat;
    switch (pixels.getPixelFormat()) {
case OF_PIXELS_RGB:
        pixelFormat = kCVPixelFormatType_24RGB;
    break;
case OF_PIXELS_BGR:
        pixelFormat = kCVPixelFormatType_24BGR;
    break;
case OF_PIXELS_RGBA:
        pixelFormat = kCVPixelFormatType_32RGBA;
    break;
case OF_PIXELS_BGRA:
        pixelFormat = kCVPixelFormatType_32BGRA;
    break;
case OF_PIXELS_GRAY:
        pixelFormat = kCVPixelFormatType_OneComponent8;
    break;
case OF_PIXELS_GRAY_ALPHA:
        pixelFormat = kCVPixelFormatType_TwoComponent8;
    break;
        default:
            ofLogError("ofxVisionHelper::CVPixelBufferRefFromOfPixels") << "Invalid pixel type: " << ofToString(pixels.getPixelFormat());
            return NULL;
        break;
    }
    CVReturn status = CVPixelBufferCreate(kCFAllocatorDefault,
                                          pixels.getWidth(),
                                          pixels.getHeight(),
                                          pixelFormat,
                                          (__bridge CFDictionaryRef)attrs,
                                          &pb);
    if (status != kCVReturnSuccess) {
        ofLogError("ofxVisionHelper::CVPixelBufferRefFromOfPixels") << "Failed creating CVPixelBuffer";
        return NULL;
    }
    
    CVPixelBufferLockBaseAddress(pb, 0);
    void *dst = CVPixelBufferGetBaseAddress(pb);
    memcpy(dst, pixels.getData(), pixels.size());
    CVPixelBufferUnlockBaseAddress(pb, 0);
    return pb;
}

//---------------------------------------------------------------------------------------------------------------------------------------

void ofxVisionHelper::ofPixelsFromCVPixelBufferRef(CVPixelBufferRef buff, ofPixels& pixels){
    CVPixelBufferRetain(buff);
    CVPixelBufferLockBaseAddress(buff, 0);

        size_t w, h;
    w = CVPixelBufferGetWidth(buff);
    h = CVPixelBufferGetHeight(buff);

    if(!pixels.isAllocated() || (pixels.getWidth() != w) || (pixels.getHeight() != h)){
        pixels.allocate(w, h, OF_PIXELS_GRAY);
    }
        
    unsigned char * pix = static_cast<unsigned char * >(CVPixelBufferGetBaseAddress(buff));
    if(pix){
        pixels.setFromPixels(pix, w, h, OF_PIXELS_GRAY);
    }

    CVPixelBufferUnlockBaseAddress(buff, 0);
    CVPixelBufferRelease(buff);
}


//---------------------------------------------------------------------------------------------------------------------------------------

void ofxVisionHelper::ofPixelsFromCVPixelBufferRef(CVPixelBufferRef buff, ofShortPixels& pixels){
    CVPixelBufferRetain(buff);
    CVPixelBufferLockBaseAddress(buff, 0);

        size_t w, h;
    w = CVPixelBufferGetWidth(buff);
    h = CVPixelBufferGetHeight(buff);

    if(!pixels.isAllocated() || (pixels.getWidth() != w) || (pixels.getHeight() != h)){
        pixels.allocate(w, h, OF_PIXELS_GRAY);
    }
    auto bytesPerRow = CVPixelBufferGetBytesPerRow(buff);
    
    unsigned short * pix = static_cast<unsigned short * >(CVPixelBufferGetBaseAddress(buff));
    if(pix){
        pixels.setFromAlignedPixels(pix, w, h, 1, bytesPerRow);
//        pixels.setFromPixels(pix, w, h, OF_PIXELS_GRAY);
    }

    CVPixelBufferUnlockBaseAddress(buff, 0);
    CVPixelBufferRelease(buff);
}



ofRectangle ofxVisionHelper::toOf(const CGRect &rect){
    return ofRectangle( rect.origin.x,
    (1-rect.origin.y-rect.size.height),
    rect.size.width,
    rect.size.height);
}
                
