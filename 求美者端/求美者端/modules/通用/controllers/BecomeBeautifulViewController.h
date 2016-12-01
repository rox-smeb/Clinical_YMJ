//
//  BecomeBeautifulViewController.h
//  求美者端
//
//  Created by Smeb on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BecomeBeautifulViewController;

@protocol BecomeBeautifulViewControllerDelegate <NSObject>

- (void)loadCityListWithCid:(NSString *)cid
                        pid:(NSString*)pid;

- (void)loadProjectListWithFid:(NSString*)fid
                           oid:(NSString*)oid;

@end


@interface BecomeBeautifulViewController : UIViewController

@property (strong, nonatomic) NSString* cid;                                // 国家id
@property (strong, nonatomic) NSString* pid;                                // 省id
@property (strong, nonatomic) NSString* fid;                                // 项目id
@property (strong, nonatomic) NSString* oid;                                // 具体项目id

@property (weak, nonatomic) id<BecomeBeautifulViewControllerDelegate> delegate;

+ (instancetype)viewController;

@end
