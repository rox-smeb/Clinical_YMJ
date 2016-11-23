//
//  HZAreaPickerView.m
//  areapicker
//
//  Created by Cloud Dai on 12-9-9.
//  Copyright (c) 2012年 clouddai.com. All rights reserved.
//

#import "HZAreaPickerView.h"
#import <QuartzCore/QuartzCore.h>

@interface HZAreaPickerView ()
{
    NSArray *provinces, *cities, *areas;
    UIView* _backView;
}

@end

@implementation HZAreaPickerView

@synthesize delegate=_delegate;
@synthesize datasource=_datasource;
@synthesize pickerStyle=_pickerStyle;
@synthesize locate=_locate;

- (void)dealloc
{
    self.datasource = nil;
    self.delegate = nil;
}

- (HZLocation *)locate
{
    if (_locate == nil) {
        _locate = [[HZLocation alloc] init];
    }
    
    return _locate;
}

- (id)initWithStyle:(HZAreaPickerStyle)pickerStyle withDelegate:(id <HZAreaPickerDelegate>)delegate andDatasource:(id <HZAreaPickerDatasource>)datasource
{
    self = [[[NSBundle mainBundle] loadNibNamed:@"HZAreaPickerView" owner:self options:nil] firstObject];
    if (self)
    {
        self.animateDur = 0.2f;
        self.delegate = delegate;
        self.pickerStyle = pickerStyle;
        self.datasource = datasource;
        self.locatePicker.dataSource = self;
        self.locatePicker.delegate = self;
        
        provinces = [self.datasource areaPickerData:self];
        cities = [[provinces objectAtIndex:0] objectForKey:@"cities"];
        self.locate.state = [[provinces objectAtIndex:0] objectForKey:@"state"];
        if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
            self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
            
            areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
            if (areas.count > 0) {
                self.locate.district = [areas objectAtIndex:0];
            } else{
                self.locate.district = @"";
            }
            
        } else{
            self.locate.city = [cities objectAtIndex:0];
        }
    }
        
    return self;
}

#pragma mark - PickerView lifecycle

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        return 3;
    } else{
        return 2;
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [provinces count];
            break;
        case 1:
            return [cities count];
            break;
        case 2:
            if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
                return [areas count];
                break;
            }
        default:
            return 0;
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
{
    CGFloat width = 0.0f;
    if (component == 0)
    {
        width = pickerView.frame.size.width * 0.3;
    }
    
    if (component == 1)
    {
        width = pickerView.frame.size.width * 0.4;
    }
    
    if (component == 2)
    {
        width = pickerView.frame.size.width * 0.3;
    }

    return width;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [[cities objectAtIndex:row] objectForKey:@"city"];
                break;
            case 2:
                if ([areas count] > 0) {
                    return [areas objectAtIndex:row];
                    break;
                }
            default:
                return  @"";
                break;
        }
    } else{
        switch (component) {
            case 0:
                return [[provinces objectAtIndex:row] objectForKey:@"state"];
                break;
            case 1:
                return [cities objectAtIndex:row];
                break;
            default:
                return @"";
                break;
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    CGSize rowSize = [pickerView rowSizeForComponent:component];
    if (view == nil)
    {
        view = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, rowSize.width, rowSize.height)];
        UILabel* label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 1000;
        [view addSubview:label];
        
        [[label autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:2.0f] autoInstall];
        [[label autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:2.0f] autoInstall];
        [[label autoPinEdgeToSuperviewEdge:ALEdgeTop] autoInstall];
        [[label autoPinEdgeToSuperviewEdge:ALEdgeBottom] autoInstall];
    }
    
    UILabel* label = (UILabel*)[view viewWithTag:1000];
    NSString* title = [self pickerView:pickerView titleForRow:row forComponent:component];
    label.text = title;
    
    return view;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (self.pickerStyle == HZAreaPickerWithStateAndCityAndDistrict) {
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                areas = [[cities objectAtIndex:0] objectForKey:@"areas"];
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [[cities objectAtIndex:0] objectForKey:@"city"];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 1:
                areas = [[cities objectAtIndex:row] objectForKey:@"areas"];
                [self.locatePicker selectRow:0 inComponent:2 animated:YES];
                [self.locatePicker reloadComponent:2];
                
                self.locate.city = [[cities objectAtIndex:row] objectForKey:@"city"];
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:0];
                } else{
                    self.locate.district = @"";
                }
                break;
            case 2:
                if ([areas count] > 0) {
                    self.locate.district = [areas objectAtIndex:row];
                } else{
                    self.locate.district = @"";
                }
                break;
            default:
                break;
        }
    } else{
        switch (component) {
            case 0:
                cities = [[provinces objectAtIndex:row] objectForKey:@"cities"];
                [self.locatePicker selectRow:0 inComponent:1 animated:YES];
                [self.locatePicker reloadComponent:1];
                
                self.locate.state = [[provinces objectAtIndex:row] objectForKey:@"state"];
                self.locate.city = [cities objectAtIndex:0];
                break;
            case 1:
                self.locate.city = [cities objectAtIndex:row];
                break;
            default:
                break;
        }
    }
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)]) {
        [self.delegate pickerDidChaneStatus:self];
    }
}

