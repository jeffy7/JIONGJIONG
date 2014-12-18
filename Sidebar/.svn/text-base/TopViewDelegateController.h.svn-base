//
//  TopViewDelegateController.h
//  Sidebar
//
//  Created by dongzhejia on 13-11-29.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JeffyHumorousColsction.h"
#import "UICollectionCell.h"
@class MyImageScrollView;
@class topRefreshView;
@class FootLoadView;
@interface TopViewDelegateController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,JeffyHumorousColsctionDelegate,UIScrollViewDelegate,UICollectionCellDelegate>

@property(nonatomic,retain) UIScrollView *scroll;
@property(nonatomic,assign) float slidebarWidth;
@property(nonatomic,retain) MyImageScrollView * disPlayScroll;//推荐展示滚动窗口
@property(nonatomic,retain) topRefreshView *topRefresh;
@property(nonatomic,retain) FootLoadView *footLoad;
@property(nonatomic,retain) JeffyHumorousColsction *todayHumorParser;
@property(nonatomic,retain) JeffyHumorousColsction *classicHumorParser;
@property(nonatomic,retain) JeffyHumorousColsction *displayImageParser;
@property(nonatomic,retain) NSMutableArray *videoArray;
@property(nonatomic,retain) NSArray *videoChannelIDArray;
@property(nonatomic,retain) NSMutableArray *classicHumorArray;
@property(nonatomic,retain) NSMutableArray *displayImageArray;
@property(nonatomic,assign) float freshHeight;
- (void)dragRefresh;
@end
