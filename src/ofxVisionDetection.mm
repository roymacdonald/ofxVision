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
    
    if (joint_name == VNHumanBodyPoseObservationJointNameNose) { return BODY_NOSE; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameLeftEye) { return BODY_LEFTEYE; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameRightEye) { return BODY_RIGHTEYE; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameLeftEar) { return BODY_LEFTEAR; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameRightEar) { return BODY_RIGHTEAR; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameLeftWrist) { return BODY_LEFTWRIST; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameRightWrist) { return BODY_RIGHTWRIST; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameLeftElbow) { return BODY_LEFTELBOW; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameRightElbow) { return BODY_RIGHTELBOW; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameLeftShoulder) { return BODY_LEFTSHOULDER; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameRightShoulder) { return BODY_RIGHTSHOULDER; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameLeftHip) { return BODY_LEFTHIP; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameRightHip) { return BODY_RIGHTHIP; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameLeftKnee) { return BODY_LEFTKNEE; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameRightKnee) { return BODY_RIGHTKNEE; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameLeftAnkle) { return BODY_LEFTANKLE; }
    else if (joint_name == VNHumanBodyPoseObservationJointNameRightAnkle) { return BODY_RIGHTANKLE; }
    else { return BODY_N_PART; }
}

int getBodyPose3DIDfromKey(VNHumanBodyPose3DObservationJointName joint_name)
{
    
    if (joint_name == VNHumanBodyPose3DObservationJointNameTopHead) { return BODY3D_TOPHEAD; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameCenterHead) { return BODY3D_CENTERHEAD; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameCenterShoulder) { return BODY3D_CENTERSHOULDER; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameLeftShoulder) { return BODY3D_LEFTSHOULDER; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameRightShoulder) { return BODY3D_RIGHTSHOULDER; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameLeftElbow) { return BODY3D_LEFTELBOW; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameRightElbow) { return BODY3D_RIGHTELBOW; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameLeftWrist) { return BODY3D_LEFTWRIST; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameRightWrist) { return BODY3D_RIGHTWRIST; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameLeftHip) { return BODY3D_LEFTHIP; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameRightHip) { return BODY3D_RIGHTHIP; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameLeftKnee) { return BODY3D_LEFTKNEE; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameRightKnee) { return BODY3D_RIGHTKNEE; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameLeftAnkle) { return BODY3D_LEFTANKLE; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameRightAnkle) { return BODY3D_RIGHTANKLE; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameRoot) { return BODY3D_ROOT; }
    else if (joint_name == VNHumanBodyPose3DObservationJointNameSpine) { return BODY3D_SPINE; }
    else { return BODY3D_N_PART; }
}

