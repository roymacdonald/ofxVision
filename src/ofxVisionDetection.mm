//
//  ofxVisionDetection.m
//  example
//
//  Created by Roy Macdonald on 20-03-24.
//
#include "ofxVisionDetection.h"

#include "ofxVisionHelpers.h"

#pragma clang diagnostic ignored "-Wunguarded-availability"

int getBodyPoseIDfromKey(VNHumanBodyPoseObservationJointName joint_name)
{
    switch(joint_name){
        case VNHumanBodyPoseObservationJointNameNose: return BODY_NOSE;
        case VNHumanBodyPoseObservationJointNameLeftEye: return BODY_LEFTEYE;
        case VNHumanBodyPoseObservationJointNameRightEye: return BODY_RIGHTEYE;
        case VNHumanBodyPoseObservationJointNameLeftEar: return BODY_LEFTEAR;
        case VNHumanBodyPoseObservationJointNameRightEar: return BODY_RIGHTEAR;
        case VNHumanBodyPoseObservationJointNameLeftWrist: return BODY_LEFTWRIST;
        case VNHumanBodyPoseObservationJointNameRightWrist: return BODY_RIGHTWRIST;
        case VNHumanBodyPoseObservationJointNameLeftElbow: return BODY_LEFTELBOW;
        case VNHumanBodyPoseObservationJointNameRightElbow: return BODY_RIGHTELBOW;
        case VNHumanBodyPoseObservationJointNameLeftShoulder: return BODY_LEFTSHOULDER;
        case VNHumanBodyPoseObservationJointNameRightShoulder: return BODY_RIGHTSHOULDER;
        case VNHumanBodyPoseObservationJointNameLeftHip: return BODY_LEFTHIP;
        case VNHumanBodyPoseObservationJointNameRightHip: return BODY_RIGHTHIP;
        case VNHumanBodyPoseObservationJointNameLeftKnee: return BODY_LEFTKNEE;
        case VNHumanBodyPoseObservationJointNameRightKnee: return BODY_RIGHTKNEE;
        case VNHumanBodyPoseObservationJointNameLeftAnkle: return BODY_LEFTANKLE;
        case VNHumanBodyPoseObservationJointNameRightAnkle: return BODY_RIGHTANKLE;
    }
    return BODY_N_PART;
}

int getBodyPose3DIDfromKey(VNHumanBodyPose3DObservationJointName joint_name)
{
    switch(joint_name){
        case VNHumanBodyPose3DObservationJointNameTopHead: return BODY3D_TOPHEAD;
        case VNHumanBodyPose3DObservationJointNameCenterHead: return BODY3D_CENTERHEAD;
        case VNHumanBodyPose3DObservationJointNameCenterShoulder: return BODY3D_CENTERSHOULDER;
        case VNHumanBodyPose3DObservationJointNameLeftShoulder: return BODY3D_LEFTSHOULDER;
        case VNHumanBodyPose3DObservationJointNameRightShoulder: return BODY3D_RIGHTSHOULDER;
        case VNHumanBodyPose3DObservationJointNameLeftElbow: return BODY3D_LEFTELBOW;
        case VNHumanBodyPose3DObservationJointNameRightElbow: return BODY3D_RIGHTELBOW;
        case VNHumanBodyPose3DObservationJointNameLeftWrist: return BODY3D_LEFTWRIST;
        case VNHumanBodyPose3DObservationJointNameRightWrist: return BODY3D_RIGHTWRIST;
        case VNHumanBodyPose3DObservationJointNameLeftHip: return BODY3D_LEFTHIP;
        case VNHumanBodyPose3DObservationJointNameRightHip: return BODY3D_RIGHTHIP;
        case VNHumanBodyPose3DObservationJointNameLeftKnee: return BODY3D_LEFTKNEE;
        case VNHumanBodyPose3DObservationJointNameRightKnee: return BODY3D_RIGHTKNEE;
        case VNHumanBodyPose3DObservationJointNameLeftAnkle: return BODY3D_LEFTANKLE;
        case VNHumanBodyPose3DObservationJointNameRightAnkle: return BODY3D_RIGHTANKLE;
        case VNHumanBodyPose3DObservationJointNameRoot: return BODY3D_ROOT;
        case VNHumanBodyPose3DObservationJointNameSpine: return BODY3D_SPINE;
    }
    return BODY3D_N_PART;
}