- (void)onBackTap:(UITapGestureRecognizer*)tap
{
    [self cancelPicker];
}

#pragma mark - animation

- (void)showInView:(UIView *)view
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
    _backView.backgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.6];
    
    UITapGestureRecognizer* backTap = [[UITapGestureRecognizer alloc] init];
    backTap.numberOfTapsRequired = 1;
    [backTap addTarget:self action:@selector(onBackTap:)];
    
    [_backView addGestureRecognizer:backTap];
    [view addSubview:_backView];
    
    self.frame = CGRectMake(0, view.frame.size.height, self.frame.size.width, self.frame.size.height);
    [view addSubview:self];
    
    [UIView animateWithDuration:self.animateDur animations:^{
        self.frame = CGRectMake(0, view.frame.size.height - self.frame.size.height, self.frame.size.width, self.frame.size.height);
    }];
    
}

- (void)cancelPicker
{
    [UIView animateWithDuration:self.animateDur
                     animations:^{
                         self.frame = CGRectMake(0, self.frame.origin.y + self.frame.size.height, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         [
                          _backView removeFromSuperview];
                         [self removeFromSuperview];
                     }];
    
}

- (void)selectDefault
{
    [self.locatePicker selectRow:0 inComponent:0 animated:NO];
    [self.locatePicker selectRow:0 inComponent:1 animated:NO];
    [self.locatePicker selectRow:0 inComponent:2 animated:NO];
    
    if([self.delegate respondsToSelector:@selector(pickerDidChaneStatus:)])
    {
        [self.delegate pickerDidChaneStatus:self];
    }
}

- (void)selectProvince:(NSString*)p city:(NSString*)c zone:(NSString*)z
{
    @try
    {
        [provinces enumerateObjectsUsingBlock:^(NSDictionary* dict, NSUInteger idx, BOOL *stop) {
            NSString* state = [dict objectForKey:@"state"];
            if ([state isEqualToString:p])
            {
                cities = [dict objectForKey:@"cities"];
                [self.locatePicker reloadComponent:1];
                [self.locatePicker selectRow:idx inComponent:0 animated:NO];
                
                [self pickerView:self.locatePicker didSelectRow:idx inComponent:0];
                *stop = YES;
            }
        }];
        
        [cities enumerateObjectsUsingBlock:^(NSDictionary* dict, NSUInteger idx, BOOL *stop) {
            NSString* city = [dict objectForKey:@"city"];
            if ([city isEqualToString:c])
            {
                areas = [dict objectForKey:@"areas"];
                [self.locatePicker reloadComponent:2];
                [self.locatePicker selectRow:idx inComponent:1 animated:NO];
                
                [self pickerView:self.locatePicker didSelectRow:idx inComponent:1];
                *stop = YES;
            }
        }];
        
        [areas enumerateObjectsUsingBlock:^(NSString* area, NSUInteger idx, BOOL *stop) {
            if ([area isEqualToString:z])
            {
                [self.locatePicker selectRow:idx inComponent:2 animated:NO];
                
                [self pickerView:self.locatePicker didSelectRow:idx inComponent:2];
                *stop = YES;
            }
        }];
    }
    @catch (NSException *exception)
    {
        [self selectDefault];
    }
}

@end
