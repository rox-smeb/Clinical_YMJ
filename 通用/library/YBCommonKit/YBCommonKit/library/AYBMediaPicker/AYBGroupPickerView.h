//
//  AYBGroupPickerView.h
//  果动校园
//
//  Created by AnYanbo on 15/2/10.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^intBlock)(NSInteger);

@interface AYBGroupPickerView : UIView <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>
{
    
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic, strong) intBlock blockTouchCell;
@property (nonatomic, assign) BOOL isOpen;

- (id)initWithGroups:(NSMutableArray *)groups;

- (void)show;
- (void)dismiss:(BOOL)animated;
- (void)toggle;
- (void)reloadData;

@end
