//
//  NSURL+Utility.m
//  果动校园
//
//  Created by AnYanbo on 15/4/23.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "NSURL+Utility.h"

@implementation NSURL (Utility)

- (NSDictionary*)parametersDict
{
    NSDictionary* dict = nil;
    @try
    {
        NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
        NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
        NSScanner* scanner = [[NSScanner alloc] initWithString:self.query];
        while (![scanner isAtEnd])
        {
            NSString* pairString = nil;
            [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            NSArray* kvPair = [pairString componentsSeparatedByString:@"="];
            if (kvPair.count == 2)
            {
                NSString* key = [[kvPair objectAtIndex:0]
                                 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [pairs setObject:value forKey:key];
            }
        }
        
        dict = [NSDictionary dictionaryWithDictionary:pairs];
    }
    @catch (NSException *exception)
    {
        dict = @{};
    }
    return dict;
}

@end
