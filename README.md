# AirPodsPro-Motion-Sampler

Code Examples of CMHeadphoneMotionManager in CoreMotion.

## Requirements 
 - Xcode: 12.0+
 - iOS  : 14.0+
 - iPhone, iPad
 - AirPods Pro

## How To Build
Open ```AirPodsProMotion.xcodeproj``` on Xcode12 or later, then connect your iPhone or iPad to build it.  

 
## Contents
 
 |  <center> Infomation View </center> |  <center>Rotate the Cube <br> By Head Motion </center> | <center>Table scrolling <br> By Head Motion </center>|
 | ---- | ---- | ---- |
 |  <center> ![](README_resources/info.gif)　</center> | <center> ![](README_resources/move.gif) 　</center> | <center>　![](README_resources/table.gif)　</center> |



- infomation View   
Displays the information (```CMDeviceMotion```) obtained from AirPodsPro.

- Rotate the Cube By Head Motion  
The cube rotates in sync with the orientation of the face.

- Tabel scrolling By Head Motion  
Move the face up and down to scroll the TableView.  
We don't use any hands at all.

  
## Reference
 - [Apple Developer Documentation](https://developer.apple.com/documentation/coremotion/cmheadphonemotionmanager)


## Author
 Yoshio Tsukuda  
 - [HP](https://tukuyo.net/)
 - [Twitter](https://twitter.com/tukutuku_tukuyo)
