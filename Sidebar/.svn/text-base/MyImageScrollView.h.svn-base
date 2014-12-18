//
//  MyImageScrollView.h
//  LessonScroll
//
//  Created by dongzhejia on 13-11-5.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioVideoViewController.h"

@interface MyImageScrollView : UIScrollView <UIScrollViewDelegate>
@property(nonatomic,retain) UIImageView * currentImageView;
@property(nonatomic,retain) UIImageView * behindImageView;
@property(nonatomic,retain) UIImageView * beforeImageView;
//网络数据数组
@property(nonatomic,retain) NSMutableArray *classicHumorArray;
//缓存照片数组
@property(nonatomic,retain) NSMutableArray *imageArray;
@property(nonatomic,assign) NSInteger currentPage;
@property(nonatomic,retain) UILabel *detailLabel;
@property(nonatomic,retain) UIView *containerView;
@property(nonatomic,retain) UIPageControl *pageContol;
@property(nonatomic,retain) NSTimer *autoRefresh;
@property(nonatomic,assign) BOOL ManualFlag;


//此展示窗口需要传进一个图片数组tapAction
- (MyImageScrollView *)initWithFrame:(CGRect)frame and:(NSMutableArray *)imageArray;
- (void)refreshImage;
@end
