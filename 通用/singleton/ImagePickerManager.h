//
//  ImagePickerManager.h
//  求美者端
//
//  Created by AnYanbo on 16/8/16.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ImagePickerManager;

@protocol ImagePickerManagerDelegate <NSObject>

@optional

- (NSInteger)imagePickerManagerMaxPickerCount:(ImagePickerManager*)manager;
- (void)imagePickerManager:(ImagePickerManager*)manager didPickerImages:(NSArray<UIImage*>*)images;

@end

@interface ImagePickerManager : NSObject

@property (weak, nonatomic) id<ImagePickerManagerDelegate> delegate;

+ (instancetype)instanceWithDelegate:(id<ImagePickerManagerDelegate>)delegate;
- (void)pickerImageInViewController:(UIViewController*)viewController;

@end
