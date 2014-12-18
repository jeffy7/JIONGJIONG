//
//  MyImageScrollView.m
//  LessonScroll
//
//  Created by dongzhejia on 13-11-5.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "MyImageScrollView.h"
#import "WebAddress.h"
#import "UIImageView+ImageWithUrl.h"
@implementation MyImageScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (MyImageScrollView *)initWithFrame:(CGRect)frame and:(NSMutableArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置自动滚动状态默认为开启
        self.ManualFlag = YES;
        self.imageArray = imageArray;
        //设置代理
        self.delegate = self;
        //当前视图
        _currentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:self.currentImageView];
         self.currentImageView.contentMode = UIViewContentModeScaleAspectFit;
        //打开当前视图的交互
        self.currentImageView.userInteractionEnabled  = YES;
        
        
        //后一个视图
        _behindImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width*2, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:self.behindImageView];
        self.behindImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        //前一个视图
        _beforeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        [self addSubview:self.beforeImageView];
        self.beforeImageView.contentMode = UIViewContentModeScaleAspectFit;

        self.contentMode = UIViewContentModeScaleAspectFit;
        self.backgroundColor = [UIColor blackColor];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = NO;
        self.contentSize = CGSizeMake(frame.size.width, 0);
        self.contentOffset = CGPointMake(self.bounds.size.width, 0);
        
        //pageContol的属性设置
        _pageContol = [[UIPageControl alloc] initWithFrame:CGRectMake(self.bounds.size.width*3/5,0, frame.size.width*2/5, 20)];
        self.pageContol.numberOfPages = 8;
        self.pageContol.currentPage = 0;
        self.pageContol.backgroundColor = [UIColor clearColor];
        [self.pageContol addTarget:self action:@selector(pageContolAction:) forControlEvents:UIControlEventValueChanged];
        
        //详情label
        _detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 20)];
        self.detailLabel.backgroundColor = [UIColor clearColor];
        self.detailLabel.textColor = [UIColor whiteColor];
        self.detailLabel.font = [UIFont boldSystemFontOfSize:13.0];
        _containerView = [[UIView alloc]initWithFrame:CGRectMake(self.bounds.size.width, frame.size.height-20, frame.size.width, 20)];
        self.containerView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.490];
        [self.containerView addSubview:self.detailLabel];
        [self.containerView addSubview:self.pageContol];
        [self addSubview:self.containerView];
        
        //为点击事件定义一个手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        [self.currentImageView addGestureRecognizer:tap];
        [tap release];
        
        self.autoRefresh = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(refreshAction) userInfo:nil repeats:YES];
        [self.autoRefresh fire];
        self.contentSize = CGSizeMake(self.bounds.size.width*3, 0);
        self.pagingEnabled = YES;
    }
       return self;
}

#pragma mark 对图片拖动进行重用处理
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int number = self.contentOffset.x/self.frame.size.width;
    if (number > 1) {
        self.currentPage++;
    }else if (number < 1)
    {
        self.currentPage--;
    }else
    {
        return;
    }
    self.currentPage = (self.currentPage+self.pageContol.numberOfPages)%self.pageContol.numberOfPages;
    self.pageContol.currentPage = self.currentPage;
    [self refreshImage];
    self.contentOffset = CGPointMake(self.bounds.size.width, 0);
    self.ManualFlag = YES;
      if (self.classicHumorArray.count-1 > self.pageContol.currentPage) {
        self.detailLabel.text  = self.classicHumorArray[self.pageContol.currentPage][@"title"];
    }
    
}

#pragma mark 当用户手动滑动的时候停止自动模式，滑动结束后开启自动模式
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.ManualFlag = NO;
}


#pragma mark 更改pagecontol的位置放置滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.containerView.frame = CGRectMake(self.contentOffset.x, self.containerView.frame.origin.y,self.containerView.frame.size.width, 20);
    
}




