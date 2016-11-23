//
//  NSString+URLParam.m
//  昆明团购
//
//  Created by AnYanbo on 15/10/15.
//  Copyright © 2015年 NL. All rights reserved.
//

#import "NSString+URLParam.h"

@implementation NSString (URLParam)

- (NSDictionary *)parametersWithSeparator:(NSString *)separator delimiter:(NSString *)delimiter
{
    NSArray *parameterPairs = [self componentsSeparatedByString:delimiter];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithCapacity:[parameterPairs count]];
    for (NSString *currentPair in parameterPairs)
    {
        NSRange range = [currentPair rangeOfString:separator];
        if (range.location == NSNotFound)
        {
            continue;
        }
        NSString *key = [currentPair substringToIndex:range.location];
        NSString *value =[currentPair substringFromIndex:range.location + 1];
        [parameters setObject:value forKey:key];
    }
    return parameters;
}

@end
