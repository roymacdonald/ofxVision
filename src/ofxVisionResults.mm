////
////  ofxVisionResults.m
////  example-ObjectDetection
////
////  Created by Roy Macdonald on 10-04-24.
////
//#include "ofxVisionResults.h"
//#ifdef OFX_VISION_ENABLE_DETECTION
//
//#import <Foundation/Foundation.h>
//#import <Vision/Vision.h>
//
//#include "ofxVisionHelpers.h"
//
//
//
////namespace ofxVision{
//
//void ofxVision::PointsDetection::setPoint(const size_t&  index, VNRecognizedPoint * point){
//    setPoint(index, point.location.x, point.location.y, point.confidence);
//}
//
//    void ofxVision::processAnimalResults(NSArray*  source, ofxVision::RectsCollection&  dest){
//        
//       dest.detections.clear();
//       for(VNRecognizedObjectObservation *observation in source){
//           // CGFloat x = imgWidth*observation.boundingBox.origin.x;
//           // CGFloat y = imgHeight*(1-observation.boundingBox.origin.y-observation.boundingBox.size.height);
//           // CGFloat w = imgWidth*observation.boundingBox.size.width;
//           // CGFloat h = imgHeight*observation.boundingBox.size.height;
//    //        int N = 0;
//    
//           dest.detections.push_back(ofxVision::RectDetection(ofxVisionHelper::toOf(observation.boundingBox), observation.confidence) );
//    
//           for (int i = 0; i < observation.labels.count; i++){
//               std::string text = [observation.labels[i].identifier UTF8String];
//               if(i < observation.labels.count -1){
//                   text += ", ";
//               }
//               dest.detections.back().label += text;
//           }
//       }
//        
//    
//    }
//    
//    
////------------------------------------------------------------------------------------------------------------------------
//    void ofxVision::processFaceResults(NSArray*  source, ofxVision::FaceDetectionsCollection& dest){
//        auto & faces = dest.detections;
//        faces.clear();
//        for(VNFaceObservation *observation in source){
//    
//                auto r = ofxVisionHelper::toOf(observation.boundingBox);
//            
//                faces.push_back({});
//                faces.back().orientation.x = 0;
//                faces.back().orientation.y = [observation.yaw floatValue];
//                faces.back().orientation.z = [observation.roll floatValue];
//
//                VNFaceLandmarkRegion2D* landmarks = observation.landmarks.allPoints;
//                const CGPoint * points = landmarks.normalizedPoints;
//                for (int i = 0; i < landmarks.pointCount; i++){
//                    faces.back().points[i].x = points[i].x * r.width + r.x;
//                    faces.back().points[i].y = (1-points[i].y) * r.height + r.y;
//                    faces.back().points[i].z = [landmarks.precisionEstimatesPerPoint[i] floatValue];
//                }
//
//                faces.back().updateRect();
//                faces.back().score = observation.confidence;
//        }
//    }
//    
//
//
//
////    //------------------------------------------------------------------------------------------------------------------------
////    void setDetection(std::vector<ofxVision::PointsDetection>& detections, size_t index, VNRecognizedPoint * point){
////        detections.back().setPoint(index, point.location.x, point.location.y, point.confidence);
////    }
//    
//    //------------------------------------------------------------------------------------------------------------------------
//    void ofxVision::processBodyResults(NSArray*  source, ofxVision::PointsCollection& dest){
//        NSError *err;
//        
//        dest.detections.clear();
//        
//        for(VNHumanBodyPoseObservation *observation in source){
//            NSDictionary <VNHumanBodyPoseObservationJointName, VNRecognizedPoint *> *allPts = [observation recognizedPointsForJointsGroupName:VNHumanBodyPoseObservationJointsGroupNameAll error:&err];
//            if(err){
//                NSLog(@"ofxVisionResults::processBodyResults Error: %@", [err localizedDescription]);
//                continue;
//            }
//
//
//            dest.detections.emplace_back(ofxVision::PointsDetection(BODY_N_PART));
//            auto & body = dest.detections.back();
//
//            body.score = observation.confidence;
//            
//            body.setPoint( BODY_NOSE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameNose] );
//            body.setPoint( BODY_LEFTEYE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftEye] );
//            body.setPoint( BODY_RIGHTEYE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightEye] );
//            body.setPoint( BODY_LEFTEAR  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftEar] );
//            body.setPoint( BODY_RIGHTEAR  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightEar] );
//            body.setPoint( BODY_LEFTWRIST  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftWrist] );
//            body.setPoint( BODY_RIGHTWRIST  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightWrist] );
//            body.setPoint( BODY_LEFTELBOW  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftElbow] );
//            body.setPoint( BODY_RIGHTELBOW  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightElbow] );
//            body.setPoint( BODY_LEFTSHOULDER  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftShoulder] );
//            body.setPoint( BODY_RIGHTSHOULDER  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightShoulder] );
//            body.setPoint( BODY_LEFTHIP  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftHip] );
//            body.setPoint( BODY_RIGHTHIP  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightHip] );
//            body.setPoint( BODY_LEFTKNEE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftKnee] );
//            body.setPoint( BODY_RIGHTKNEE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightKnee] );
//            body.setPoint( BODY_LEFTANKLE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameLeftAnkle] );
//            body.setPoint( BODY_RIGHTANKLE  , [allPts objectForKey:VNHumanBodyPoseObservationJointNameRightAnkle] );
//            
//            body.updateRect();
//
//        }
//    }
//    
//    
//    //------------------------------------------------------------------------------------------------------------------------
//    void ofxVision::processHandResults(NSArray*  source, ofxVision::PointsCollection& dest){
//     
//
//            //  CGImageRef image = CGImageRefFromOfPixels(pix,(int)pix.getWidth(),(int)pix.getHeight(),(int)pix.getNumChannels());
//        //    NSArray* arr = [tracker detect:image];
//            NSError *err;
//            
//            dest.detections.clear();
//        //    n_det = 0;
//            for(VNHumanHandPoseObservation *observation in source){
//                NSDictionary <VNHumanHandPoseObservationJointName, VNRecognizedPoint *> *allPts = [observation recognizedPointsForJointsGroupName:VNHumanHandPoseObservationJointsGroupNameAll error:&err];
//                
//                if(err){
//                    NSLog(@"ofxVisionResults::processHandResults Error: %@", [err localizedDescription]);
//                    continue;
//                }
//
//
//                dest.detections.push_back(ofxVision::PointsDetection(HAND_N_PART));
//                auto & hand = dest.detections.back();
//
//                hand.score = observation.confidence;
//
//                
//                hand.setPoint( HAND_WRIST, [allPts objectForKey:VNHumanHandPoseObservationJointNameWrist    ]);
//                hand.setPoint( HAND_THUMB0, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbCMC ]);
//                hand.setPoint( HAND_THUMB1, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbMP  ]);
//                hand.setPoint( HAND_THUMB2, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbIP  ]);
//                hand.setPoint( HAND_THUMB3, [allPts objectForKey:VNHumanHandPoseObservationJointNameThumbTip ]);
//                hand.setPoint( HAND_INDEX0, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexMCP ]);
//                hand.setPoint( HAND_INDEX1, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexPIP ]);
//                hand.setPoint( HAND_INDEX2, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexDIP ]);
//                hand.setPoint( HAND_INDEX3, [allPts objectForKey:VNHumanHandPoseObservationJointNameIndexTip ]);
//                hand.setPoint( HAND_MIDDLE0,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleMCP] );
//                hand.setPoint( HAND_MIDDLE1,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddlePIP]);
//                hand.setPoint( HAND_MIDDLE2,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleDIP]);
//                hand.setPoint( HAND_MIDDLE3,[allPts objectForKey:VNHumanHandPoseObservationJointNameMiddleTip]);
//                hand.setPoint( HAND_RING0, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingMCP  ]);
//                hand.setPoint( HAND_RING1, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingPIP  ]);
//                hand.setPoint( HAND_RING2, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingDIP  ]);
//                hand.setPoint( HAND_RING3, [allPts objectForKey:VNHumanHandPoseObservationJointNameRingTip  ]);
//                hand.setPoint( HAND_PINKY0,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleMCP]);
//                hand.setPoint( HAND_PINKY1,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittlePIP]);
//                hand.setPoint( HAND_PINKY2,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleDIP]);
//                hand.setPoint( HAND_PINKY3,[allPts objectForKey:VNHumanHandPoseObservationJointNameLittleTip]);
//                
//                hand.updateRect();
//
//                
//            }
//    }
//        
//    //------------------------------------------------------------------------------------------------------------------------
//    void ofxVision::processTextResults(NSArray*  source, ofxVision::RectsCollection& dest){
//     
//        dest.detections.clear();
//            
//        for(VNRecognizedTextObservation *observation in source){
//            
//            
//            // CGFloat x = imgWidth*observation.boundingBox.origin.x;
//            // CGFloat y = imgHeight*(1-observation.boundingBox.origin.y-observation.boundingBox.size.height);
//            // CGFloat w = imgWidth*observation.boundingBox.size.width;
//            // CGFloat h = imgHeight*observation.boundingBox.size.height;
//            
//            dest.detections.push_back(ofxVision::RectDetection(ofxVisionHelper::toOf(observation.boundingBox), observation.confidence) );
//            
//            VNRecognizedText* recognizedText = [observation topCandidates: 1] [0];
//            
//            dest.detections.back().label += std::string([recognizedText.string UTF8String]);
//            
//            
//        }
//        
//        
//    }
//    
////}
//#endif
