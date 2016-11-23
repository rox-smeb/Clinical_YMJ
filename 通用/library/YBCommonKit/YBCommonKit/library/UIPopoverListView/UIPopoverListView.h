//
//  UIPopoverListView.h
//  果动校园
//
//  Created by AnYanbo on 15/1/26.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

@class UIPopoverListView;

typedef void (^UIPopoverListViewDidSelected)(UIPopoverListView* view, NSIndexPath* indexPath, id data);
typedef void (^UIPopoverListViewConfigCell)(UIPopoverListView* view, NSIndexPath* indexPath, UITableViewCell * cell, id dataSources);

/************************* UIPopoverListViewDataSource *************************/
@protocol UIPopoverListViewDataSource <NSObject>
@required

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView cellForIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView numberOfRowsInSection:(NSInteger)section;

@end

/************************** UIPopoverListViewDelegate **************************/
@protocol UIPopoverListViewDelegate <NSObject>
@optional

- (void)popoverListView:(UIPopoverListView *)popoverListView didSelectIndexPath:(NSIndexPath *)indexPath;
- (void)popoverListViewCancel:(UIPopoverListView *)popoverListView;
- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/****************************** UIPopoverListView ******************************/
@interface UIPopoverListView : UIView <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_listView;
    UILabel     *_titleView;
    UIControl   *_overlayView;
    UIView      *_bindView;
}

@property (nonatomic, assign) CGFloat titleHeight;
@property (nonatomic, assign) CGFloat defaultRowHeight;
@property (nonatomic, assign) id<UIPopoverListViewDataSource> datasource;
@property (nonatomic, assign) id<UIPopoverListViewDelegate>   delegate;
@property (nonatomic, strong) UIPopoverListViewDidSelected selectedBlock;
@property (nonatomic, strong) UIPopoverListViewConfigCell configCellBlock;
@property (nonatomic, strong) UIColor* titleColor;
@property (nonatomic, strong) UITableView* listView;
@property (nonatomic, strong) NSArray* dataSources;

+ (id)centerPopupWithDataSource:(NSArray*)data title:(NSString*)title;

- (id)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height;
- (void)setTitle:(NSString *)title;
- (void)bindView:(UIView*)view;
- (void)show;
- (void)dismiss;

- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier;
- (void)registerNib:(UINib *)nib forHeaderFooterViewReuseIdentifier:(NSString *)identifier;
- (void)registerClass:(Class)aClass forHeaderFooterViewReuseIdentifier:(NSString *)identifier;

- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier;
- (id)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath;
- (id)dequeueReusableHeaderFooterViewWithIdentifier:(NSString *)identifier;

@end
