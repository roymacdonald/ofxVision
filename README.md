# ofxVision

### [openFrameworks](https://openframeworks.cc/) addon for using Apple's [Vision Framework](https://developer.apple.com/documentation/vision).

Inspired and adapted from [VisionOSC](https://github.com/LingDong-/VisionOSC/)

## Requirements

openFrameworks v0.12.0 or newer.
macOS 12+.



## How to Use

Just use with openFrameworks project generator to add to your project. Check the example on how to use. 

### Object detection
To use the object detection you need to download or train a model.
you can try with the models in the YOLO section at https://developer.apple.com/machine-learning/models/


### Using Ultralytics' YOLO11

In order to use [Ultralytics YOLO11](https://docs.ultralytics.com/models/yolo11/#overview) you need to transform their yolo models into a CoreML model. The instructions they provide [here](https://docs.ultralytics.com/integrations/coreml/#installation) need to add a few parameters in order to export correctly.
Use the following python script instead of the one they provide

Save the folowing as a .py file.
```python
from ultralytics import YOLO
model = YOLO("yolo11n.pt", task="detect")
model.export(format="coreml", int8=True, nms=True, imgsz=[640], data="coco.yaml")
```
This script assumes that yolo11n.pt and coco.yaml are in the same directory as the .py file.

coco.yaml is found [here](https://github.com/ultralytics/ultralytics/blob/main/ultralytics/cfg/datasets/coco.yaml)

Yolo models that need to be exported to CoreML are found [here](https://docs.ultralytics.com/tasks/detect/)

If you train your own yolo with your own data set you need to point to the correct data yaml file and .pt files.


## Important

Make sure that Xcode's Minimum Deployment Target it set to macos 12.0 or higher
![](Screenshot.png)


