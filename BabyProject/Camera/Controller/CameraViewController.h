//
//  CameraViewController.h
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

//
//  ARC Helper
#ifndef ah_retain
#if __has_feature(objc_arc)
#define ah_retain self
#define ah_dealloc self
#define release self
#define autorelease self
#else
#define ah_retain retain
#define ah_dealloc dealloc
#define __bridge
#endif
#endif

//  ARC Helper ends


#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMotion/CoreMotion.h>



@interface CameraViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    
    //声明获取图片 视频的接口实例对象
    UIImagePickerController *imgPicker;
    
    //
    BOOL pickerDidShow;
    
    //Today Implementation
    BOOL FrontCamera;
    BOOL haveImage;
    BOOL initializeCamera, photoFromCam;
    
    //AVCaptureSession对象来执行输入设备和输出设备之间的数据传递
    AVCaptureSession *session;
    //预览图层，来显示照相机拍摄到的画面
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer;
    //照片输出流对象，当然我的照相机只有拍照功能，所以只需要这个对象就够了
    AVCaptureStillImageOutput *stillImageOutput;
    UIImage *croppedImageWithoutOrientation;
}
@property (nonatomic, readwrite) BOOL dontAllowResetRestaurant;
@property (nonatomic, assign) id delegate;
@property (weak, nonatomic) IBOutlet UIView *imagePreview;
@property (weak, nonatomic) IBOutlet UIImageView *captureImage;
@property (weak, nonatomic) IBOutlet UIView *topBar;
@property (weak, nonatomic) IBOutlet UIButton *cameraToggleButton;
- (IBAction)switchCamera:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *flashToggleButton;
- (IBAction)toggleFlash:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIView *photoBar;
@property (weak, nonatomic) IBOutlet UIButton *photoCaptureButton;
- (IBAction)snapImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *libraryToggleButton;
- (IBAction)switchToLibrary:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageViewGrid;
@property (weak, nonatomic) IBOutlet UIImageView *phView1;
@property (weak, nonatomic) IBOutlet UIImageView *phView2;
@property (weak, nonatomic) IBOutlet UIImageView *phView3;
@property (weak, nonatomic) IBOutlet UIImageView *phView4;

@end
