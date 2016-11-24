//
//  FindClassifyInfo.h
//  求美者端
//
//  Created by apple on 2016/11/24.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ClassifyChildInfo:NSObject
@property(nonatomic,strong)NSString* cId;
@property(nonatomic,strong)NSString* cName;
@end

@interface FindClassifyInfo : NSObject
@property(nonatomic,strong)NSString* pId;
@property(nonatomic,strong)NSString* pName;
@property(nonatomic,strong)NSArray<ClassifyChildInfo*>* cList;
@end