int getHandPoseIDfromKey(VNHumanHandPoseObservationJointName joint_name)
{
    switch(joint_name){
        case VNHumanHandPoseObservationJointNameWrist: return HAND_WRIST;
        case VNHumanHandPoseObservationJointNameThumbCMC: return HAND_THUMB0;
        case VNHumanHandPoseObservationJointNameThumbMP: return HAND_THUMB1;
        case VNHumanHandPoseObservationJointNameThumbIP: return HAND_THUMB2;
        case VNHumanHandPoseObservationJointNameThumbTip: return HAND_THUMB3;
        case VNHumanHandPoseObservationJointNameIndexMCP: return HAND_INDEX0;
        case VNHumanHandPoseObservationJointNameIndexPIP: return HAND_INDEX1;
        case VNHumanHandPoseObservationJointNameIndexDIP: return HAND_INDEX2;
        case VNHumanHandPoseObservationJointNameIndexTip: return HAND_INDEX3;
        case VNHumanHandPoseObservationJointNameMiddleMCP: return HAND_MIDDLE0;
        case VNHumanHandPoseObservationJointNameMiddlePIP: return HAND_MIDDLE1;
        case VNHumanHandPoseObservationJointNameMiddleDIP: return HAND_MIDDLE2;
        case VNHumanHandPoseObservationJointNameMiddleTip: return HAND_MIDDLE3;
        case VNHumanHandPoseObservationJointNameRingMCP: return HAND_RING0;
        case VNHumanHandPoseObservationJointNameRingPIP: return HAND_RING1;
        case VNHumanHandPoseObservationJointNameRingDIP: return HAND_RING2;
        case VNHumanHandPoseObservationJointNameRingTip: return HAND_RING3;
        case VNHumanHandPoseObservationJointNameLittleMCP: return HAND_PINKY0;
        case VNHumanHandPoseObservationJointNameLittlePIP: return HAND_PINKY1;
        case VNHumanHandPoseObservationJointNameLittleDIP: return HAND_PINKY2;
        case VNHumanHandPoseObservationJointNameLittleTip: return HAND_PINKY3;
    }
    return HAND_N_PART;
}

void setPoint(ofxVision::PointsDetection& points, const size_t&  index, VNRecognizedPoint * point){
    points.setPoint(index, point.location.x, point.location.y, point.confidence);
}

void setPoint(ofxVision::Body3DDetection& points, const size_t&  index, VNPoint * point){
    points.setPoint(index, point.x, point.y, 0.0f);
}

void setPoint3D(ofxVision::Body3DDetection& points, const size_t&  index, VNHumanBodyRecognizedPoint3D* point){
    glm::vec3 position = glm::vec3(point.position.columns[3].x, point.position.columns[3].y, point.position.columns[3].z);
    points.setGlobalPosition(index, position);
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
        
        
        for(VNHumanBodyPoseObservationJointName key in allPts)
        {
            VNRecognizedPoint* point = [allPts objectForKey:key];
            setPoint(body, getBodyPoseIDfromKey(key), point);
        }
        
        body.updateRect();
        
    }
}

