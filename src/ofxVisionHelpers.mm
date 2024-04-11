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


ofRectangle ofxVisionHelper::toOf(const CGRect &rect){
    return ofRectangle( rect.origin.x,
    (1-rect.origin.y-rect.size.height),
    rect.size.width,
    rect.size.height);
}
                
