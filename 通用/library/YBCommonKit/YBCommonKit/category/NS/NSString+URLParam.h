//
//  NSString+URLParam.h
//  昆明团购
//
//  Created by AnYanbo on 15/10/15.
//  Copyright © 2015年 NL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLParam)

- (NSDictionary *)parametersWithSeparator:(NSString *)separator delimiter:(NSString *)delimiter;

@end
