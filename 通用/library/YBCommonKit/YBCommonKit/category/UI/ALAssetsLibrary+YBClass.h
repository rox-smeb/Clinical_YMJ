//
//  ALAssetsLibrary+YBClass.h
//  果动校园
//
//  Created by AnYanbo on 15/4/11.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^SaveImageCompletion)(NSError* err);

@interface ALAssetsLibrary (YBClass)

- (void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;
- (void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

@end
