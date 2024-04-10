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
        
        
        [MLModel compileModelAtURL:[NSURL fileURLWithPath:s]
                                    completionHandler:^(NSURL *compiledModelURL, NSError *error){
            if (error) {
                NSLog(@"ObjectRecognition compile MLModel Error: %@", [error localizedDescription]);
            }
            [self loadModel:compiledModelURL];
            
        }];


        handler = [[VNSequenceRequestHandler alloc] init];
        
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
    //completionHandler:(VNRequestCompletionHandler)completionHandler];
    bModelLoaded = YES;
    return YES;
}

-(BOOL)process:(CGImageRef)image{
    if(!bModelLoaded){
        return NO;
    }
    
    if([handler  performRequests:@[ objectRecognitionRequest] onCGImage: image error:nil]){
        return YES;
//        if( [segmentationRequest.results count ] ){
//            if([segmentationRequest.results firstObject]){
//                return [segmentationRequest.results firstObject].pixelBuffer;
//                
//            }
//        }
        
        
        
        
    }
                                
    return NO;
//    return nil;
}




-(NSArray * ) results{ return objectRecognitionRequest.results;}
@end


//#import <Foundation/Foundation.h>
//
//class VisionObjectRecognitionViewController: ViewController {
//    
//    private var detectionOverlay: CALayer! = nil
//    
//    // Vision parts
//    private var requests = [VNRequest]()
//    
//    @discardableResult
//    func setupVision() -> NSError? {
//        // Setup Vision parts
//        let error: NSError! = nil
//        
//        guard let modelURL = Bundle.main.url(forResource: "ObjectDetector", withExtension: "mlmodelc") else {
//            return NSError(domain: "VisionObjectRecognitionViewController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
//        }
//        do {
//            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
//            let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
//                DispatchQueue.main.async(execute: {
//                    // perform all the UI updates on the main queue
//                    if let results = request.results {
//                        self.drawVisionRequestResults(results)
//                    }
//                })
//            })
//            self.requests = [objectRecognition]
//        } catch let error as NSError {
//            print("Model loading went wrong: \(error)")
//        }
//        
//        return error
//    }
//    
//    func drawVisionRequestResults(_ results: [Any]) {
//        CATransaction.begin()
//        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
//        detectionOverlay.sublayers = nil // remove all the old recognized objects
//        for observation in results where observation is VNRecognizedObjectObservation {
//            guard let objectObservation = observation as? VNRecognizedObjectObservation else {
//                continue
//            }
//            // Select only the label with the highest confidence.
//            let topLabelObservation = objectObservation.labels[0]
//            let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
//            
//            let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds)
//            
//            let textLayer = self.createTextSubLayerInBounds(objectBounds,
//                                                            identifier: topLabelObservation.identifier,
//                                                            confidence: topLabelObservation.confidence)
//            shapeLayer.addSublayer(textLayer)
//            detectionOverlay.addSublayer(shapeLayer)
//        }
//        self.updateLayerGeometry()
//        CATransaction.commit()
//    }
//    
//    override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
//        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
//            return
//        }
//        
//        let exifOrientation = exifOrientationFromDeviceOrientation()
//        
//        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
//        do {
//            try imageRequestHandler.perform(self.requests)
//        } catch {
//            print(error)
//        }
//    }
//    
//    override func setupAVCapture() {
//        super.setupAVCapture()
//        
//        // setup Vision parts
//        setupLayers()
//        updateLayerGeometry()
//        setupVision()
//        
//        // start the capture
//        startCaptureSession()
//    }
//    
//    func setupLayers() {
//        detectionOverlay = CALayer() // container layer that has all the renderings of the observations
//        detectionOverlay.name = "DetectionOverlay"
//        detectionOverlay.bounds = CGRect(x: 0.0,
//                                         y: 0.0,
//                                         width: bufferSize.width,
//                                         height: bufferSize.height)
//        detectionOverlay.position = CGPoint(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
//        rootLayer.addSublayer(detectionOverlay)
//    }
//    
//    func updateLayerGeometry() {
//        let bounds = rootLayer.bounds
//        var scale: CGFloat
//        
//        let xScale: CGFloat = bounds.size.width / bufferSize.height
//        let yScale: CGFloat = bounds.size.height / bufferSize.width
//        
//        scale = fmax(xScale, yScale)
//        if scale.isInfinite {
//            scale = 1.0
//        }
//        CATransaction.begin()
//        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
//        
//        // rotate the layer into screen orientation and scale and mirror
//        detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: scale, y: -scale))
//        // center the layer
//        detectionOverlay.position = CGPoint(x: bounds.midX, y: bounds.midY)
//        
//        CATransaction.commit()
//        
//    }
//    
//    func createTextSubLayerInBounds(_ bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
//        let textLayer = CATextLayer()
//        textLayer.name = "Object Label"
//        let formattedString = NSMutableAttributedString(string: String(format: "\(identifier)\nConfidence:  %.2f", confidence))
//        let largeFont = UIFont(name: "Helvetica", size: 24.0)!
//        formattedString.addAttributes([NSAttributedString.Key.font: largeFont], range: NSRange(location: 0, length: identifier.count))
//        textLayer.string = formattedString
//        textLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.height - 10, height: bounds.size.width - 10)
//        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
//        textLayer.shadowOpacity = 0.7
//        textLayer.shadowOffset = CGSize(width: 2, height: 2)
//        textLayer.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 1.0])
//        textLayer.contentsScale = 2.0 // retina rendering
//        // rotate the layer into screen orientation and scale and mirror
//        textLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: 1.0, y: -1.0))
//        return textLayer
//    }
//    
//    func createRoundedRectLayerWithBounds(_ bounds: CGRect) -> CALayer {
//        let shapeLayer = CALayer()
//        shapeLayer.bounds = bounds
//        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
//        shapeLayer.name = "Found Object"
//        shapeLayer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 0.2, 0.4])
//        shapeLayer.cornerRadius = 7
//        return shapeLayer
//    }
//    
//}
