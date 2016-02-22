//
//  CameraViewController.m
//  BabyProject
//
//  Created by 张树青 on 16/2/15.
//  Copyright (c) 2016年 zsq. All rights reserved.
//

#import "CameraViewController.h"
#import <ImageIO/ImageIO.h>
#import <Photos/Photos.h>
//#import "PhotosViewController.m"

#define DegreesToRadians(x) ((x) * M_PI / 180.0)
@interface CameraViewController (){
    UIInterfaceOrientation orientationLast, orientationAfterProcess;
    CMMotionManager *motionManager;

    NSMutableArray *_imagesArray;
}


@end

@implementation CameraViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //隐藏tabBar
    self.tabBarController.tabBar.hidden = YES;
    //隐藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
    //获取相册图片
    _imagesArray = [NSMutableArray array];
    //[self getPhotos];
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
     //初始化相机
    if (initializeCamera){
        initializeCamera = NO;
        // Initialize camera
        [self initializeCamera];
    }
}

#pragma mark - 获取相册图片
- (void)getPhotos{
    // 获取所有资源的集合，并按资源的创建时间排序
    PHFetchOptions *options = [[PHFetchOptions alloc] init];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
    //PHFetchResult *assetsFetchResults = [PHAsset fetchAssetsWithOptions:options];
    //NSLog(@"%ld", assetsFetchResults.count);
    
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
//    for (PHCollection *conllection in result) {
//        
//        NSLog(@"%@, %d", conllection.localizedTitle, conllection.canContainAssets);
//    }
    
    PHAssetCollection *recently = [result lastObject];
    
    PHFetchResult *assets = [PHAsset fetchAssetsInAssetCollection:recently options:options];
    
    NSLog(@"%ld", assets.count);

    // 在资源的集合中所有的集合，并获取其中的图片
    PHCachingImageManager *imageManager = [[PHCachingImageManager alloc] init];
    for (PHAsset *asset in assets) {
        [imageManager requestImageForAsset:asset
                                targetSize:CGSizeMake(200, 200)
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 // 得到一张 UIImage，展示到界面上
                                 if (result) {
                                     [_imagesArray addObject:result];
                                 }
                             }];
    }
    
    if (_imagesArray.count>0) {
        _phView1.image = _imagesArray[0];
        _phView2.image = _imagesArray[1];
        _phView3.image = _imagesArray[2];
        _phView4.image = _imagesArray[3];

    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [session stopRunning];
    
    //页面退出前显示tabBar和状态栏
    self.tabBarController.tabBar.hidden = NO;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    //[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    self.navigationController.navigationBarHidden = YES;
//    [self.navigationController setNavigationBarHidden:YES];
    
    // Do any additional setup after loading the view.
    pickerDidShow = NO;
    
    FrontCamera = NO;
    self.captureImage.hidden = YES;
    
    // 创建 UIImagePicker Controller 获取图片的接口 对象
    imgPicker = [[UIImagePickerController alloc] init];
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    
    croppedImageWithoutOrientation = [[UIImage alloc] init];
    
    initializeCamera = YES;
    photoFromCam = YES;
    
    // 闪光灯模式设置为自动
    self.flashToggleButton.tag = AVCaptureFlashModeAuto;
    
    // 创建运动管理类对象  Motion Manager
    [self initializeMotionManager];
    
    //开启相机
    [self initializeCamera];
    
}

