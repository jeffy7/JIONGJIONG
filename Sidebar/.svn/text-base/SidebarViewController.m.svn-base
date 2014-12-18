//
//  MainViewController.m
//  Sidebar
//
//  Created by dongzhejia on 13-11-29.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "SidebarViewController.h"
#import "BottomView.h"
#import "TopView.h"
#import "TopViewDelegateController.h"
#import "BottomViewDelegateController.h"
#import "UICollectionCell.h"
#import "MyImageScrollView.h"
#import "UserInfo.h"
#import "Reachability.h"

@interface SidebarViewController ()

@end


#pragma mark 返回对应文件名的Caches路径
static inline NSString *Cachespath(NSString *name)
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:name];
}

@implementation SidebarViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //用户信息变更消息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserInfo) name:@"changeUserInfo" object:nil];
        //夜间模式变更
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDayAndNight) name:@"changeDayAndNight" object:nil];
        //侧边栏滚动变更
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScroll) name:@"changeScroll" object:nil];

        //创建存储图片的路径
        NSFileManager *fileManaGer = [NSFileManager defaultManager];
        NSString *imageDirectory = Cachespath(@"Photoes/");
        [fileManaGer createDirectoryAtPath:imageDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeUserInfo" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeScroll" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"changeDayAndNight" object:nil];


    [_dayAndNightView release];
    [_BottomScroll release];
    [_topNavition  release];
    [_bottomNavition release];
    [_topView release];
    [_bottom release];
    [_topDelegate release];
    [_bottomDelegate release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      //设置边栏展露宽度默认为屏幕的宽度的一般
    self.slidebarWidth = (int)self.view.bounds.size.width/2+40;
    #pragma mark 创建底层ScrollView
    //根据系统不同设置底层Scroll的高度
    float hight = 0;
    if ([[UIDevice currentDevice].systemVersion floatValue]<7.0) {
        hight = 0;
    }else
    {
        hight = 20;
    }
    //创建夜间模式view蒙版
    _dayAndNightView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _dayAndNightView.backgroundColor = [UIColor blackColor];
    _dayAndNightView.userInteractionEnabled = NO;
    float dayAndNightAlpha = 0;
    if ([@"ON" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"daySwitch"]]) {
        dayAndNightAlpha = 0.4;
    }else
    {
        dayAndNightAlpha = 0;
    }
    _dayAndNightView.alpha = dayAndNightAlpha;
    
    
    
    
    _BottomScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, hight, self.view.bounds.size.width, self.view.bounds.size.height-hight)];
    _BottomScroll.backgroundColor = [UIColor clearColor];
    self.BottomScroll.bounces = NO;
    self.BottomScroll.showsHorizontalScrollIndicator = NO;
    self.BottomScroll.showsVerticalScrollIndicator = NO;
    self.BottomScroll.delegate = self;
    self.BottomScroll.contentSize = CGSizeMake(self.view.bounds.size.width + self.slidebarWidth, 0);
    self.BottomScroll.pagingEnabled = YES;
    self.BottomScroll.contentOffset = CGPointMake(self.slidebarWidth, 0);
    #pragma mark 创建两个tableView的代理控制器
    _topDelegate = [[TopViewDelegateController alloc]init];
    _bottomDelegate = [[BottomViewDelegateController alloc]init];
    _bottomNavition = [[UINavigationController alloc]initWithRootViewController:self.bottomDelegate];
    _topNavition = [[UINavigationController alloc]initWithRootViewController:self.topDelegate];
    
    #pragma mark 创建边栏tableView
    self.bottom = (BottomView*)self.bottomDelegate.view;
    _bottom.frame = CGRectMake(self.slidebarWidth, 0, self.slidebarWidth,self.view.bounds.size.height);
    
    #pragma mark 创主页面tableView
    self.topView = (TopView*)self.topNavition.view;
    self.topView.tag = 10;
    _topView.frame = CGRectMake(self.slidebarWidth, 0, self.view.bounds.size.width,self.view.bounds.size.height);
    
    #pragma mark 对两个界面传递必要的参数
    self.topDelegate.scroll = self.BottomScroll;
    self.topDelegate.slidebarWidth = self.slidebarWidth;
    
    self.bottomDelegate.scroll = self.BottomScroll;
    self.bottomDelegate.topView = self.topView;
    self.bottomDelegate.slidebarWidth = self.slidebarWidth;
    
    #pragma mark 将两个tableView加入ScrllView
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.slidebarWidth, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
    imageView.image = [UIImage imageNamed:@"mainViewBackGroundDay"];
    [self.BottomScroll addSubview:self.bottom];
    [self.BottomScroll addSubview:imageView];
    [self.BottomScroll addSubview:self.topView];
    [self.view addSubview:self.BottomScroll];
    [imageView release];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_dayAndNightView];
    [self.view bringSubviewToFront:_dayAndNightView];
}

