
#include "face.h"
#import <Vision/Vision.h>

namespace ofxVision {

void Face::process(NSArray *  results, float imgWidth, float imgHeight){

    number = 1;
    faceCollection.detections.clear();

    for(VNFaceObservation *observation in results){
        
            CGFloat x = imgWidth *observation.boundingBox.origin.x;
            CGFloat y = imgHeight *(1-observation.boundingBox.origin.y-observation.boundingBox.size.height);
            CGFloat w = imgWidth *observation.boundingBox.size.width;
            CGFloat h = imgHeight *observation.boundingBox.size.height;

            faceCollection.detections.push_back({});
            faceCollection.detections.back().orientation.x = 0;
            faceCollection.detections.back().orientation.y = [observation.yaw floatValue];
            faceCollection.detections.back().orientation.z = [observation.roll floatValue];

            VNFaceLandmarkRegion2D* landmarks = observation.landmarks.allPoints;
            const CGPoint * points = landmarks.normalizedPoints;
            for (int i = 0; i < landmarks.pointCount; i++){
                faceCollection.detections.back().points[i].x = points[i].x * w + x;
                faceCollection.detections.back().points[i].y = (1-points[i].y) * h + y;
                faceCollection.detections.back().points[i].z = [landmarks.precisionEstimatesPerPoint[i] floatValue];
            }

            faceCollection.detections.back().updateRect();
            faceCollection.detections.back().score = observation.confidence;
    }
//  n_det = 0;
//    if(detections.size()){
//        detections.clear();
//    }
//    numDets = 0;
//    size_t nd = 0;
//    
//  for(VNFaceObservation *observation in results){
//      if(nd < MAX_DET-1){
//          CGFloat x = imgWidth*observation.boundingBox.origin.x;
//          CGFloat y = imgHeight*(1-observation.boundingBox.origin.y-observation.boundingBox.size.height);
//          CGFloat w = imgWidth*observation.boundingBox.size.width;
//          CGFloat h = imgHeight*observation.boundingBox.size.height;
//          
//          // apparently pitch is not supported, gives error:
//          // -[VNFaceObservation pitch]: unrecognized selector sent to instance
//          //    orientations[n_det].x = [[observation pitch] floatValue];
////          detections.push_back({});
////          detections.back().orientation.x = 0;
////          detections.back().orientation.y = [observation.yaw floatValue];
////          detections.back().orientation.z = [observation.roll floatValue];
//          
//          detections[nd].orientation.x = 0;
//          detections[nd].orientation.y = [observation.yaw floatValue];
//          detections[nd].orientation.z = [observation.roll floatValue];
//          
//          VNFaceLandmarkRegion2D* landmarks = observation.landmarks.allPoints;
//          const CGPoint * points = landmarks.normalizedPoints;
//          for (int i = 0; i < landmarks.pointCount; i++){
////              detections.back().points[i].x = points[i].x * w + x;
////              detections.back().points[i].y = (1-points[i].y) * h + y;
////              detections.back().points[i].z = [landmarks.precisionEstimatesPerPoint[i] floatValue];
//              
//              detections[nd].points[i].x = points[i].x * w + x;
//              detections[nd].points[i].y = (1-points[i].y) * h + y;
//              detections[nd].points[i].z = [landmarks.precisionEstimatesPerPoint[i] floatValue];
//              
//              
//          }
//          
////          detections.back().updateRect();
////          detections.back().score = observation.confidence;
//          detections[nd].updateRect();
//          detections[nd].score = observation.confidence;
//          
//          nd ++;
//      }else{
//          break;
//      }
////    n_det++;
//  }

}
}
