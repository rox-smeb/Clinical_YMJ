//
//  WSMovieController.m
//  StartMovie
//
//  Created by iMac on 16/8/29.
//  Copyright © 2016年 sinfotek. All rights reserved.
//

#import "WSMovieController.h"
#import "MainTabBarController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

@interface WSMovieController ()
@property (strong, nonatomic) MPMoviePlayerController *player;

@end

@implementation WSMovieController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self SetupVideoPlayer];
    [self addNofi];
}


- (void)SetupVideoPlayer
{
//    NSString *myFilePath = [[NSBundle mainBundle]pathForResource:@"media"ofType:@"mp4"];
//    NSURL *movieURL = [NSURL fileURLWithPath:myFilePath];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:_movieURL];
    [self.view addSubview:self.player.view];
    self.player.shouldAutoplay = YES;
    [self.player setControlStyle:MPMovieControlStyleNone];
    //self.player.repeatMode = MPMovieRepeatModeOne;  重复模式
    [self.player.view setFrame:self.view.bounds];
    self.player.view.alpha = 0;
    
    [UIView animateWithDuration:1 animations:^{
        self.player.view.alpha = 1;
        [self.player prepareToPlay];
    }];
    
    [self setupLoginView];
}


- (void)setupLoginView
{
    //进入按钮
    UIButton *enterMainButton = [[UIButton alloc] init];
    enterMainButton.frame = CGRectMake(80, [UIScreen mainScreen].bounds.size.height - 32 - 48, [UIScreen mainScreen].bounds.size.width - 160, 48);
    enterMainButton.layer.borderWidth = 1;
    enterMainButton.layer.cornerRadius = 24.0f;
    enterMainButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [enterMainButton setTitle:@"进入应用" forState:UIControlStateNormal];
    enterMainButton.alpha = 0.4;
    [self.player.view addSubview:enterMainButton];
    [enterMainButton addTarget:self action:@selector(enterMainAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
//    [UIView animateWithDuration:3.0 animations:^{
//        enterMainButton.alpha = 1.0;
//    }];
}


- (void)enterMainAction:(UIButton *)btn {
    NSLog(@"进入应用");
    [self changeRootViewController];
}

/**
 *  添加视频播放的通知
 */
- (void)addNofi
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}

- (void)playDidFinish:(NSNotification *)noti
{
    //播放完成
    [self changeRootViewController];
}

- (void)changeRootViewController
{
    MainTabBarController *mainTVC = [MainTabBarController viewController];
    self.view.window.rootViewController = mainTVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
