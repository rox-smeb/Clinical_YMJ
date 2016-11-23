//
//  NSObject+JCAdditionsORM.m
//  FMDBHelper
//
//  Created by 李京城 on 15/4/27.
//  Modify by AnYanbo on 16/6/18.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "NSObject+JCAdditionsORM.h"
#import <objc/runtime.h>

NSString * const identifier = @"id";

@implementation NSObject (JCAdditionsORM)

static const void *IDKey;

- (instancetype)initWithJSON:(NSDictionary *)keyValues
{
    if (self = [self init])
    {
        if ([keyValues isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *objectPropertys = [self objectPropertys];
            NSDictionary *mapping = [self mapping];
            
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:keyValues.count];
            [keyValues enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
                NSString *useKey = mapping[key] ? : key;
                
                if ([useKey isEqualToString:identifier])
                {
                    useKey = NSStringFromSelector(@selector(ID));
                }
                
                if ([obj jc_isValid])
                {
                    if ([obj isKindOfClass:[NSString class]])
                    {
                        NSError *error = nil;
                        
                        id jsonObject = [NSJSONSerialization JSONObjectWithData:[obj dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
                        
                        if (!error)
                        {
                            obj = jsonObject;
                        }
                    }
                    
                    if ([obj isKindOfClass:[NSNumber class]] && [self jc_isStringProperty:key])
                    {
                        obj = [obj stringValue];
                    }
                    
                    if (objectPropertys[useKey] && [obj isKindOfClass:[NSDictionary class]])
                    {
                        obj = [[objectPropertys[useKey] alloc] initWithJSON:obj];
                    }
                    
                    // Added by AnYanbo
                    if (objectPropertys[useKey] && [obj isKindOfClass:[NSArray class]])
                    {
                        NSMutableArray* array = [NSMutableArray array];
                        for (NSDictionary* json in obj)
                        {
                            id instance = [[objectPropertys[useKey] alloc] initWithJSON:json];
                            if (instance != nil)
                            {
                                [array addObject:instance];
                            }
                        }
                        obj = array;
                    }
                    
                    [dict setObject:obj forKey:useKey];
                }
                else
                {
                    NSObject* value = [self jc_defaultValueForKey:useKey];
                    if (value != nil)
                    {
                        [dict setObject:value forKey:key];
                    }
                }
            }];
            
            [self setValuesForKeysWithDictionary:dict];
        }
    }
    
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //NSLog(@"%@, %@", key, value);
}

- (NSString *)ID
{
    return objc_getAssociatedObject(self, &IDKey);
}

- (void)setID:(NSString *)ID
{
    NSAssert(ID, @"ID cannot be nil!");
    
    objc_setAssociatedObject(self, &IDKey, ID, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSMutableDictionary *)keyValues
{
    NSDictionary *objectPropertys = [self objectPropertys];
    
    NSDictionary *keyValues = [self dictionaryWithValuesForKeys:self.jc_propertys];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:keyValues.count];
    
    [keyValues enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if ([obj jc_isValid])
        {
            if (objectPropertys[key])
            {
                obj = [obj keyValues];
            }
            
            if ([key isEqualToString:NSStringFromSelector(@selector(ID))])
            {
                key = identifier;
            }
            
            if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]])
            {
                NSError *error = nil;
                NSData *json = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
                
                if (!error)
                {
                    obj = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
                }
            }
            
            [dict setObject:obj forKey:key];
        }
        else
        {
            [dict setObject:[self jc_defaultValueForKey:key] forKey:key];
        }
    }];
    
    return dict;
}

- (NSDictionary *)objectPropertys
{
    return @{};
}

- (NSDictionary *)mapping
{
    return @{};
}

+ (NSString *)tableName
{
    return NSStringFromClass([self class]);
}

#pragma mark -

- (id)jc_defaultValueForKey:(NSString *)key
{
    id defaultValue = nil;
    
    objc_property_t property = class_getProperty([self class], key.UTF8String);
    
    if (property != NULL)
    {
        NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        if ([propertyType hasPrefix:@"T@\"NSString\""])
        {
            defaultValue = @"";
        }
        else if ([propertyType hasPrefix:@"T@\"NSMutableString\""])
        {
            defaultValue = [NSMutableString string];
        }
        else if ([propertyType hasPrefix:@"T@\"NSDictionary\""])
        {
            defaultValue = @{};
        }
        else if ([propertyType hasPrefix:@"T@\"NSMutableDictionary\""])
        {
            defaultValue = [NSMutableDictionary dictionary];
        }
        else if ([propertyType hasPrefix:@"T@\"NSArray\""])
        {
            defaultValue = @[];
        }
        else if ([propertyType hasPrefix:@"T@\"NSMutableArray\""])
        {
            defaultValue = [NSMutableArray array];
        }
        else if ([propertyType hasPrefix:@"T@\"NSNumber\""])
        {
            defaultValue = [NSNumber numberWithInt:0];
        }
        else if ([propertyType hasPrefix:@"T@\"NSNull\""])
        {
            defaultValue = nil;
        }
    }
    
    return defaultValue;
}


- (BOOL)jc_isStringProperty:(NSString *)key
{
    BOOL isStringProperty = NO;
    
    objc_property_t property = class_getProperty(self.class, key.UTF8String);
    
    if (property != NULL)
    {
        NSString *propertyType = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
        
        if ([propertyType respondsToSelector:@selector(containsString:)])
        {
            isStringProperty = [propertyType containsString:@"String"];
        }
        else
        {
            isStringProperty = !NSEqualRanges([propertyType rangeOfString:@"String"], NSMakeRange(NSNotFound, 0));
        }
    }
    
    return isStringProperty;
}

- (NSMutableArray *)jc_propertys
{
    NSMutableArray *allKeys = [[NSMutableArray alloc] initWithCapacity:10];
    [allKeys addObject:NSStringFromSelector(@selector(ID))];
    
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for(int i = 0 ; i < count ; i++)
    {
        [allKeys addObject:[NSString stringWithCString:property_getName(properties[i]) encoding:NSUTF8StringEncoding]];
    }
    
    free(properties);
    
    return allKeys;
}

- (BOOL)jc_isValid
{
    return !(self == nil || [self isKindOfClass:[NSNull class]]);
}

@end