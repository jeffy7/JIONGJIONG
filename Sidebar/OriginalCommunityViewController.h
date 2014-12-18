//
//  OriginalCommunityViewController.h
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-5.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collection.h"
#import "JeffyHumorousColsction.h"
#import "DZjOriginalCell.h"
@class topRefreshView;
@class UploadViewController;
@class FootLoadView;
@interface OriginalCommunityViewController : UITableViewController<JeffyHumorousColsctionDelegate,DZjOriginalCellDelagate,UIScrollViewDelegate,UIAlertViewDelegate>

@property(nonatomic,retain) UIScrollView *scroll;
@property(nonatomic,assign) float slidebarWidth;
@property(nonatomic,retain) topRefreshView *topRefresh;
@property(nonatomic,retain) FootLoadView *footLoad;
@property(nonatomic,assign) int currentLoad;
@property(nonatomic,assign) float freshHeight;
@property(nonatomic,retain)  UploadViewController *upload;;

@property (nonatomic,retain)NSMutableArray *allShareMood;//从数据库拿下来的所有分享
@property (nonatomic,retain)NSMutableArray *allTextArray;//存取所有解析完的文本
@property(nonatomic,retain) JeffyHumorousColsction *colesion;
@property (nonatomic,retain)NSMutableArray *allVideoArray;//存取所有解析完的视频
@property (nonatomic,retain)NSMutableArray *allcommentArray;//存取所有解析完的视频
@property (nonatomic,retain)NSMutableArray *array;

//用来判断解析的是什么数据  由于需要共用一个解析汇创的 的方法
@property (nonatomic,retain)JeffyHumorousColsction *allData;
@property (nonatomic,retain)JeffyHumorousColsction *textData;
- (void)dragRefresh;
@end
