//
//  TopViewDelegateController.m
//  Sidebar
//
//  Created by dongzhejia on 13-11-29.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "MyImageScrollView.h"
#import "TopViewDelegateController.h"
#import "UICollectionCell.h"
#import "TopView.h"
#import "WebAddress.h"
#import "topRefreshView.h"
#import "UIImageView+ImageWithUrl.h"
#import "FootLoadView.h"
#import "UMSocial.h"
#import "Reachability.h"
@interface TopViewDelegateController ()
{
    int currentChannel;
    BOOL refresh;
}
@end

@implementation TopViewDelegateController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
           }
    return self;
}

#pragma mark 下拉刷新
- (void)dragRefresh
{
    [_todayHumorParser cancelResquest];
    [_classicHumorParser cancelResquest];
    [_displayImageParser cancelResquest];
    //请求数据列表数据
    self.todayHumorParser = [[JeffyHumorousColsction alloc]init];
    [_todayHumorParser release];
    self.todayHumorParser.delegate = self;
    //请求经典幽默列表数据
    self.classicHumorParser = [[JeffyHumorousColsction alloc]init];
    [_classicHumorParser release];
    self.classicHumorParser.delegate = self;
    //请求展示窗口的经典幽默视频图片
    self.displayImageParser = [[JeffyHumorousColsction alloc]init];
    [_displayImageParser  release];
    self.displayImageParser.delegate = self;

    refresh = YES;
    TopView *topView = (TopView *)self.view;
    topView.contentInset = UIEdgeInsetsMake(self.freshHeight+self.topRefresh.bounds.size.height, 0, _footLoad.bounds.size.height*2, 0);
    [UIView animateWithDuration:0.5 animations:^{
    topView.contentOffset = CGPointMake(topView.contentOffset.x, -(self.freshHeight+self.topRefresh.bounds.size.height));
    }];
    //下拉刷新
    self.topRefresh.topfresh2.hidden = NO;
    [self.topRefresh.topfresh startAnimating];
    [self performSelector:@selector(requestAgain) withObject:nil afterDelay:1];
}
- (void)requestAgain
{
    
    currentChannel = 0;
    self.videoArray = nil;
    [self.displayImageArray removeAllObjects];
    self.classicHumorArray = nil;
    [self.classicHumorParser dataGetWithUrl:DZJVideoAddressDisplay()];
    NSString *url = _videoChannelIDArray[currentChannel];
    
    
    [self.todayHumorParser dataGetWithUrl:DZJVideoAddress(url)];
}