#pragma mark - CoreMotion Task
- (void)initializeMotionManager{
    motionManager = [[CMMotionManager alloc] init];
    
    //更新频率是100Hz
    motionManager.accelerometerUpdateInterval = .2;
    motionManager.gyroUpdateInterval = .2;
    
    //push方式，更新数据
    [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                        withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                            if (!error) {
                                                [self outputAccelertionData:accelerometerData.acceleration];
                                            }
                                            else{
                                                NSLog(@"%@", error);
                                            }
                                        }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */
-(void) dealloc
{
    [_imagePreview release];
    [_captureImage release];
    [imgPicker release];
    imgPicker = nil;
    
    if (session)
        [session release], session=nil;
    
    if (captureVideoPreviewLayer)
        [captureVideoPreviewLayer release], captureVideoPreviewLayer=nil;
    
    if (stillImageOutput)
        [stillImageOutput release], stillImageOutput=nil;
}



#pragma mark - UIAccelerometer callback

- (void)outputAccelertionData:(CMAcceleration)acceleration{
    UIInterfaceOrientation orientationNew;
    
    if (acceleration.x >= 0.75) {
        orientationNew = UIInterfaceOrientationLandscapeLeft;
    }
    else if (acceleration.x <= -0.75) {
        orientationNew = UIInterfaceOrientationLandscapeRight;
    }
    else if (acceleration.y <= -0.75) {
        orientationNew = UIInterfaceOrientationPortrait;
    }
    else if (acceleration.y >= 0.75) {
        orientationNew = UIInterfaceOrientationPortraitUpsideDown;
    }
    else {
        // Consider same as last time
        return;
    }
    
    if (orientationNew == orientationLast)
        return;
    
    //    NSLog(@"Going from %@ to %@!", [[self class] orientationToText:orientationLast], [[self class] orientationToText:orientationNew]);
    
    orientationLast = orientationNew;
}

#ifdef DEBUG
+(NSString*)orientationToText:(const UIInterfaceOrientation)ORIENTATION {
    switch (ORIENTATION) {
        case UIInterfaceOrientationPortrait:
            return @"UIInterfaceOrientationPortrait";
        case UIInterfaceOrientationPortraitUpsideDown:
            return @"UIInterfaceOrientationPortraitUpsideDown";
        case UIInterfaceOrientationLandscapeLeft:
            return @"UIInterfaceOrientationLandscapeLeft";
        case UIInterfaceOrientationLandscapeRight:
            return @"UIInterfaceOrientationLandscapeRight";
        case UIInterfaceOrientationUnknown:
            return @"UIInterfaceOrientationUnknown";
    }
    return @"Unknown orientation!";
}
#endif

#pragma mark - 初始化相机
//AVCaptureSession to show live video feed in view
- (void) initializeCamera {
    
    //如果session 已存在 则销毁并重新创建
    if (session)
        [session release], session=nil;
    
    session = [[AVCaptureSession alloc] init];
    //设置图片质量
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    //如果预览图层已存在 则销毁并重新创建
    if (captureVideoPreviewLayer)
        [captureVideoPreviewLayer release], captureVideoPreviewLayer=nil;
    
    captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    //设置显示范围
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    
    captureVideoPreviewLayer.frame = self.imagePreview.bounds;
    //将预览图层贴到 视图控制器的imageView
    [self.imagePreview.layer addSublayer:captureVideoPreviewLayer];
    
    UIView *view = [self imagePreview];
    CALayer *viewLayer = [view layer];
    [viewLayer setMasksToBounds:YES];
    
    CGRect bounds = [view bounds];
    [captureVideoPreviewLayer setFrame:bounds];
    
    //获取可用拍摄设备数组
    NSArray *devices = [AVCaptureDevice devices];
    //前置摄像头
    AVCaptureDevice *frontCamera=nil;
    //后置摄像头
    AVCaptureDevice *backCamera=nil;
    
    // 检查是否有设备可用 数组为0 即不可用
    if (devices.count==0) {
       // NSLog(@"No Camera Available");
        [self disableCameraDeviceControls];
        return;
    }
    
    for (AVCaptureDevice *device in devices) {
        
       // NSLog(@"Device name: %@", [device localizedName]);
        
        if ([device hasMediaType:AVMediaTypeVideo]) {
            //根据设备的位置信息 分别为捕捉设备赋值
            if ([device position] == AVCaptureDevicePositionBack) {
              //  NSLog(@"Device position : back");
                backCamera = device;
            }
            else {
               // NSLog(@"Device position : front");
                frontCamera = device;
            }
        }
    }
    //设置后置摄像头
    if (!FrontCamera) {
        
        //如果设备有闪关灯
        if ([backCamera hasFlash]){
            //设置设备锁
            //为了AVCaptureDevice设置硬件属性,如focusMode exposureMode,客户必须先在设备上获得一个锁。客户应该只持有设备锁如果他们需要可设置的设备属性保持不变。持有不必要的设备锁在其他应用程序中可能降低捕获质量共享设备。
            [backCamera lockForConfiguration:nil];
            
            //根据tag值 设置闪光灯模式
            if (self.flashToggleButton.tag==AVCaptureFlashModeAuto){
                [backCamera setFlashMode:AVCaptureFlashModeAuto];
            }
            else if(self.flashToggleButton.tag==AVCaptureFlashModeOn){
                [backCamera setFlashMode:AVCaptureFlashModeOn];
            }
            else{
                [backCamera setFlashMode:AVCaptureFlashModeOff];
            }
            //打开设备锁
            [backCamera unlockForConfiguration];
            
            [self.flashToggleButton setEnabled:YES];
        }
        else{
            if ([backCamera isFlashModeSupported:AVCaptureFlashModeOff]) {
                [backCamera lockForConfiguration:nil];
                [backCamera setFlashMode:AVCaptureFlashModeOff];
                [backCamera unlockForConfiguration];
            }
            [self.flashToggleButton setEnabled:NO];
        }
        
        NSError *error = nil;
        
        //获取摄像头捕捉到的数据
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
        if (error) {
            NSLog(@"ERROR: trying to open camera: %@", error);
            [[[UIAlertView alloc] initWithTitle:error.localizedDescription
                                        message:error.localizedFailureReason
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            [self cancel:self.cancelButton];
            return;
        }
        //通过addInput 将session与input关联起来
        [session addInput:input];
    }
    
    //前置摄像头开启时的设置
    if (FrontCamera) {
        [self.flashToggleButton setEnabled:NO];
        NSError *error = nil;
        AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:frontCamera error:&error];
        if (!input) {
            NSLog(@"ERROR: trying to open camera: %@", error);
        }
        [session addInput:input];
    }
    
    if (stillImageOutput)
        [stillImageOutput release], stillImageOutput=nil;
    
    //照片输出流
    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    //通过字典设置其属性
    NSDictionary *outputSettings = [[[NSDictionary alloc] initWithObjectsAndKeys: AVVideoCodecJPEG, AVVideoCodecKey, nil] autorelease];
    [stillImageOutput setOutputSettings:outputSettings];
    
    [session addOutput:stillImageOutput];
    
    //从输入到输出的数据流 会话开始连接
    [session startRunning];
}

#pragma mart - 拍摄照片
- (void) capImage { //method to capture image from AVCaptureSession video feed
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        
        if (videoConnection) {
            break;
        }
    }
    
    NSLog(@"about to request a capture from: %@", stillImageOutput);
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler: ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        
        if (imageSampleBuffer != NULL) {
            
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            [self processImage:[UIImage imageWithData:imageData]];
        }
    }];
}

