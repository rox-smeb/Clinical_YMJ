//
//  ImagePickerManager.m
//  求美者端
//
//  Created by AnYanbo on 16/8/16.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "ImagePickerManager.h"

#import <objc/runtime.h>
#import <AVFoundation/AVFoundation.h>

#import "YBCommonKit/TZImagePickerController.h"

#define CAMERA_IMAGE_MAX_SIZE      (400)

@interface UIActionSheet (Private)

@property (nonatomic, weak) id userObject;

@end

@implementation UIActionSheet (Private)

- (void)setUserObject:(id)userObject
{
    objc_setAssociatedObject(self, @"userObject", userObject, OBJC_ASSOCIATION_ASSIGN);
}

- (id)userObject
{
    return objc_getAssociatedObject(self, @"userObject");
}

@end

@interface ImagePickerManager () <UIActionSheetDelegate,
                                  UIAlertViewDelegate,
                                  UINavigationControllerDelegate,
                                  UIImagePickerControllerDelegate,
                                  TZImagePickerControllerDelegate>

@end

@implementation ImagePickerManager

static NSMutableSet* imagePickerManagerSet = nil;

+ (instancetype)instanceWithDelegate:(id<ImagePickerManagerDelegate>)delegate
{
    ImagePickerManager* manager = [[ImagePickerManager alloc] init];
    manager.delegate = delegate;
    return manager;
}

- (void)pickerImageInViewController:(UIViewController*)viewController
{
    if (imagePickerManagerSet == nil)
    {
        imagePickerManagerSet = [NSMutableSet set];
    }
    
    if ([imagePickerManagerSet containsObject:self] == NO)
    {
        [imagePickerManagerSet addObject:self];
    }
    
    BOOL allowCamera = NO;
    allowCamera = [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
    if (allowCamera)
    {
        UIActionSheet* sheet = [[UIActionSheet alloc] initWithTitle:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:nil
                                                  otherButtonTitles:@"拍照", @"从手机相册选择", nil];
        [sheet setUserObject:viewController];
        [sheet showInView:viewController.view];
    }
    else
    {
        [self pickImageFromPhotosInViewController:viewController];
    }
}

- (void)finishPickerImages:(NSArray*)images
{
    if ([self.delegate respondsToSelector:@selector(imagePickerManager:didPickerImages:)])
    {
        [self.delegate imagePickerManager:self didPickerImages:images];
    }
    
    [imagePickerManagerSet removeObject:self];
}

- (void)pickImageFromCameraInViewController:(UIViewController*)viewController
{
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera] == NO)
    {
        [SVProgressHUD showErrorWithStatus:@"系统不支持照相机"];
        return;
    }
    
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] == NO)
    {
        [SVProgressHUD showErrorWithStatus:@"系统不支持后置照相机"];
        return;
    }
    
    /**
     *  检测设备权限
     */
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"应用尚未开启相机权限，请在设置中启用！"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"去设置", nil];
        [alert show];
        return;
    }
    
    UIImagePickerController* picker = [[UIImagePickerController alloc] init];//初始化
    picker.delegate = self;
    picker.allowsEditing = YES;//设置可编辑
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [viewController presentViewController:picker animated:YES completion:^{
        
    }];
}

- (void)pickImageFromPhotosInViewController:(UIViewController*)viewController
{
    NSInteger maxPickerCount = 1;
    if ([self.delegate respondsToSelector:@selector(imagePickerManagerMaxPickerCount:)])
    {
        maxPickerCount = [self.delegate imagePickerManagerMaxPickerCount:self];
    }
    
    TZImagePickerController* imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:maxPickerCount delegate:self];
    
    // 在这里设置imagePickerVc的外观
    imagePickerVc.navigationBar.barTintColor = COMMON_COLOR;
    [viewController presentViewController:imagePickerVc animated:YES completion:nil];
}

- (UIImage*)scaleImage:(UIImage*)image
{
    CGFloat width  = image.size.width;
    CGFloat height = image.size.height;
    
    if (width == 0.0f || height == 0.0f)
    {
        return image;
    }
    
    if (width < CAMERA_IMAGE_MAX_SIZE || height < CAMERA_IMAGE_MAX_SIZE)
    {
        return image;
    }
    
    CGFloat wScale = CAMERA_IMAGE_MAX_SIZE / width;
    CGFloat hScale = CAMERA_IMAGE_MAX_SIZE / height;
    CGFloat scale  = MAX(wScale, hScale);
    
    width  = image.size.width * scale;
    height = image.size.height * scale;
    
    UIImage* scaleImage = [image scaleToSize:CGSizeMake(width, height)];
    return scaleImage;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage* scaleImage = [self scaleImage:image];
    
    if (scaleImage != nil)
    {
        [self finishPickerImages:@[scaleImage]];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIViewController* viewController = [actionSheet userObject];
    if ([viewController isKindOfClass:[UIViewController class]] == NO)
    {
        viewController = nil;
    }
    
    if (buttonIndex == 0)               // 拍照
    {
        [self pickImageFromCameraInViewController:viewController];
    }
    else if (buttonIndex == 1)          // 从手机相册选择
    {
        [self pickImageFromPhotosInViewController:viewController];
    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)               // 去设置
    {
        [YBUtility jumpToSystemAPPSetting];
    }
}

#pragma mark - TZImagePickerControllerDelegate

// 用户选择好了图片，如果assets非空，则用户选择了原图。
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)asset
{
    if ([[asset firstObject] isKindOfClass:[NSNumber class]])
    {
        NSMutableArray* array = [NSMutableArray array];
        for (UIImage* image in photos)
        {
            UIImage* scaleImage = [self scaleImage:image];
            if (scaleImage != nil)
            {
                [array addObject:scaleImage];
            }
        }
        [self finishPickerImages:array];
    }
    else
    {
        [self finishPickerImages:photos];
    }
}

// 用户选择好了视频
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset
{
}

@end