#pragma mark 上拉加载
- (void)dragLoad
{
     refresh = YES;
     NSString *url = _videoChannelIDArray[currentChannel+1];
    [self.todayHumorParser dataGetWithUrl:DZJVideoAddress(url)];
}
#pragma mark -----------------------------
#pragma mark 执行分享的代理方法
- (void)didShareButtonWith:(UIButton *)sender showTextLabel:(NSString *)text showImage:(UIImage *)image
{
    [UMSocialSnsService presentSnsIconSheetView:self.view.window.rootViewController
                                         appKey:@"5299908256240b573b0996dd"
                                      shareText:[text stringByAppendingString:@"   ----来自囧囧"]
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,nil]
                                       delegate:nil];
}
- (void)requestDataSuccessful:(JeffyHumorousColsction *)humConnection
{
    static int displayIndexth = 0;
    //如果是网址则对网址进行接收
    if (humConnection == self.todayHumorParser)
    {
        if (!self.videoArray) {
        self.videoArray = [NSJSONSerialization JSONObjectWithData:self.todayHumorParser.receiveData options:NSJSONReadingMutableContainers error:nil][@"boxes"][0][@"results"];
        }else
        {
            [self.videoArray addObjectsFromArray:[NSJSONSerialization JSONObjectWithData:self.todayHumorParser.receiveData options:NSJSONReadingMutableContainers error:nil][@"boxes"][0][@"results"]];
        }
        //刷新主视图
        [self.view performSelector:@selector(reloadData)];
        //回缩下拉栏或加载栏
        TopView *topView = (TopView *)self.view;
        _footLoad.hidden = YES;
        [UIView animateWithDuration:1 animations:^{
            topView.contentInset = UIEdgeInsetsMake(self.freshHeight, 0, _footLoad.bounds.size.height*2, 0);
        }completion:^(BOOL finished) {
            //如果是加载则频道+1;
            if (![self.topRefresh.topfresh isAnimating]) {
                 currentChannel++;
            }
            self.topRefresh.topfresh2.hidden = YES;
            [self.topRefresh.topfresh stopAnimating];
        }];
        refresh = NO;
    }
    //如果是展示窗口网址,则对解析内容进行接收
    if (humConnection == self.classicHumorParser)
    {
        self.classicHumorArray = [NSJSONSerialization JSONObjectWithData:self.classicHumorParser.receiveData options:NSJSONReadingMutableContainers error:nil][@"boxes"][arc4random_uniform(4)][@"results"];
        
        [self.displayImageParser dataGetWithUrl:self.classicHumorArray[displayIndexth][@"thumb"]];
        
    }
    
    //如果是展示推荐窗口的图片
    if (humConnection == self.displayImageParser) {
        UIImage *image = [UIImage imageWithData:self.displayImageParser.receiveData];
        [self.displayImageArray addObject:image];
        displayIndexth++;
        if (displayIndexth< self.classicHumorArray.count) {
            [self.displayImageParser dataGetWithUrl:self.classicHumorArray[displayIndexth][@"thumb"]];
        }else
        {
            self.disPlayScroll.imageArray = self.displayImageArray;
            self.disPlayScroll.classicHumorArray = self.classicHumorArray;
            //刷新展示窗
            [self.disPlayScroll refreshImage];
            displayIndexth = 0;
        }
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _videoArray.count/2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionCell *cell = (UICollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"COllectioncell" forIndexPath:indexPath];
       	    // 设置label文字
     if ([@"ON" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"daySwitch"]])
     {
         cell.label.textColor = [UIColor whiteColor];
         cell.numberOFplaylabel.textColor = [UIColor colorWithWhite:0.839 alpha:1.000];
     }else
     {
         cell.label.textColor = [UIColor blackColor];
         cell.numberOFplaylabel.textColor = [UIColor colorWithWhite:0.373 alpha:1.000];
     }
    cell.delegate = self;
    if ((indexPath.row + indexPath.section*2) < _videoArray.count) {
        cell.vedioUrlString = DZJVideoPlayAddress(self.videoArray[indexPath.row + indexPath.section*2][@"videoid"]);
        
        cell.backgroundColor = [UIColor clearColor];
        cell.label.text = self.videoArray[indexPath.row +indexPath.section*2][@"title"];
        [cell.imageView loadImageWithUrlSting:self.videoArray[indexPath.row +indexPath.section*2][@"thumb"]];
        cell.numberOFplaylabel.text = self.videoArray[indexPath.row +indexPath.section*2][@"subtitle"];
    }
   
    [cell reflashLabelSize];
    
    return cell;
}


#pragma mark 检测下拉状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.contentOffset.y <= -self.freshHeight -self.topRefresh.bounds.size.height) {
        //下拉刷新
        refresh = YES;
        [self dragRefresh];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //如果看到底端则加载
    if (scrollView.contentOffset.y >scrollView.contentSize.height-self.view.bounds.size.height&&!refresh) {
        if (currentChannel == self.videoChannelIDArray.count-1) {
            return;
        }
        _footLoad.hidden = NO;
        refresh = YES;
        [self dragLoad];
    }
    _footLoad.center = CGPointMake(_footLoad.center.x, scrollView.contentSize.height+20);
    
}
- (void)dealloc
{ [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_videoArray release];
    [_videoChannelIDArray release];
    [_classicHumorArray release];
    [_displayImageArray release];
    [_footLoad release];
    [_topRefresh release];
    [_classicHumorParser cancelResquest];
    [_displayImageParser cancelResquest];
    [_todayHumorParser cancelResquest];
    [_classicHumorParser release];
    [_displayImageParser release];
    [_todayHumorParser release];
    [_scroll release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([[UIDevice currentDevice].systemVersion floatValue]<7.0) {
        self.freshHeight = 189;
    }else
    {
        self.freshHeight = 189+44;
    }
    if ([UIScreen mainScreen].bounds.size.height<568) {
        self.freshHeight -= 30;
    };
    
    TopView *topView = [[TopView alloc]initWithFrame:[UIScreen mainScreen].bounds collectionViewLayout:nil];
    self.view = topView;
    [topView release];
    //设置标题
    self.navigationItem.title = @"今日囧闻";
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"more_three_line"] forState:UIControlStateNormal];
    button.showsTouchWhenHighlighted = YES;
    button.bounds = CGRectMake(0, 0, 44, 44);
    [button addTarget:self action:@selector(backSiderbarPage) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftBar;
    [leftBar release];

#pragma mark 创建展示窗口
    _disPlayScroll = [[MyImageScrollView alloc]initWithFrame:CGRectMake(10, -topView.contentInset.top, self.view.bounds.size.width-20, topView.bounds.size.height/3) and:nil];
    [topView addSubview:self.disPlayScroll];
    topView.delegate = self;
    topView.dataSource = self;
    [topView registerClass:[UICollectionCell class] forCellWithReuseIdentifier:@"COllectioncell"];
    //创建下拉刷新栏
    _topRefresh = [[topRefreshView alloc]initWithFrame:CGRectMake(0, -1.5*topView.contentInset.top-10, self.view.bounds.size.width, topView.bounds.size.height/6)];
    [topView addSubview:_topRefresh];
    //创建下拉加载栏
    _footLoad = [[FootLoadView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, 30)];
    _footLoad.hidden = YES;
    [topView addSubview:_footLoad];
    
    
    //初始化频道数组
    self.videoChannelIDArray = @[@"285",@"286",@"287",@"288",@"289",@"290",@"291"];
    currentChannel = 0;
    //初始化展示窗口图片数组
    _displayImageArray = [[NSMutableArray alloc]initWithCapacity:2];
    
    //网络检测
    [self checkNetworkChange];
    Reachability *tekuba_net = [Reachability reachabilityForInternetConnection];
    switch ([tekuba_net currentReachabilityStatus])
    {
        case NotReachable:
        {
            UIAlertView *alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"无网络连接" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
            [alart release];
        }
            break;
        case ReachableViaWWAN:{
            UIAlertView *alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前为3G/2G模式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alart show];
            [alart release];
            //刷新
            [self dragRefresh];
        }
            break;
        case ReachableViaWiFi:
            //刷新
            [self dragRefresh];
            break;
        default:
            break;
    }
    
}

