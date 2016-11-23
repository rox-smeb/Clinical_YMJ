//
//  BROptionsButton.h
//  BROptionsButtonDemo
//
//  Created by Basheer Malaa on 3/10/14.
//  Copyright (c) 2014 Basheer Malaa. All rights reserved.
//
//  Modify by AnYanbo on 2015-01-09
//

#import <UIKit/UIKit.h>
#import "BROptionItem.h"

typedef enum
{
    BROptionsButtonStateOpened,
    BROptionsButtonStateClosed,
    BROptionsButtonStateNormal
}BROptionsButtonStates;

@protocol BROptionButtonDelegate;

@interface BROptionsButton : UIButton

/*!
 * TabBar currently installed on
 */
@property (nonatomic, readonly, weak) UITabBar *tabBar;
@property (nonatomic, assign) NSInteger locationIndexInTabBar;
@property (nonatomic, assign) BOOL itemPressedAnimate;
@property (nonatomic, weak) id<BROptionButtonDelegate> delegate;
@property (nonatomic, readonly) BROptionsButtonStates currentState;

/*!
 *!parameters: tabBar     - pass the tabBar to be attached to
 *             itemIndex - the item position that will be changed with the button
 *             delgate   - the delegate must be setted
 */
- (instancetype)initForTabBar:(UITabBar*)tabBar
                 forItemIndex:(NSUInteger)itemIndex
                     delegate:(id<BROptionButtonDelegate>)delegate;
/*! 
 * Set the image for the open state (X in the demo)
 * and for the close state (Apple in the demo)
 */
- (void)setImage:(UIImage *)image forBROptionsButtonState:(BROptionsButtonStates)state;
/**
 *  Release Observer
 */
- (void)purge;

@end

//-------------------------------------------
@protocol BROptionButtonDelegate <NSObject>

- (void)brOptionsButton:(BROptionsButton*)brOptionsButton didSelectItem:(BROptionItem*)item;
- (NSInteger)brOptionsButtonNumberOfItems:(BROptionsButton*)brOptionsButton;

@optional

- (void)brOptionsButton:(BROptionsButton*)brOptionsButton didClosedItem:(BROptionItem*)item;
- (void)brOptionsButton:(BROptionsButton*)brOptionsButton willDisplayButtonItem:(BROptionItem*)button;
- (NSString*)brOptionsButton:(BROptionsButton*)brOptionsButton titleForItemAtIndex:(NSInteger)index;
- (UIImage*)brOptionsButton:(BROptionsButton*)brOptionsButton imageForItemAtIndex:(NSInteger)index;
- (UIImage*)brOptionsButton:(BROptionsButton*)brOptionsButton selImageForItemAtIndex:(NSInteger)index;

@end