#pragma mark pagecontroller的回调函数
-(void) pageContolAction:(UIPageControl*)senter
{
    if (self.pageContol.currentPage > self.currentPage) {
        self.currentPage ++;
        self.currentPage = (self.currentPage+self.pageContol.numberOfPages)%self.pageContol.numberOfPages;
        [UIView animateWithDuration:1 animations:^{
            self.contentOffset = CGPointMake(self.bounds.size.width*2, 0);
        } completion:^(BOOL finished) {
            self.contentOffset = CGPointMake(self.bounds.size.width, 0);
            [self refreshImage];
        }];
    }else  if (self.pageContol.currentPage < self.currentPage)
    {
        self.currentPage --;
        self.currentPage = (self.currentPage+self.pageContol.numberOfPages)%self.pageContol.numberOfPages;
        [UIView animateWithDuration:1 animations:^{
            self.contentOffset = CGPointMake(0, 0);
        } completion:^(BOOL finished) {
            self.contentOffset = CGPointMake(self.bounds.size.width, 0);
            [self refreshImage];
        }];

    }
    
      if (self.classicHumorArray.count-1 > self.pageContol.currentPage) {
         self.detailLabel.text  = self.classicHumorArray[self.pageContol.currentPage][@"title"];
    }
}

#pragma mark 图片自动更新函数
- (void)refreshAction
{
    if (!self.ManualFlag) {
        return;
    }
    [UIView animateWithDuration:1 animations:^{
    self.contentOffset = CGPointMake(self.bounds.size.width*2, 0);
    } completion:^(BOOL finished) {
        self.contentOffset = CGPointMake(self.bounds.size.width, 0);
        self.currentPage ++;
        self.currentPage = (self.currentPage+self.pageContol.numberOfPages)%self.pageContol.numberOfPages;
        self.pageContol.currentPage = self.currentPage;
        [self refreshImage];
    }];
      if (self.classicHumorArray.count-1 > self.pageContol.currentPage) {
        self.detailLabel.text  = self.classicHumorArray[self.pageContol.currentPage][@"title"];
    }

}

#pragma mark 刷新图片
- (void)refreshImage
{
   
    if (self.imageArray.count) {
        if (self.imageArray.count-1 > (self.pageContol.currentPage-1+self.pageContol.numberOfPages)%self.pageContol.numberOfPages) {
             self.beforeImageView.image = [self.imageArray objectAtIndex:(self.pageContol.currentPage-1+self.pageContol.numberOfPages)%self.pageContol.numberOfPages];
        }
        
        if (self.imageArray.count-1 > self.pageContol.currentPage)
        {
           self.currentImageView.image = [self.imageArray objectAtIndex:self.pageContol.currentPage];
        }
        
          if (self.imageArray.count-1 > (self.pageContol.currentPage +1)%self.pageContol.numberOfPages)
          {
             self.behindImageView.image = [self.imageArray objectAtIndex:(self.pageContol.currentPage +1)%self.pageContol.numberOfPages];
          }
        
    }
   
    if (self.classicHumorArray.count-1 > self.pageContol.currentPage) {
        self.detailLabel.text  = self.classicHumorArray[self.pageContol.currentPage][@"title"];
    }
}



#pragma mark  被点击后调用代理方法传出当前的图片位置
- (void)tapAction
{
    NSString *videoID = self.classicHumorArray[self.pageContol.currentPage][@"videoid"];
    if (!videoID) {
        return;
    }
    //创建播放器对象
    AudioVideoViewController *videoPlayer = [[AudioVideoViewController alloc]initWithContentURL:[NSURL URLWithString:DZJVideoPlayAddress(videoID)]];
    [self.window.rootViewController presentViewController:videoPlayer animated:YES completion:^{
        
    }];
    [videoPlayer release];
}

-(void)dealloc
{
   
    [_classicHumorArray release];
    [_imageArray release];
    [_detailLabel release];
    [_containerView release];
    [_pageContol release];
    [_autoRefresh invalidate];
    [_autoRefresh release];
    [_currentImageView release];
    [_behindImageView release];
    [_beforeImageView release];
    [super dealloc];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
