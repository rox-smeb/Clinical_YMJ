//
//  AYBWrapperPickerController.m
//  果动校园
//
//  Created by AnYanbo on 15/2/10.
//  Copyright (c) 2015年 GDSchool. All rights reserved.
//

#import "AYBWrapperPickerController.h"

@interface AYBWrapperPickerController ()

@end

@implementation AYBWrapperPickerController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -  View Controller Setting / Rotation

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIViewController *)childViewControllerForStatusBarHidden
{
    return nil;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