#pragma mark 侧边栏滚动模式变更
-(void)changeScroll
{
    if (_BottomScroll.scrollEnabled) {
         _BottomScroll.scrollEnabled = NO;
    }else
    {
       _BottomScroll.scrollEnabled = YES;
    }
    
}

#pragma mark 夜间模式变更
- (void)changeDayAndNight{
    BottomView *bottomView = (BottomView *)self.bottomDelegate.view;
    TopView *topView = (TopView *)self.topDelegate.view;
    
      if ([@"ON" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"daySwitch"]]) {
        bottomView.background.image =[UIImage imageNamed:@"sliderBarBackGroundNight"];
        [bottomView reloadData];
          [UIView animateWithDuration:1 animations:^{
             _dayAndNightView.alpha = 0.4;
          }];
          topView.background.image = [UIImage imageNamed:@"mainViewBackGroundDay"];
          topView.backgroundColor = [UIColor clearColor];
          [topView reloadData];
          
    }else
    {
        [UIView animateWithDuration:1 animations:^{
            _dayAndNightView.alpha = 0;
        }];

        [bottomView reloadData];
        bottomView.background.image = [UIImage imageNamed:@"sidebar_bg.jpg"];
        topView.background.image= nil;
        topView.backgroundColor = [UIColor whiteColor];
        [topView reloadData];
    }
}

#pragma mark 收到用户登录通知改变用户头像和名字
-(void)changeUserInfo
{
   UserInfo *user = [UserInfo userShare];
    
    BottomView *bottomView = (BottomView *)self.bottomDelegate.view;
    if (user.userName.length) {
         bottomView.username.text = user.userName;
    }else
    {
         bottomView.username.text = @"囧囧用户";
    }
   
    //设置默认图片
    bottomView.userImageView.image = [UIImage imageNamed:@"半透明图标"];
    NSString *imagePath = Cachespath([NSString stringWithFormat:@"Photoes/%@",user.userName]);
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:imagePath]&&user.passWord.length>=6&&user.userName.length>=6) {
        UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
        bottomView.userImageView.image = image;
        [image release];
    }
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}



#pragma mark 对侧边栏的滑动进行相应
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.bottom.frame = CGRectMake(scrollView.contentOffset.x, self.bottom.frame.origin.y,self.self.slidebarWidth, self.bottom.frame.size.height);
    if (scrollView.contentOffset.x == 200|| scrollView.contentOffset.x == 0) {
    }
    
    if (scrollView.contentOffset.x == 0 || scrollView.contentOffset.x == 200) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.duration = 2;
        animation.delegate = self;
        animation.byValue = @(M_PI*2);
        [self.bottom.userImageView.layer addAnimation:animation forKey:@"animation"];
    }
    
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    if (self.scroll.contentOffset.x > self.slidebarWidth/2) {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.scroll.contentOffset = CGPointMake(self.slidebarWidth, 0);
//        }];
//    }else
//    {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.scroll.contentOffset = CGPointMake(0, 0);
//        }];
//    }
//}



- (void)siderbarAction
{
    if (self.BottomScroll.contentOffset.x < self.slidebarWidth) {
        [UIView animateWithDuration:0.5 animations:^{
            self.BottomScroll.contentOffset = CGPointMake(self.slidebarWidth, self.BottomScroll.contentOffset.y);
        }];
    }else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.BottomScroll.contentOffset = CGPointMake(0, self.BottomScroll.contentOffset.y);
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.view window]) {
        self.view = nil;
        self.dayAndNightView = nil;
        self.BottomScroll = nil;
        self.topDelegate = nil;
        self.bottomDelegate = nil;
        self.bottomNavition = nil;
        self.topNavition = nil;
        self.bottom = nil;
        self.topView = nil;
    }
    // Dispose of any resources that can be recreated.
}

@end
