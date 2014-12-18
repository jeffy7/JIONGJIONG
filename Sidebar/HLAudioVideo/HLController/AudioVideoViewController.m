//
//  AudioVideoViewController1.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-19.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "AudioVideoViewController.h"

@interface AudioVideoViewController ()

@end

@implementation AudioVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.moviePlayer prepareToPlay];
    //屏蔽自带logo换成自己的logo
    CGRect screenFrame = [UIScreen mainScreen].applicationFrame;
    _leftLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, screenFrame.origin.x+55, 60, 40)];
    _leftLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    //_leftLogoImageView.layer.cornerRadius = 30;
    _leftLogoImageView.layer.masksToBounds = YES;
    self.leftLogoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:self.leftLogoImageView];
    _RightLogoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(screenFrame.origin.y+screenFrame.size.height-70, screenFrame.origin.x+55, 60, 40)];
    _RightLogoImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.RightLogoImageView.image = [UIImage imageNamed:@"logo"];
    [self.view addSubview:self.RightLogoImageView];
    [_leftLogoImageView release];
    [_RightLogoImageView release];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(movieFinishedCallback:)
                                                name:MPMoviePlayerPlaybackDidFinishNotification
                                              object:[self moviePlayer]];
    [self.moviePlayer  play];

}
/**
 *  视频播放完成后调用
 *
 *  @param aNotification <#aNotification description#>
 */
- (void)movieFinishedCallback:(NSNotification *)aNotification
{
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerPlaybackDidFinishNotification
                                                 object:player];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeLeft;
}

-(void)dealloc
{
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.view window]) {
        self.view = nil;
    }
}

@end
