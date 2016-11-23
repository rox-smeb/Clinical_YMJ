//
//  HZLocation.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZLocation.h"

@implementation HZLocation

@synthesize country = _country;
@synthesize state = _state;
@synthesize city = _city;
@synthesize district = _district;
@synthesize street = _street;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

- (NSString*)locationString
{
    NSMutableString* l = [NSMutableString string];
    if (self.state != nil)
    {
        [l appendFormat:@"%@ ", self.state];
    }
    
    if (self.city != nil)
    {
        [l appendFormat:@"%@ ", self.city];
    }
    
    if (self.district != nil)
    {
        [l appendFormat:@"%@", self.district];
    }
    return l;
}

@end
