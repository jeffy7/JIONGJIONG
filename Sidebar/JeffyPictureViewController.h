//
//  JeffyPictureViewController.h
//  JIONGJIONG
//
//  Created by lanou on 13-12-4.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JeffyHumorousColsction.h"
#import "CollectionCell.h"
#import "JeffyTextCell.h"
#import "topRefreshView.h"
#import "FootLoadView.h"
@interface JeffyPictureViewController : UITableViewController<JeffyHumorousColsctionDelegate,JeffyTextCellDelegate>

@property(nonatomic,retain) UIScrollView *scroll;
@property(nonatomic,assign) float slidebarWidth;
@property (nonatomic,retain) JeffyHumorousColsction *colection;
@property (nonatomic,retain)NSMutableArray *allPictureTextArray;
@property(nonatomic,retain) FootLoadView *footLoad;
@property(nonatomic,retain) topRefreshView *topRefresh;

@property (nonatomic,assign)BOOL fresh;



@end
