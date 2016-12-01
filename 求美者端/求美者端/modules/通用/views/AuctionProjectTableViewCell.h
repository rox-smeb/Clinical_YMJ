//
//  AuctionProjectTableViewCell.h
//  求美者端
//
//  Created by Smeb on 2016/11/30.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AuctionProjectInfo.h"

@interface AuctionProjectTableViewCell : UITableViewCell

+ (CGFloat)height;

- (void)setUpWithAuctionProjectInfo:(AuctionProjectInfo*)auctionProjectInfo;
- (void)setupWithInfo:(AuctionProjectInfo*)auctionProjectInfo orderInfo:(AuctionProUrlInfo*)auctionProUrlInfo;

@end
