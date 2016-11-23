//
//  GarageAbilityTableViewCell.h
//  车联网-车主端
//
//  Created by AnYanbo on 16/7/26.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GarageAbilityTableViewCell;

@protocol GarageAbilityTableViewCellDelegate <NSObject>

- (void)header:(GarageAbilityTableViewCell*)header didSelectItemAtIndex:(NSInteger)index;

@end


@interface GarageAbilityTableViewCell : UITableViewCell

@property (nonatomic, weak) id<GarageAbilityTableViewCellDelegate> delegate;

/**
 *  通过传入数据计算cell高度
 *
 *  @param firstInfo 数据 @"name1,name2,name3 ...."
 *
 *  @return 高度
 */
+ (CGFloat)heightWithInfos:(NSString*)firstInfo, ... NS_REQUIRES_NIL_TERMINATION;
+ (CGFloat)height;

/**
 *  开始配置cell数据
 */
- (void)beginConfig;

/**
 *  添加数据
 *
 *  @param info  数据 @"name1,name2,name3 ...." (默认使用,进行分割)
 *  @param title section的标题
 */
- (void)addAbilityInfo:(NSString*)info title:(NSString*)title;

/**
 *  添加数据
 *
 *  @param info      数据 @"name1,name2,name3 ...."
 *  @param title     section的标题
 *  @param separator 使用separator对info进行分割
 */
- (void)addAbilityInfo:(NSString*)info title:(NSString*)title infoSeparator:(NSString*)separator;

/**
 *  结束配置cell数据
 */
- (void)endConfig;

@end
