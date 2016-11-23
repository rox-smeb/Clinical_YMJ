//
//  CommonEmptyListView.m
//  昆明团购
//
//  Created by AnYanbo on 15/8/2.
//  Copyright (c) 2015年 NL. All rights reserved.
//

#import "CommonEmptyListView.h"

@interface CommonEmptyListView ()

@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end

@implementation CommonEmptyListView

+ (instancetype)configTableView:(UITableView*)tableView emptyText:(NSString*)text
{
    CommonEmptyListView* header = [CommonEmptyListView create];
    [header setEmptyText:text];
    
    if ([tableView respondsToSelector:@selector(setNxEV_emptyView:)])
    {
        [tableView setNxEV_emptyView:header];
    }
    
    return header;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.autoresizingMask = UIViewAutoresizingNone;
}

- (void)setEmptyText:(NSString*)text
{
    self.title.text = text;
}

- (void)show
{
    [self.image setHidden:NO];
    [self.title setHidden:NO];
}

- (void)hide
{
    [self.image setHidden:YES];
    [self.title setHidden:YES];
}
 
@end
