//
//  ofxVisionResults.h
//  example
//
//  Created by Roy Macdonald on 20-03-24.
//

#pragma once
#include "ofxVisionConstants.h"


#include "ofMain.h"

//
//#ifdef __OBJC__
//#import <Foundation/Foundation.h>
//#import <Vision/Vision.h>
//#endif
//


namespace ofxVision{

// A bunch of helping classes that only store the data from the detection processes and draws these.

class RectDetection{
public:
    RectDetection(){}
    virtual ~RectDetection(){}
    RectDetection(const ofRectangle& _rect, float confidence ):rect(_rect), score(confidence){
    }
    RectDetection(float x, float y, float w, float h, float confidence ):rect(x, y, w, h), score(confidence){
    }
    
    ofRectangle rect;
    std::string label;
    float score;
    
    void draw(bool bDrawRect, bool bDrawLabel, bool bDrawScore){
        if(bDrawRect) ofDrawRectangle(rect);
        
        if(bDrawLabel) drawLabel(bDrawScore);
    }
    void print(){
        std::cout << "RectDetection: " << rect << " label: " << label << " score: " << score <<"\n";
        
    }
    void drawLabel(bool bDrawScore = false){
        std::string txt;
        if(!label.empty()){
            txt += label;
            if(bDrawScore){
                txt += "\n";
            }
        }
        if(bDrawScore){
            txt += ofToString(score);
        }
        if(!txt.empty()){
            ofDrawBitmapString(txt, rect.getTopLeft());
        }
    }
    
};

class PointDetection{
public:
    PointDetection(){}
    PointDetection(float x, float y, float z, float confidence):point(x, y, z), score(confidence){}
    
    glm::vec3 point;
    float score;
    std::string label;
};

#ifndef __OBJC__
class VNRecognizedPoint;

#endif

class PointsDetection: public RectDetection{
public:
    
    PointsDetection(size_t numPoints):points(numPoints){
        
    }
    
    std::vector<glm::vec3> points;
    
    
//    void setPoint(const size_t&  index, VNRecognizedPoint * point);
    
    void setPoint(const size_t& index, float x, float y, float confidence){//}, float imgWidth, float imgHeight){
        points[index].x = x ;//* imgWidth;
        points[index].y = (1- y);// * imgHeight;
        points[index].z = confidence;
    }
    
    void updateRect(){
        bool isFirst = true;
        for(size_t i = 0; i < FACE_N_PART; i++){
            if(points[i].z > 0.0001f){
                if(isFirst){
                    rect.set(points[i].x, points[i].y, 0,0);
                    isFirst = false;
                }else{
                    rect.growToInclude(points[i].x, points[i].y);
                }
            }
        }
        bNeedsMeshUpdate = true;
    }
    
    void updateMesh(){
        pointsMesh.clear();
        pointsMesh.setMode(OF_PRIMITIVE_POINTS);
        for(size_t i = 0; i < FACE_N_PART; i++){
            pointsMesh.addVertex(glm::vec3(points[i].x,points[i].y,0));
            pointsMesh.addColor(ofFloatColor(points[i].z));
        }
        bNeedsMeshUpdate = false;
    }
    
    
    
    void drawPoints(){
            if(bNeedsMeshUpdate){
                updateMesh();
            }
            pointsMesh.draw();
    }
protected:
    ofMesh pointsMesh;
    bool bNeedsMeshUpdate = false;

};

class FaceDetection: public PointsDetection{
public:
    FaceDetection():PointsDetection(FACE_N_PART){}
    
    glm::vec3 orientation;
    
};

template<class DetectionType>
class BaseDetectionCollection{
public:
    virtual ~BaseDetectionCollection(){}
    
    std::vector<DetectionType> detections;
    
    
    void pushTransformAndStyle(const ofRectangle& rect, const ofColor& color = ofColor::black){
        ofPushMatrix();
        ofTranslate(rect.getTopLeft());
        ofScale(rect.width, rect.height);
        ofPushStyle();
        ofSetColor(color);
    }
    
    void popTransformAndStyle(){
        ofPopStyle();
        ofPopMatrix();
    }
};


class FaceDetectionsCollection:
public BaseDetectionCollection<FaceDetection>
{
public:
//    std::vector<FaceDetection> detections;
    
    
    void draw(const ofRectangle& rect){
        if(detections.size() == 0)return;
        pushTransformAndStyle(rect,ofColor::black);
//        ofPushMatrix();
//        ofTranslate(rect.getTopLeft());
//        ofScale(rect.width, rect.height);
//        ofPushStyle();
//        ofSetColor(ofColor::black);
        glPointSize(3);
        for(auto & d: detections){
            d.drawPoints();
        }
        
        
        ofSetColor(255);
        ofNoFill();
        for(auto & d: detections){
            ofDrawRectangle(d.rect);
        }
        popTransformAndStyle();
//        ofPopStyle();
//        ofPopMatrix();
    }
};

class RectsCollection:
public BaseDetectionCollection<RectDetection>
{
public:
//    std::vector<RectDetection> detections;
    
    void draw(const glm::vec2& offset, bool bDrawLabel = false, bool bDrawScore = false){
        draw(ofRectangle(offset.x, offset.y,1 ,1), bDrawLabel, bDrawScore);
    }
    void draw(const ofRectangle& rect, bool bDrawLabel = false, bool bDrawScore = false){
        if(detections.size() == 0) return;
            pushTransformAndStyle(rect,ofColor::white);
//        ofPushMatrix();
//        ofTranslate(rect.getTopLeft());
//        ofScale(rect.width, rect.height);
//        ofPushStyle();
//        ofSetColor(255);
        ofNoFill();
        for(auto & d: detections){
            d.draw(true, bDrawLabel , bDrawScore );
//            ofDrawRectangle(d.rect);
        }
        popTransformAndStyle();
//        ofPopStyle();
//        ofPopMatrix();
    }
};

//template<int N>
class PointsCollection:
public BaseDetectionCollection<PointsDetection>
{
public:
//    PointsCollection():detections(N){}
//    std::vector<PointsDetection> detections;
    
    void draw(const ofRectangle& rect){
        if(detections.size() == 0) return;
        pushTransformAndStyle(rect,ofColor::black);
//        ofPushMatrix();
//        ofTranslate(rect.getTopLeft());
//        ofScale(rect.width, rect.height);
//        ofPushStyle();
//        ofSetColor(ofColor::black);
        glPointSize(3);
        for(auto & d: detections){
            d.drawPoints();
        }
        popTransformAndStyle();
//        ofPopStyle();
//        ofPopMatrix();
    }
};
//
//#ifndef __OBJC__
//class NSArray ;
//#endif
//
//
//static void processAnimalResults(NSArray*  source, RectsCollection&  dest);
//static void processFaceResults(NSArray*  source, FaceDetectionsCollection& dest);
//static void processBodyResults(NSArray*  source, PointsCollection& dest);
//static void processHandResults(NSArray*  source, PointsCollection& dest);
//static void processTextResults(NSArray*  source, RectsCollection& dest);




}

