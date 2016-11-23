//
//  AYBAssetsPickerViewController.h
//  果动校园
//
//  Created by AnYanbo on 15/2/6.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AYBGroupPickerView.h"

typedef void (^AssetsSuccessBlock)(void);

@class AYBAssetsPickerViewController;

@protocol AYBAssetsPickerViewControllerDelegate<NSObject>

- (void)AYBAssetsPickerViewController:(AYBAssetsPickerViewController *)picker didFinishPickingAssets:(NSArray *)assets;

@optional

- (void)AYBAssetsPickerViewControllerDidCancel:(AYBAssetsPickerViewController *)picker;

@end

@interface AYBAssetsPickerViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
{
    
}

@property (nonatomic, weak) id <AYBAssetsPickerViewControllerDelegate> delegate;

@property (nonatomic, strong) ALAssetsFilter* assetsFilter;                                 // 资源过滤器
@property (nonatomic, assign) NSInteger maximumNumberOfSelectionVideo;                      // 最大可选择视频数量
@property (nonatomic, assign) NSInteger maximumNumberOfSelectionPhoto;                      // 最大可选择图片数量
@property (nonatomic, assign) NSInteger maximumNumberOfSelectionMedia;                      // 最大可选择媒体数量(视频、图片)

@property (weak, nonatomic) UIColor* topBarColor;                                           // 顶部工具栏颜色
@property (weak, nonatomic) IBOutlet UIView *topBar;                                        // 顶部工具栏
@property (weak, nonatomic) IBOutlet UIView *bottomBar;                                     // 底部工具栏

@property (weak, nonatomic) IBOutlet UIButton *navCloseButton;                              // 顶部工具栏关闭按钮
@property (weak, nonatomic) IBOutlet UILabel *navTitleLabel;                                // 顶部标题
@property (weak, nonatomic) IBOutlet UIImageView *navTitleArrowImageView;                   // 顶部标题向下箭头

@property (weak, nonatomic) IBOutlet UIButton *cameraButton;                                // 底部照相机按钮
@property (weak, nonatomic) IBOutlet UIButton *doneButton;                                  // 底部完成按钮
@property (weak, nonatomic) IBOutlet UILabel *bottomHintLabel;                              // 底部提示信息

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;                      // 图片展示区
@property (weak, nonatomic) IBOutlet UIView *photoHintView;                                 // 无法访问相册提示view

+ (instancetype)create;

@end