//------------------------------------------------------------------------------------------------------------------------
void processBody3DResults(NSArray*  source, ofxVision::Body3DCollection& dest){
    NSError *err;
    
    dest.detections.clear();
    
    for(VNHumanBodyPose3DObservation *observation in source){
        NSDictionary <VNHumanBodyPose3DObservationJointName, VNHumanBodyRecognizedPoint3D *> *allPts = [observation recognizedPointsForJointsGroupName:VNHumanBodyPose3DObservationJointsGroupNameAll error:&err];
        if(err){
            NSLog(@"ofxVisionResults::processBody3DResults Error: %@", [err localizedDescription]);
            continue;
        }
        
        dest.detections.emplace_back(ofxVision::Body3DDetection());
        auto & body = dest.detections.back();
        body.score = observation.confidence;
        body.bodyHeight = observation.bodyHeight;
        
        simd_float4x4 camera_pos = observation.cameraOriginMatrix;
        glm::vec3 position = glm::vec3(camera_pos.columns[3].x, camera_pos.columns[3].y, camera_pos.columns[3].z);
        glm::vec3 x_axis = glm::vec3(camera_pos.columns[0].x, camera_pos.columns[0].y, camera_pos.columns[0].z);
        glm::vec3 y_axis = glm::vec3(camera_pos.columns[1].x, camera_pos.columns[1].y, camera_pos.columns[1].z);
        glm::vec3 z_axis = glm::vec3(camera_pos.columns[2].x, camera_pos.columns[2].y, camera_pos.columns[2].z);
        glm::vec3 scale = glm::vec3(glm::length(x_axis), glm::length(y_axis), glm::length(z_axis)); // scale is always 1
        glm::mat3 rotation_mat = glm::mat3(x_axis / scale.x, y_axis / scale.y, z_axis / scale.z);
        glm::quat quaternion = glm::quat_cast(rotation_mat);
        body.camera.setGlobalPosition(position);
        body.camera.setGlobalOrientation(quaternion);


        for(VNHumanBodyPose3DObservationJointName key in allPts)
        {
            VNPoint* point2d = [observation pointInImageForJointName:key error:&err];
            setPoint(body, getBodyPose3DIDfromKey(key), point2d);
            VNHumanBodyRecognizedPoint3D* point3d = [allPts objectForKey:key];
            NSString* parent = point3d.parentJoint;
            body.setParent(getBodyPose3DIDfromKey(key), getBodyPose3DIDfromKey(parent));
            setPoint3D(body, getBodyPose3DIDfromKey(key), point3d);
        }
        
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
        
        for(VNHumanHandPoseObservationJointName key in allPts)
        {
            VNRecognizedPoint *point = [allPts objectForKey:key];
            setPoint(hand, getHandPoseIDfromKey(key), point);
        }
        
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
//------------------------------------------------------------------------------------------------------------------------

ofxVisionDetection::ofxVisionDetection(){
    detection = [[Detection alloc] init];
}
//
//bool ofxVisionDetection::loadModel(const std::string& modelPath){
//    
//    NSString * s = [NSString stringWithUTF8String:modelPath.c_str()];
//    objectRecognition = [[ObjectRecognition alloc] initWithModelPath: s];
//    
//    return (objectRecognition != nil);
//}

void ofxVisionDetection::detect(ofPixels &pix)
{
    
    //    cout << "ofxVisionDetection::detect...";
    CGImageRef image = ofxVisionHelper::CGImageRefFromOfPixels(pix,(int)pix.getWidth(),(int)pix.getHeight(),(int)pix.getNumChannels());
    if(recognizeObjects.get()) {
        detect_(image);
    }
//    if(!objectRecognition){
//        ofLogError("ofxVisionDetection::detect", "model not loaded. Call ofxVisionDetection::loadModel(...) before calling this method");
//        //        return;
//    }else if(recognizeObjects.get() && [objectRecognition process:image]){
//            rectObjectDetections.detections.clear();
//            for(VNRecognizedObjectObservation *observation in [objectRecognition results]){
//                
//                ofxVision::RectDetection det(ofxVisionHelper::toOf(observation.boundingBox),0);
//                
//                //            VNClassificationObservation
//                if (observation.labels.count > 0){
//                    det.label =  [observation.labels[0].identifier UTF8String];
//                    det.score =  observation.labels[0].confidence ;
//                }
//                rectObjectDetections.detections.push_back(det);
//            }
//        
//    }
    
    if( detectAnimal.get() || detectText.get() || detectHand.get() || detectFace.get() || detectBody.get() || detectBody3D.get()){
        [detection detect:image
             detectAnimal: this->detectAnimal.get()
               detectText: this->detectText.get()
               detectHand: this->detectHand.get()
               detectFace: this->detectFace.get()
               detectBody: this->detectBody.get()
               detectBody3D: this->detectBody3D.get()];

        if( this->detectAnimal.get() ) {processAnimalResults([detection animalResults], animalResults);}
        if( this->detectText.get() ) {processTextResults([detection textResults], textResults);}
        if( this->detectHand.get() ) {processHandResults([detection handResults], handResults);}
        if( this->detectFace.get() ) {processFaceResults([detection faceResults], faceResults);}
        if( this->detectBody.get() ) {processBodyResults([detection bodyResults], bodyResults);}
        if( this->detectBody3D.get() ) {processBody3DResults([detection body3DResults], body3DResults);}
    }
    
    
    
    CGImageRelease(image);
}
void ofxVisionDetection::draw(const ofRectangle& rect){
    if(recognizeObjects.get()) detectionResults.draw(rect, true, true);
    if( this->detectAnimal.get() ) { animalResults.draw(rect); }
    if( this->detectText.get() ) { textResults.draw(rect); }
    if( this->detectHand.get() ) { handResults.draw(rect); }
    if( this->detectFace.get() ) { faceResults.draw(rect); }
    if( this->detectBody.get() ) { bodyResults.draw(rect); }
    if( this->detectBody3D.get() ) { body3DResults.draw(rect); }

    
}

//------------------------------------------------------------------------------------------------------------------------

template<typename resultsType>
bool ofxVisionObjectDetection_<resultsType>::loadModel(const std::string& modelPath){
    
    NSString * s = [NSString stringWithUTF8String:modelPath.c_str()];
    objectRecognition = [[ObjectRecognition alloc] initWithModelPath: s];
    return (objectRecognition != nil);
    
}
    


template<typename resultsType>
void ofxVisionObjectDetection_<resultsType>::detect(ofPixels & pix){
    
    //    cout << "ofxVisionDetection::detect...";
    CGImageRef image = ofxVisionHelper::CGImageRefFromOfPixels(pix,(int)pix.getWidth(),(int)pix.getHeight(),(int)pix.getNumChannels());
    detect_(image);
    CGImageRelease(image);
}

template<typename resultsType>
void ofxVisionObjectDetection_<resultsType>::detect_(CGImageRef image){
    if(!objectRecognition){
        ofLogError("ofxVisionDetection::detect", "model not loaded. Call ofxVisionObjectDetection_::loadModel(...) before calling this method");
        //        return;
    }else if([objectRecognition process:image]){
        processResults( [objectRecognition results]);
    }
}

template<>
void ofxVisionObjectDetection_<ofxVision::RectsCollection>::processResults(NSArray* results){
    detectionResults.detections.clear();
        for(VNRecognizedObjectObservation *observation in  results){
            
            ofxVision::RectDetection det(ofxVisionHelper::toOf(observation.boundingBox),0);
            
            //            VNClassificationObservation
            if (observation.labels.count > 0){
                det.label =  [observation.labels[0].identifier UTF8String];
                det.score =  observation.labels[0].confidence ;
            }
            detectionResults.detections.push_back(det);
        }
}

template<>
void ofxVisionObjectDetection_<ofxVision::LabelsCollection>::processResults(NSArray* results){
    detectionResults.detections.clear();
    for(VNClassificationObservation *observation in  results){
        detectionResults.detections.push_back(ofxVision::LabelDetection ([observation.identifier UTF8String], observation.confidence));
    }
}

template class ofxVisionObjectDetection_<ofxVision::LabelsCollection>;
template class ofxVisionObjectDetection_<ofxVision::RectsCollection>;
