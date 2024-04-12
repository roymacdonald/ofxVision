//
//  ofxVisionDetection.m
//  example
//
//  Created by Roy Macdonald on 20-03-24.
//
#include "ofxVisionDetection.h"

#include "ofxVisionHelpers.h"

#pragma clang diagnostic ignored "-Wunguarded-availability"


void setPoint(ofxVision::PointsDetection& points, const size_t&  index, VNRecognizedPoint * point){
    points.setPoint(index, point.location.x, point.location.y, point.confidence);
}

void processAnimalResults(NSArray*  source, ofxVision::RectsCollection&  dest){
    
    dest.detections.clear();
    for(VNRecognizedObjectObservation *observation in source){
        
        
        dest.detections.push_back(ofxVision::RectDetection(ofxVisionHelper::toOf(observation.boundingBox), observation.confidence) );
        
        for (int i = 0; i < observation.labels.count; i++){
            std::string text = [observation.labels[i].identifier UTF8String];
            if(i < observation.labels.count -1){
                text += ", ";
            }
            dest.detections.back().label += text;
        }
    }
}


//------------------------------------------------------------------------------------------------------------------------
void processFaceResults(NSArray*  source, ofxVision::FaceDetectionsCollection& dest){
    auto & faces = dest.detections;
    faces.clear();
    for(VNFaceObservation *observation in source){
        
        auto r = ofxVisionHelper::toOf(observation.boundingBox);
        
        faces.push_back({});
        faces.back().orientation.x = 0;
        faces.back().orientation.y = [observation.yaw floatValue];
        faces.back().orientation.z = [observation.roll floatValue];
        
        VNFaceLandmarkRegion2D* landmarks = observation.landmarks.allPoints;
        const CGPoint * points = landmarks.normalizedPoints;
        for (int i = 0; i < landmarks.pointCount; i++){
            faces.back().points[i].x = points[i].x * r.width + r.x;
            faces.back().points[i].y = (1-points[i].y) * r.height + r.y;
            faces.back().points[i].z = [landmarks.precisionEstimatesPerPoint[i] floatValue];
        }
        
        faces.back().updateRect();
        faces.back().score = observation.confidence;
    }
}




//------------------------------------------------------------------------------------------------------------------------
void processBodyResults(NSArray*  source, ofxVision::PointsCollection& dest){
    NSError *err;
    
    dest.detections.clear();
    
    for(VNHumanBodyPoseObservation *observation in source){
        NSDictionary <VNHumanBodyPoseObservationJointName, VNRecognizedPoint *> *allPts = [observation recognizedPointsForJointsGroupName:VNHumanBodyPoseObservationJointsGroupNameAll error:&err];
        if(err){
            NSLog(@"ofxVisionResults::processBodyResults Error: %@", [err localizedDescription]);
            continue;
        }
        
        
        dest.detections.emplace_back(ofxVision::PointsDetection(BODY_N_PART));
        auto & body = dest.detections.back();
        
        body.score = observation.confidence;
        
        setPoint(body, BODY_NOSE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameNose] );
        setPoint(body, BODY_LEFTEYE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftEye] );
        setPoint(body, BODY_RIGHTEYE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightEye] );
        setPoint(body, BODY_LEFTEAR  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftEar] );
        setPoint(body, BODY_RIGHTEAR  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightEar] );
        setPoint(body, BODY_LEFTWRIST  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftWrist] );
        setPoint(body, BODY_RIGHTWRIST  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightWrist] );
        setPoint(body, BODY_LEFTELBOW  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftElbow] );
        setPoint(body, BODY_RIGHTELBOW  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightElbow] );
        setPoint(body, BODY_LEFTSHOULDER  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftShoulder] );
        setPoint(body, BODY_RIGHTSHOULDER  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightShoulder] );
        setPoint(body, BODY_LEFTHIP  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftHip] );
        setPoint(body, BODY_RIGHTHIP  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightHip] );
        setPoint(body, BODY_LEFTKNEE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftKnee] );
        setPoint(body, BODY_RIGHTKNEE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightKnee] );
        setPoint(body, BODY_LEFTANKLE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftAnkle] );
        setPoint(body, BODY_RIGHTANKLE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightAnkle] );
        
        body.updateRect();
        
    }
}


