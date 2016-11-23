//
//  HZAreaPickerView.h
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZLocation.h"

typedef enum {
    HZAreaPickerWithStateAndCity,
    HZAreaPickerWithStateAndCityAndDistrict
} HZAreaPickerStyle;

@class HZAreaPickerView;

@protocol HZAreaPickerDatasource <NSObject>

- (NSArray *)areaPickerData:(HZAreaPickerView *)picker;

@end

@protocol HZAreaPickerDelegate <NSObject>

@optional
- (void)pickerDidChaneStatus:(HZAreaPickerView *)picker;

@end

@interface HZAreaPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) id <HZAreaPickerDelegate> delegate;
@property (weak, nonatomic) id <HZAreaPickerDatasource> datasource;
@property (assign, nonatomic) CGFloat animateDur;
@property (strong, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (strong, nonatomic) HZLocation *locate;
@property (assign, nonatomic) HZAreaPickerStyle pickerStyle;

- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle withDelegate:(id <HZAreaPickerDelegate>)delegate andDatasource:(id <HZAreaPickerDatasource>)datasource;
- (void)showInView:(UIView *)view;
- (void)cancelPicker;

- (void)selectDefault;
- (void)selectProvince:(NSString*)p city:(NSString*)c zone:(NSString*)z;

@end
