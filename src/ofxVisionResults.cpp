//
//  ofxVisionResults.cpp
//  example-ObjectDetection
//
//  Created by Roy Macdonald on 11-04-24.
//

#include "ofxVisionResults.h"

namespace ofxVision{

LabelDetection::LabelDetection(string label, float confidence):label(label), score(confidence){
    
}
void LabelDetection::drawLabel(glm::vec3 pos, bool bDrawScore ){
    drawLabel(pos.x, pos.y, bDrawScore);
}
void LabelDetection::drawLabel(glm::vec2 pos, bool bDrawScore ){
    drawLabel(pos.x, pos.y, bDrawScore);
}
void LabelDetection::drawLabel(float x , float y, bool bDrawScore ){
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
        ofDrawBitmapString(txt, x, y);
    }
}

//--------------------------------------------------------------------------------------------------------
RectDetection::RectDetection(const ofRectangle& _rect, float confidence ):rect(_rect), LabelDetection("",confidence){
}
RectDetection::RectDetection(float x, float y, float w, float h, float confidence ):rect(x, y, w, h), LabelDetection("",confidence){
}

void RectDetection::draw(bool bDrawRect, bool bDrawLabel, bool bDrawScore){
    if(bDrawRect) ofDrawRectangle(rect);
    
    if(bDrawLabel) drawLabel(rect.getTopLeft(), bDrawScore);
}
void RectDetection::print(){
    std::cout << "RectDetection: " << rect << " label: " << label << " score: " << score <<"\n";
    
}

//--------------------------------------------------------------------------------------------------------
void PointsDetection::setPoint(const size_t& index, float x, float y, float confidence){//}, float imgWidth, float imgHeight){
    points[index].x = x ;//* imgWidth;
    points[index].y = (1- y);// * imgHeight;
    points[index].z = confidence;
}

void PointsDetection::updateRect(){
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

void PointsDetection::updateMesh(){
    pointsMesh.clear();
    pointsMesh.setMode(OF_PRIMITIVE_POINTS);
    for(size_t i = 0; i < FACE_N_PART; i++){
        pointsMesh.addVertex(glm::vec3(points[i].x,points[i].y,0));
        pointsMesh.addColor(ofFloatColor(points[i].z));
    }
    bNeedsMeshUpdate = false;
}



void PointsDetection::drawPoints(){
    if(bNeedsMeshUpdate){
        updateMesh();
    }
    pointsMesh.draw();
}

//--------------------------------------------------------------------------------------------------------

void FaceDetectionsCollection::draw(const ofRectangle& rect){
    if(detections.size() == 0)return;
    pushTransformAndStyle(rect,ofColor::black);
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
}

//--------------------------------------------------------------------------------------------------------

void RectsCollection::draw(const glm::vec2& offset, bool bDrawLabel, bool bDrawScore){
    draw(ofRectangle(offset.x, offset.y,1 ,1), bDrawLabel, bDrawScore);
}
void RectsCollection::draw(const ofRectangle& rect, bool bDrawLabel, bool bDrawScore){
    if(detections.size() == 0) return;
    pushTransformAndStyle(rect,ofColor::white);
    ofNoFill();
    for(auto & d: detections){
        d.draw(true, bDrawLabel , bDrawScore );
    }
    popTransformAndStyle();
}

//--------------------------------------------------------------------------------------------------------

void PointsCollection::draw(const ofRectangle& rect){
    if(detections.size() == 0) return;
    pushTransformAndStyle(rect,ofColor::black);
    glPointSize(3);
    for(auto & d: detections){
        d.drawPoints();
    }
    popTransformAndStyle();
    
}

//--------------------------------------------------------------------------------------------------------
void LabelsCollection::draw(float x, float y){
    stringstream ss;
    for(const auto& d: detections){
        ss << "Label: " << d.label << " confidence: " << d.score << "\n";
    }
    ofDrawBitmapStringHighlight(ss.str(), x, y);
}

}