//监测网络变化
-(void)checkNetworkChange
{
    //监测网络状态变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    //添加监控
    Reachability *hostReach = [Reachability reachabilityForInternetConnection];
    //网络是否链接,包括蜂窝网络和WIFI
    [hostReach startNotifier];
    
    Reachability *wifiReach = [[Reachability reachabilityForLocalWiFi] retain];
    //蜂窝网络
    [wifiReach startNotifier];
    
    Reachability *internetReach = [[Reachability reachabilityForInternetConnection] retain];
    [internetReach startNotifier];
}

- (void)reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass: [Reachability class]]);
    NetworkStatus status = [curReach currentReachabilityStatus];
    static UIAlertView *alart;
    
    switch (status) {
        case 0:
        {
            if (alart.tag != 10) {
                [alart release];
                alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"网络断开" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                alart.tag = 10;
                 [alart show];
            }
        }
            break;
        case 1:
        {
            if(alart.tag != 11)
            {
                [alart release];
                alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前网络为WiFi模式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                //刷新
                [self dragRefresh];
                alart.tag = 11;
                [alart show];
            }
        }
            break;
        case 2:
        {
            if(alart.tag != 12)
            {
                [alart release];
                alart = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"当前网络为3G/2G模式" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [self dragRefresh];
                alart.tag = 12;
                [alart show];
            }
            
        }
            break;
        default:
            break;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //当点击主界面的时候，侧边栏消失
    if (self.scroll.contentOffset.x < self.slidebarWidth) {
        [UIView animateWithDuration:0.35 animations:^{
            self.scroll.contentOffset = CGPointMake(self.slidebarWidth, 0);
        }];
        return;
    }
    NSString *videoID = self.videoArray[indexPath.row + indexPath.section*2][@"videoid"];
    if (!videoID) {
        return;
    }

    //创建播放器对象
    AudioVideoViewController *videoPlayer = [[AudioVideoViewController alloc]initWithContentURL:[NSURL URLWithString:DZJVideoPlayAddress(videoID)]];
    NSLog(@"%@",DZJVideoPlayAddress(videoID));
   [self.view.window.rootViewController presentViewController:videoPlayer animated:YES completion:^{
       
   }];
    [videoPlayer release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.view window]) {
        self.view = nil;
        self.disPlayScroll = nil;
        self.topRefresh = nil;
        self.footLoad = nil;
        self.todayHumorParser = nil;
        self.videoChannelIDArray = nil;
        self.displayImageArray = nil;
        self.classicHumorParser = nil;
        self.displayImageParser = nil;
    }

    // Dispose of any resources that can be recreated.
}
- (void)backSiderbarPage{
    
    if (_scroll.contentOffset.x) {
        [UIView animateWithDuration:0.35 animations:^{
            _scroll.contentOffset = CGPointMake(0, _scroll.contentOffset.y);
        } completion:^(BOOL finished) {
            
        }];
        
    }else
    {
        [UIView animateWithDuration:0.35 animations:^{
            _scroll.contentOffset = CGPointMake(self.slidebarWidth, _scroll.contentOffset.y);
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
}

@end
