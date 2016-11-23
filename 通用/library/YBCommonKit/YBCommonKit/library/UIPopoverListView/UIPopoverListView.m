//
//  UIPopoverListView.m
//  果动校园
//
//  Created by AnYanbo on 15/1/26.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "UIPopoverListView.h"
#import <QuartzCore/QuartzCore.h>

#define DEFAULT_TABLE_VIEW_CELL                         (@"DefaultTableViewCell")
#define DEFAULT_TABLE_CELL_HEIGHT                       (50.0f)

@interface UIPopoverListView ()

- (void)defalutInit;
- (void)fadeIn;
- (void)fadeOut;

@end

@implementation UIPopoverListView

+ (id)centerPopupWithDataSource:(NSArray*)data title:(NSString*)title
{
    CGRect appFrame       = [[UIScreen mainScreen] applicationFrame];
    CGFloat maxHeight     = appFrame.size.height - 100.0f;
    CGFloat xOffset       = 20.0f;
    CGFloat yOffset       = 0.0f;
    CGFloat xWidth        = appFrame.size.width - xOffset * 2;
    CGFloat yHeight       = 0.0f;
    CGFloat contentHeight = [data count] * DEFAULT_TABLE_CELL_HEIGHT;
    CGFloat titleHeight   = 35.0f;
    
    if (contentHeight + titleHeight > maxHeight)
    {
        yHeight = maxHeight;
    }
    else
    {
        yHeight = contentHeight + titleHeight;
    }
    
    yOffset = (appFrame.size.height - yHeight) / 2.0f;
    
    CGRect popFrame = CGRectMake(xOffset, yOffset, xWidth, yHeight);
    UIPopoverListView* view = [[UIPopoverListView alloc] initWithFrame:popFrame titleHeight:titleHeight];
    view.dataSources = data;
    [view setTitle:title];
    return view;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self defalutInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.titleHeight = height;
        [self defalutInit];
    }
    return self;
}

- (void)defalutInit
{
    // 边框圆角
    self.layer.borderColor         = [[UIColor lightGrayColor] CGColor];
    self.layer.borderWidth         = 1.0f;
    self.layer.cornerRadius        = 4.0f;
    self.clipsToBounds             = YES;

    if (self.titleColor == nil)
    {
        self.titleColor = UIColorMake(120, 120, 120);
    }
    
    CGFloat xWidth                 = self.bounds.size.width;

    _defaultRowHeight              = DEFAULT_TABLE_CELL_HEIGHT;
    _titleHeight                   = 32.0f;

    // 初始化数据源
    _datasource                    = nil;

    // 初始化关联的View
    _bindView                      = nil;
    
    // 初始化block
    _selectedBlock                 = nil;
    _configCellBlock               = nil;
    
    // 标题view
    _titleView                     = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleView.font                = [UIFont systemFontOfSize:17.0f];
    _titleView.backgroundColor     = self.titleColor;
    _titleView.textAlignment       = UITextAlignmentCenter;
    _titleView.textColor           = [UIColor whiteColor];
    _titleView.lineBreakMode       = UILineBreakModeTailTruncation;
    _titleView.frame               = CGRectMake(0, 0, xWidth, _titleHeight);
    [self addSubview:_titleView];

    // 配置listView
    CGRect tableFrame              = CGRectMake(0, _titleHeight, xWidth, self.bounds.size.height-32.0f);
    _listView                      = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];
    _listView.scrollEnabled        = YES;
    _listView.delaysContentTouches = YES;
    _listView.bounces              = NO;
    _listView.dataSource           = self;
    _listView.delegate             = self;
    [_listView registerClass:[UITableViewCell class] forCellReuseIdentifier:DEFAULT_TABLE_VIEW_CELL];
    
    // ios8去掉分割线开始空白
    [_listView removeSeperatorBlank];
    
    [self addSubview:_listView];
    
    // 背景
    _overlayView                 = [[UIControl alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _overlayView.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.5];
    [_overlayView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    _titleView.backgroundColor = titleColor;
}

- (void)setTitle:(NSString *)title
{
    _titleView.text = title;
}

- (void)bindView:(UIView*)view
{
    _bindView = view;
}

- (void)show
{
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:_overlayView];
    [keywindow addSubview:self];
    
    self.center = CGPointMake(keywindow.bounds.size.width/2.0f,
                              keywindow.bounds.size.height/2.0f);
    [self fadeIn];
}