- (UIImage*)imageWithImage:(UIImage *)sourceImage scaledToWidth:(float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;
    
    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - 处理图片
- (void) processImage:(UIImage *)image { //process captured image, crop, resize and rotate
    haveImage = YES;
    photoFromCam = YES;
    
    // Resize image to 640x640
    // Resize image
    //    NSLog(@"Image size %@",NSStringFromCGSize(image.size));
    
    UIImage *smallImage = [self imageWithImage:image scaledToWidth:640.0f]; //UIGraphicsGetImageFromCurrentImageContext();
    
    CGRect cropRect = CGRectMake(0, 105, 640, 640);
    CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
    
    croppedImageWithoutOrientation = [[UIImage imageWithCGImage:imageRef] copy];
    
    UIImage *croppedImage = nil;
    //    assetOrientation = ALAssetOrientationUp;
    
    // adjust image orientation
    //NSLog(@"orientation: %ld",orientationLast);
    orientationAfterProcess = orientationLast;
    switch (orientationLast) {
        case UIInterfaceOrientationPortrait:
            NSLog(@"UIInterfaceOrientationPortrait");
            croppedImage = [UIImage imageWithCGImage:imageRef];
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
            croppedImage = [[[UIImage alloc] initWithCGImage: imageRef
                                                       scale: 1.0
                                                 orientation: UIImageOrientationDown] autorelease];
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"UIInterfaceOrientationLandscapeLeft");
            croppedImage = [[[UIImage alloc] initWithCGImage: imageRef
                                                       scale: 1.0
                                                 orientation: UIImageOrientationRight] autorelease];
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"UIInterfaceOrientationLandscapeRight");
            croppedImage = [[[UIImage alloc] initWithCGImage: imageRef
                                                       scale: 1.0
                                                 orientation: UIImageOrientationLeft] autorelease];
            break;
            
        default:
            croppedImage = [UIImage imageWithCGImage:imageRef];
            break;
    }
    
    CGImageRelease(imageRef);
    
    [self.captureImage setImage:croppedImage];
    
    [self setCapturedImage];
}