//------------------------------------------------------------------------------------------------------------------------
void processHandResults(NSArray*  source, ofxVision::PointsCollection& dest){
    

    NSError *err;
    
    dest.detections.clear();
    for(VNHumanHandPoseObservation *observation in source){
        NSDictionary <VNHumanHandPoseObservationJointName, VNRecognizedPoint *> *allPts = [observation recognizedPointsForJointsGroupName:VNHumanHandPoseObservationJointsGroupNameAll error:&err];
        
        if(err){
            NSLog(@"ofxVisionResults::processHandResults Error: %@", [err localizedDescription]);
            continue;
        }
        
        
        dest.detections.push_back(ofxVision::PointsDetection(HAND_N_PART));
        auto & hand = dest.detections.back();
        
        hand.score = observation.confidence;
        
        
        setPoint(hand, HAND_WRIST, [allPts objectForKey:VNHumanHandPoseObservationJointNameWrist    ]);
        setPoint(hand, HAND_THUMB0, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbCMC ]);
        setPoint(hand, HAND_THUMB1, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbMP  ]);
        setPoint(hand, HAND_THUMB2, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbIP  ]);
        setPoint(hand, HAND_THUMB3, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbTip ]);
        setPoint(hand, HAND_INDEX0, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexMCP ]);
        setPoint(hand, HAND_INDEX1, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexPIP ]);
        setPoint(hand, HAND_INDEX2, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexDIP ]);
        setPoint(hand, HAND_INDEX3, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexTip ]);
        setPoint(hand, HAND_MIDDLE0,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleMCP] );
        setPoint(hand, HAND_MIDDLE1,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddlePIP]);
        setPoint(hand, HAND_MIDDLE2,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleDIP]);
        setPoint(hand, HAND_MIDDLE3,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleTip]);
        setPoint(hand, HAND_RING0, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingMCP  ]);
        setPoint(hand, HAND_RING1, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingPIP  ]);
        setPoint(hand, HAND_RING2, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingDIP  ]);
        setPoint(hand, HAND_RING3, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingTip  ]);
        setPoint(hand, HAND_PINKY0,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleMCP]);
        setPoint(hand, HAND_PINKY1,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittlePIP]);
        setPoint(hand, HAND_PINKY2,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleDIP]);
        setPoint(hand, HAND_PINKY3,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleTip]);
        
        hand.updateRect();
        
        
    }
}

//------------------------------------------------------------------------------------------------------------------------
void processTextResults(NSArray*  source, ofxVision::RectsCollection& dest){
    
    dest.detections.clear();
    
    for(VNRecognizedTextObservation *observation in source){
        dest.detections.push_back(ofxVision::RectDetection(ofxVisionHelper::toOf(observation.boundingBox), observation.confidence) );
        
        VNRecognizedText* recognizedText = [observation topCandidates: 1] [0];
        
        dest.detections.back().label += std::string([recognizedText.string UTF8String]);
        
        
    }
    
    
}

ofxVisionDetection::ofxVisionDetection(){
    detection = [[Detection alloc] init];
}

bool ofxVisionDetection::loadModel(const std::string& modelPath){
    
    NSString * s = [NSString stringWithUTF8String:modelPath.c_str()];
    objectRecognition = [[ObjectRecognition alloc] initWithModelPath: s];
    return (objectRecognition != nil);
}

void ofxVisionDetection::detect(ofPixels &pix)
{
    
    //    cout << "ofxVisionDetection::detect...";
    CGImageRef image = ofxVisionHelper::CGImageRefFromOfPixels(pix,(int)pix.getWidth(),(int)pix.getHeight(),(int)pix.getNumChannels());
    if(!objectRecognition){
        ofLogError("ofxVisionDetection::detect", "model not loaded. Call ofxVisionDetection::loadModel(...) before calling this method");
        //        return;
    }else if(recognizeObjects.get() && [objectRecognition process:image]){
        objectDetections.detections.clear();
        for(VNRecognizedObjectObservation *observation in [objectRecognition results]){
            
            ofxVision::RectDetection det(ofxVisionHelper::toOf(observation.boundingBox),0);
            
            
            if (observation.labels.count > 0){
                det.label =  [observation.labels[0].identifier UTF8String];
                det.score =  observation.labels[0].confidence ;
            }
            objectDetections.detections.push_back(det);
        }
    }
    
    if( detectAnimal.get() || detectText.get() || detectHand.get() || detectFace.get() || detectBody.get() ){
        [detection detect:image
             detectAnimal: this->detectAnimal.get()
               detectText: this->detectText.get()
               detectHand: this->detectHand.get()
               detectFace: this->detectFace.get()
               detectBody: this->detectBody.get() ];
        
        if( this->detectAnimal.get() ) {processAnimalResults([detection animalResults], animalResults);}
        if( this->detectText.get() ) {processTextResults([detection textResults], textResults);}
        if( this->detectHand.get() ) {processHandResults([detection handResults], handResults);}
        if( this->detectFace.get() ) {processFaceResults([detection faceResults], faceResults);}
        if( this->detectBody.get() ) {processBodyResults([detection bodyResults], bodyResults);}
    }
    
    
    
    CGImageRelease(image);
}
void ofxVisionDetection::draw(const ofRectangle& rect){
    if(recognizeObjects.get()) objectDetections.draw(rect, true, true);
    if( this->detectAnimal.get() ) { animalResults.draw(rect); }
    if( this->detectText.get() ) { textResults.draw(rect); }
    if( this->detectHand.get() ) { handResults.draw(rect); }
    if( this->detectFace.get() ) { faceResults.draw(rect); }
    if( this->detectBody.get() ) { bodyResults.draw(rect); }
    
    
}