- (void)dismiss
{
    [self fadeOut];
}

#pragma mark - Reusable Cell

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier
{
    [_listView registerNib:nib forCellReuseIdentifier:identifier];
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier
{
    [_listView registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (void)registerNib:(UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *)identifier
{
    [_listView registerNib:nib forCellReuseIdentifier:identifier];
}

- (void)registerClass:(Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier
{
    [_listView registerClass:aClass forHeaderFooterViewReuseIdentifier:identifier];
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier
{
    return [_listView dequeueReusableCellWithIdentifier:identifier];
}

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath
{
    return [_listView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
}

- (id)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier
{
    return [_listView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.datasource && [self.datasource respondsToSelector:@selector(popoverListView:numberOfRowsInSection:)])
    {
        NSInteger count = [self.datasource popoverListView:self numberOfRowsInSection:section];
        return count;
    }
    
    if (_dataSources != nil)
    {
        return [_dataSources count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datasource && [self.datasource respondsToSelector:@selector(popoverListView:cellForIndexPath:)])
    {
        return [self.datasource popoverListView:self cellForIndexPath:indexPath];
    }
    
    if (_dataSources != nil)
    {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:DEFAULT_TABLE_VIEW_CELL forIndexPath:indexPath];
        
        if (_configCellBlock != nil)
        {
            _configCellBlock(self, indexPath, cell, _datasource);
        }
        else
        {
            if (indexPath.item < [_dataSources count])
            {
                NSString* text = [_dataSources objectAtIndex:indexPath.item];
                cell.textLabel.text = text;
            }
        }
        
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListView:heightForRowAtIndexPath:)])
    {
        return [self.delegate popoverListView:self heightForRowAtIndexPath:indexPath];
    }
    
    if (_dataSources != nil)
    {
        return DEFAULT_TABLE_CELL_HEIGHT;
    }
    
    return 0.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 调用delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListView:didSelectIndexPath:)])
    {
        [self.delegate popoverListView:self didSelectIndexPath:indexPath];
    }
    
    // 调用block
    if (_selectedBlock != nil)
    {
        if (indexPath.item < [self.dataSources count])
        {
            NSString* text = [self.dataSources objectAtIndex:indexPath.item];
            _selectedBlock(self, indexPath, text);
        }
    }
    
    // 修改bindView
    if (_bindView != nil)
    {
        if (indexPath.item < [self.dataSources count])
        {
            NSString* text = [self.dataSources objectAtIndex:indexPath.item];
            
            if ([_bindView isKindOfClass:[UITextView class]])
            {
                UITextView* textView = (UITextView*)_bindView;
                textView.text = text;
            }
            else if ([_bindView isKindOfClass:[UITextField class]])
            {
                UITextField* textField = (UITextField*)_bindView;
                textField.text = text;
            }
            else if ([_bindView isKindOfClass:[UIView class]])
            {
                [_bindView setSubViewText:text];
            }
        }
    }
    
    [self dismiss];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // ios8去掉分割线开始空白
    [cell removeSeperatorBlank];
}

#pragma mark - animations

- (void)fadeIn
{
    self.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.alpha = 0;
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}
- (void)fadeOut
{
    [UIView animateWithDuration:0.15 animations:^{
        self.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished)
        {
            [_overlayView removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}

#define mark - UITouch

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // tell the delegate the cancellation
    if (self.delegate && [self.delegate respondsToSelector:@selector(popoverListViewCancel:)])
    {
        [self.delegate popoverListViewCancel:self];
    }
    
    // dismiss self
    [self dismiss];
}

@end