#pragma mark - 拍摄完成 停止会话
- (void)setCapturedImage{
    // Stop capturing image
    [session stopRunning];
    
    // Hide Top/Bottom controller after taking photo for editing
   // [self hideControllers];
    
    // 存储图片到"相机胶卷"
    UIImageWriteToSavedPhotosAlbum(self.captureImage.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
}
// 成功保存图片到相册中, 必须调用此方法, 否则会报参数越界错误
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"%@: %@", @"保存失败", error);
    }else{
        NSLog(@"%@", @"保存成功");
    }
}

#pragma mark - 设置button 不可用
- (void)disableCameraDeviceControls{
    self.cameraToggleButton.enabled = NO;
    self.flashToggleButton.enabled = NO;
    self.photoCaptureButton.enabled = NO;
}

#pragma mark - UIImagePicker 代理方法
//选中相册图片后 调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    if (info) {
        photoFromCam = NO;
        
        UIImage* outputImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if (outputImage == nil) {
            outputImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        if (outputImage) {
            self.captureImage.hidden = NO;
            self.captureImage.image=outputImage;
            self.imageViewGrid.hidden = YES;
            [self dismissViewControllerAnimated:YES completion:nil];
            
            // Hide Top/Bottom controller after taking photo for editing
            //[self hideControllers];
        }
    }
}
//取消后调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    initializeCamera = YES;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - 隐藏buttons
- (void)hideControllers{
    [UIView animateWithDuration:0.2 animations:^{
        //1)animate them out of screen
        self.photoBar.center = CGPointMake(self.photoBar.center.x, self.photoBar.center.y+116.0);
        self.topBar.center = CGPointMake(self.topBar.center.x, self.topBar.center.y-44.0);
        
        //2)actually hide them
        self.photoBar.alpha = 0.0;
        self.topBar.alpha = 0.0;
        
    } completion:nil];
}
#pragma mark - 显示buttons
- (void)showControllers{
    [UIView animateWithDuration:0.2 animations:^{
        //1)animate them into screen
        self.photoBar.center = CGPointMake(self.photoBar.center.x, self.photoBar.center.y-116.0);
        self.topBar.center = CGPointMake(self.topBar.center.x, self.topBar.center.y+44.0);
        
        //2)actually show them
        self.photoBar.alpha = 1.0;
        self.topBar.alpha = 1.0;
        
    } completion:nil];
}


