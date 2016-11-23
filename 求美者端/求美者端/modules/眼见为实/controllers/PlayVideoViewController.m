//
//  PlayVideoViewController.m
//  求美者端
//
//  Created by Smeb on 2016/11/23.
//  Copyright © 2016年 AnYanbo. All rights reserved.
//

#import "PlayVideoViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface PlayVideoViewController ()

@property (nonatomic, strong) MPMoviePlayerController *moviePlayer;

@end

@implementation PlayVideoViewController

+ (instancetype)viewController
{
    PlayVideoViewController* ctrl = [[self class] viewControllerWithStoryboardName:@"Believe"];
    return ctrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.moviePlayer play];
    [self addNofi];
}

/**
 *  视频播放url
 *
 *  @return 返回视频url
 */
- (NSURL *)url
{
    _videoUrl = @"http://113.5.251.98/v.cctv.com/flash/mp4video6/TMS/2011/01/05/cf752b1c12ce452b3040cab2f90bc265_h264818000nero_aac32-1.mp4";
    //_videoUrl = [_videoUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url1 = [NSURL URLWithString:_videoUrl];
    return url1;
}

/**
 *  初始化MPMoviePlayerController
 *
 *  @return 返回一个MPMoviePlayerController的实例
 */
- (MPMoviePlayerController *)moviePlayer
{
    if (!_moviePlayer) {
        _moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:[self url]];
        _moviePlayer.view.frame = self.view.bounds;
        _moviePlayer.scalingMode = MPMovieScalingModeAspectFit; //固定缩放比例并且尽量全部
        [self.view addSubview:_moviePlayer.view];
    }
    return _moviePlayer;
}

/**
 *  添加视频播放的通知
 */
- (void)addNofi
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playbackstateDidChange:)
                                                 name:MPMoviePlayerPlaybackStateDidChangeNotification   //播放状态改变，可配合playbakcState属性获取具体状态
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playDidFinish:) //媒体播放完成或用户手动退出，具体完成原因可以通过通知userInfo中的key为MPMoviePlayerPlaybackDidFinishReasonUserInfoKey的对象获取
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
}


- (void)playbackstateDidChange:(NSNotification *)noti
{
    switch (self.moviePlayer.playbackState) {
        case MPMoviePlaybackStateInterrupted:
            //中断
            NSLog(@"中断");
            break;
        case MPMoviePlaybackStatePaused:
            //暂停
            NSLog(@"暂停");
            break;
        case MPMoviePlaybackStatePlaying:
            //播放中
            NSLog(@"播放中");
            break;
        case MPMoviePlaybackStateSeekingBackward:
            //后退
            NSLog(@"后退");
            break;
        case MPMoviePlaybackStateSeekingForward:
            //快进
            NSLog(@"快进");
            break;
        case MPMoviePlaybackStateStopped:
            //停止
            NSLog(@"停止");
            break;
            
        default:
            break;
    }
}

- (void)playDidFinish:(NSNotification *)noti
{
    //播放完成
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