int getHandPoseIDfromKey(VNHumanHandPoseObservationJointName joint_name)
{
    
    if (joint_name == VNHumanHandPoseObservationJointNameWrist) { return HAND_WRIST; }
    else if (joint_name == VNHumanHandPoseObservationJointNameThumbCMC) { return HAND_THUMB0; }
    else if (joint_name == VNHumanHandPoseObservationJointNameThumbMP) { return HAND_THUMB1; }
    else if (joint_name == VNHumanHandPoseObservationJointNameThumbIP) { return HAND_THUMB2; }
    else if (joint_name == VNHumanHandPoseObservationJointNameThumbTip) { return HAND_THUMB3; }
    else if (joint_name == VNHumanHandPoseObservationJointNameIndexMCP) { return HAND_INDEX0; }
    else if (joint_name == VNHumanHandPoseObservationJointNameIndexPIP) { return HAND_INDEX1; }
    else if (joint_name == VNHumanHandPoseObservationJointNameIndexDIP) { return HAND_INDEX2; }
    else if (joint_name == VNHumanHandPoseObservationJointNameIndexTip) { return HAND_INDEX3; }
    else if (joint_name == VNHumanHandPoseObservationJointNameMiddleMCP) { return HAND_MIDDLE0; }
    else if (joint_name == VNHumanHandPoseObservationJointNameMiddlePIP) { return HAND_MIDDLE1; }
    else if (joint_name == VNHumanHandPoseObservationJointNameMiddleDIP) { return HAND_MIDDLE2; }
    else if (joint_name == VNHumanHandPoseObservationJointNameMiddleTip) { return HAND_MIDDLE3; }
    else if (joint_name == VNHumanHandPoseObservationJointNameRingMCP) { return HAND_RING0; }
    else if (joint_name == VNHumanHandPoseObservationJointNameRingPIP) { return HAND_RING1; }
    else if (joint_name == VNHumanHandPoseObservationJointNameRingDIP) { return HAND_RING2; }
    else if (joint_name == VNHumanHandPoseObservationJointNameRingTip) { return HAND_RING3; }
    else if (joint_name == VNHumanHandPoseObservationJointNameLittleMCP) { return HAND_PINKY0; }
    else if (joint_name == VNHumanHandPoseObservationJointNameLittlePIP) { return HAND_PINKY1; }
    else if (joint_name == VNHumanHandPoseObservationJointNameLittleDIP) { return HAND_PINKY2; }
    else if (joint_name == VNHumanHandPoseObservationJointNameLittleTip) { return HAND_PINKY3; }
    else { return HAND_N_PART; }
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
bool ofxVisionObjectDetection_<resultsType>::loadModel(const std::string& modelPath, bool _loadLabels){
    
    NSString * s = [NSString stringWithUTF8String:modelPath.c_str()];
    objectRecognition = [[ObjectRecognition alloc] initWithModelPath: s loadLabels:(_loadLabels?YES:NO)];
    if(objectRecognition){
        NSString * NSimgsz = [objectRecognition getImgsz];
        if(NSimgsz){
            std::string imgsz([NSimgsz UTF8String]);
            imgsz = ofTrim(imgsz);
            imgsz.pop_back();
            imgsz = imgsz.substr(1);
            auto imgszSplit = ofSplitString(imgsz, ",");
            if(imgszSplit.size() == 2){
                int requiredInputWidth = ofToInt(imgszSplit[0]);
                int requiredInputHeight = ofToInt(imgszSplit[1]);
                requiredPixels.allocate(requiredInputWidth, requiredInputHeight, 3);
                requiredPixels.set(0);
                
//                ofLogNotice() << "requiredInputWidth: " << requiredInputWidth ;
//	                ofLogNotice() << "requiredInputHeight: " << requiredInputHeight ;
                
                
            }
            
        }
    }
    
    return (objectRecognition != nil);
    
}
    

template<typename resultsType>
void ofxVisionObjectDetection_<resultsType>::detect(ofVideoGrabber& vidGrabber){
    ofPixels* pixPtr = nullptr;
    if(requiredPixels.isAllocated() && requiredPixels.getWidth() > 0 && requiredPixels.getHeight() >0){
        auto& pix = vidGrabber.getPixels();
        if(!(pix.getWidth() == requiredPixels.getWidth() && pix.getHeight() == requiredPixels.getHeight())){
            if(pix.getWidth() == requiredPixels.getWidth() && pix.getHeight() < requiredPixels.getHeight()){
                requiredPixels.set(0);
                int y = (requiredPixels.getHeight() - pix.getHeight())/2;
                pix.pasteInto(requiredPixels, 0, y);
                pixPtr = &requiredPixels;
                bRemapRects = true;
                pixTranslation = {0, y/float(requiredPixels.getHeight())};
                pixScaling = {1, float(requiredPixels.getHeight())/float( pix.getHeight())};
//                std::cout << "pastePix\n";
                
            }else{
                ofRectangle srcRect(0,0,pix.getWidth(), pix.getHeight());
                ofRectangle dstRect(0,0, requiredPixels.getWidth(), requiredPixels.getHeight());
                
                srcRect.scaleTo(dstRect);
                
                
                
                if(!helperFbo){
                    helperFbo = std::make_shared<ofFbo>();
                    helperFbo->allocate(requiredPixels.getWidth(), requiredPixels.getHeight());
                }
                if(helperFbo){
                    helperFbo->begin();
                    ofClear(0, 255);
                    vidGrabber.draw(srcRect);
                    helperFbo->end();
                    helperFbo->readToPixels(requiredPixels);
                
                    pixPtr = &requiredPixels;
                    
//                    std::cout << "readToPix\n";
                    
                    pixTranslation = {srcRect.x/dstRect.getWidth(), srcRect.y/dstRect.getHeight()};
                    
                    pixScaling = {requiredPixels.getWidth()/ srcRect.getWidth(), requiredPixels.getHeight()/ srcRect.getHeight()};
                    
                    bRemapRects = true;
                }else{
                    ofLogWarning("ofxVisionObjectDetection_<resultsType>::detect") << "Invalid helperFbo";
                }
            }
        }else{
            pixPtr = &pix;
//            this->detect(pix);
        }
    }else{
        pixPtr = &vidGrabber.getPixels();
    }
    
//    if(bRemapRects){
//        std::cout << "pixTranslation: " << pixTranslation << "\n";
//        std::cout << "pixScaling: " << pixScaling << "\n";
//    }
    
    if(pixPtr){
        this->detect(*pixPtr);
    }else{
        ofLogError("ofxVisionObjectDetection_<resultsType>::detect") << "pixPtr is NULL";
    }
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


//
//template<typename resultsType>
//void ofxVisionObjectDetection_<resultsType>::handleYOLOOutput(VNCoreMLFeatureValueObservation *observation, ofxVision::RectsCollection& collection, float scale, bool bBreakpoint) {
//    // Get the feature value (output) from the observation
//    MLFeatureValue *featureValue = observation.featureValue;
//
//    // Check if it is an MLMultiArray
//    if (featureValue.type == MLFeatureTypeMultiArray) {
//        MLMultiArray *multiArray = featureValue.multiArrayValue;
//        for(NSNumber * stride in multiArray.strides){
//            std::cout << "Stride " << stride.intValue <<"\n";
//        }
//        
//        // Get the dimensions of the output array
//        NSInteger numBoxes = [multiArray.shape[0] integerValue]; // N (number of bounding boxes)
//        NSInteger numAttributes = [multiArray.shape[1] integerValue]; // Typically 85 for YOLO
//
//        // Ensure the dimensions are as expected
//        if (numAttributes < 5) {
//            ofLogWarning("ofxVisionObjectDetection::handleYOLOOutput")<< "Unexpected output dimensions.";
//            return;
//        }
//        if(bBreakpoint){
//            ofLogNotice("break");
//        }
//        // Access the raw data pointer (assuming the data type is Float32)
//        const float *dataPointer = (const float *)multiArray.dataPointer;
//
//        // Iterate through each bounding box
//        for (NSInteger i = 0; i < numBoxes; i++) {
//            // Extract values from the multi-array
//            float x = dataPointer[i * numAttributes + 0] / scale;
//            float y = dataPointer[i * numAttributes + 1] / scale;
//            float width = dataPointer[i * numAttributes + 2] / scale;
//            float height = dataPointer[i * numAttributes + 3] / scale;
//            float confidence = dataPointer[i * numAttributes + 4];
//            
//            
//            // Check if the confidence is above a threshold (e.g., 0.5)
//            if (confidence > 0.5) {
//                
//                ofxVision::RectDetection det;	
//                det.rect.set(x, y, width, height);
//                det.score = confidence;
//                
//                
//                //NSLog(@"Box %ld: x=%f, y=%f, width=%f, height=%f, confidence=%f", (long)i, x, y, width, height, confidence);
//
//                // Optionally extract class scores and find the highest one
//                
////                if(objectRecognition){
////                    auto labels = [objectRecognition getLabels];
////                    
////                    if(labels){
//                        
//                        float maxClassScore = 0.0;
//                        NSInteger maxClassIndex = -1;
//                        for (NSInteger j = 5; j < numAttributes; j++) {
//                            float classScore = dataPointer[i * numAttributes + j];
//                            if (classScore > maxClassScore) {
//                                maxClassScore = classScore;
//                                maxClassIndex = j - 5;
//                            }
//                        }
//                        
//                        if (maxClassIndex >= 0){//} && maxClassIndex < [labels count]) {
//                            //                    NSLog(@"Detected class %ld with score %f", (long)maxClassIndex, maxClassScore);
////                            det.label = [[labels objectAtIndex:maxClassIndex] UTF8String];
//                            det.label = ofToString(maxClassIndex);
//                            
//                        }
////                    }
////                }
//                collection.detections.push_back(det);
//                
//                
//            }
//        }
//    } else {
//        NSLog(@"Unexpected feature value type.");
//    }
//}


template<>
void ofxVisionObjectDetection_<ofxVision::RectsCollection>::draw( ofRectangle rect){
//    if(bRemapRects){
//        rect.x -= pixTranslation.x;
//        rect.y -= pixTranslation.y;
//        rect.width *= pixScaling.x;
//        rect.height *= pixScaling.y;
//    }
////    
    detectionResults.draw(rect, true, true);
}

template<>
void ofxVisionObjectDetection_<ofxVision::LabelsCollection>::draw( ofRectangle rect){
    detectionResults.draw(rect.x, rect.y);
}



template<>
void ofxVisionObjectDetection_<ofxVision::RectsCollection>::processResults(NSArray* results){
    detectionResults.detections.clear();
    
    for (id object in results) {
        if ([object isKindOfClass:[VNRecognizedObjectObservation class]]) {
            //cout << "VNClassificationObservation\n";
            VNRecognizedObjectObservation *observation = object;
            auto bb = ofxVisionHelper::toOf(observation.boundingBox);
            
            if(bRemapRects){
                bb.x -= pixTranslation.x;
                bb.y -= pixTranslation.y;
                bb.x *= pixScaling.x;
                bb.y *= pixScaling.y;
                
                
                bb.width *= pixScaling.x;
                bb.height *= pixScaling.y;
            }

            
            ofxVision::RectDetection det(bb,0);
            
            //            VNClassificationObservation
            if (observation.labels.count > 0){
                det.label =  [observation.labels[0].identifier UTF8String];
                det.score =  observation.labels[0].confidence ;
            }
            detectionResults.detections.push_back(det);

//        }else if ([object isKindOfClass:[VNCoreMLFeatureValueObservation class]]) {
//            
//            VNCoreMLFeatureValueObservation* observation = object;
//            
////            cout << "observation: " <<[observation.featureName UTF8String] << "\n";
//            
//            handleYOLOOutput(observation,detectionResults, drawScale.get(), breakpoint.get());
////           info = iterateMultiArrayDynamically(observation.featureValue.multiArrayValue);
//            
            
        }else{
            NSString *className = NSStringFromClass([object class]);
            cout << "NOT " << [className UTF8String] << "\n";
        }
    }
    
    
    
//        for(VNRecognizedObjectObservation *observation in  results){
//            
//        }
}

template<>
void ofxVisionObjectDetection_<ofxVision::LabelsCollection>::processResults(NSArray* results){
    detectionResults.detections.clear();
    
    for (id object in results) {
        if ([object isKindOfClass:[VNClassificationObservation class]]) {
            //cout << "VNClassificationObservation\n";
            VNClassificationObservation *observation = object;
            detectionResults.detections.push_back(ofxVision::LabelDetection ([observation.identifier UTF8String], observation.confidence));
        }else if ([object isKindOfClass:[VNCoreMLFeatureValueObservation class]]) {
            
            VNCoreMLFeatureValueObservation* observation = object;
            
            
        }else{
            NSString *className = NSStringFromClass([object class]);
            cout << "NOT " << [className UTF8String] << "\n";
            	
            
        }
    }
    
    
    
//    for(VNClassificationObservation *observation in  results){
//        detectionResults.detections.push_back(ofxVision::LabelDetection ([observation.identifier UTF8String], observation.confidence));
//    }
}

template class ofxVisionObjectDetection_<ofxVision::LabelsCollection>;
template class ofxVisionObjectDetection_<ofxVision::RectsCollection>;