#pragma mark - button 点击事件
//切换镜头
- (IBAction)switchCamera:(UIButton *)sender {
    //switch cameras front and rear cameras
    // Stop current recording process
    [session stopRunning];
    
    if (sender.selected) {  // Switch to Back camera
        sender.selected = NO;
        FrontCamera = NO;
        [self performSelector:@selector(initializeCamera) withObject:nil afterDelay:0.001];
    }
    else {                  // Switch to Front camera
        sender.selected = YES;
        FrontCamera = YES;
        [self performSelector:@selector(initializeCamera) withObject:nil afterDelay:0.001];
    }
}
//设置闪光灯模式
- (IBAction)toggleFlash:(UIButton *)sender {
    if (!FrontCamera) {
        
        NSArray *devices = [AVCaptureDevice devices];
        for (AVCaptureDevice *device in devices) {
            
            NSLog(@"Device name: %@", [device localizedName]);
            
            if ([device hasMediaType:AVMediaTypeVideo]) {
                
                if ([device position] == AVCaptureDevicePositionBack) {
                    NSLog(@"Device position : back");
                    if ([device hasFlash]){
                        
                        [device lockForConfiguration:nil];
                        
                        if (sender.tag==AVCaptureFlashModeAuto) { // Current flash mode is Auto, set it to On
                            [device setFlashMode:AVCaptureFlashModeOn];
                            sender.tag = AVCaptureFlashModeOn;
                            [sender setImage:[UIImage imageNamed:@"camera_flash_auto"] forState:UIControlStateNormal];
                        }
                        else if (sender.tag==AVCaptureFlashModeOn){ // Current flash mode is On, set it to Off
                            [device setFlashMode:AVCaptureFlashModeOff];
                            sender.tag = AVCaptureFlashModeOff;
                            [sender setImage:[UIImage imageNamed:@"camera_flash_on"] forState:UIControlStateNormal];
                        }
                        else{ // Current flash mode is Off, set it to Auto
                            [device setFlashMode:AVCaptureFlashModeAuto];
                            sender.tag = AVCaptureFlashModeAuto;
                            [sender setImage:[UIImage imageNamed:@"camera_flash_off"] forState:UIControlStateNormal];
                        }
                        
                        [device unlockForConfiguration];
                        
                        break;
                    }
                }
            }
        }
    }
}
//拍照
- (IBAction)snapImage:(id)sender {
    
    [self.photoCaptureButton setEnabled:NO];
    
    if (!haveImage) {
        self.captureImage.image = nil; //remove old image from view
        self.captureImage.hidden = NO; //show the captured image view
        self.imagePreview.hidden = YES; //hide the live video feed
        self.imageViewGrid.hidden = YES;
        [self capImage];
    }
    else {
        
        self.captureImage.hidden = YES;
        self.imagePreview.hidden = NO;
        //self.imageViewGrid.hidden = YES;
        haveImage = NO;
    }
}

-(IBAction)switchToLibrary:(id)sender {
    
    if (session) {
        [session stopRunning];
    }
    
    //    self.captureImage = nil;
    
    //    UIImagePickerController* imagePickerController = [[UIImagePickerController alloc] init];
    //    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //    imagePickerController.delegate = self;
    //    imagePickerController.allowsEditing = YES;
    [self presentViewController:imgPicker animated:YES completion:NULL];
    
//    PhotosViewController *photoController = [[PhotosViewController alloc] init];
//    photoController.dataArray1 = [_imagesArray copy];
//    photoController.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:photoController   animated:YES];
    
}
- (IBAction)cancel:(id)sender {
//    if ([delegate respondsToSelector:@selector(yCameraControllerDidCancel)]) {
//        [delegate yCameraControllerDidCancel];
//    }
    
    // Dismiss self view controller
    [self dismissViewControllerAnimated:YES completion:^{
    
//        self.tabBarController.selectedIndex = [ZSQStorage getItemSelectedIndex];
    //self.tabBarController.selectedIndex = 1;
    
    }];

}
@end
