//
//  JeffyTextViewController.h
//  Program
//
//  Created by lanou on 13-12-2.
//  Copyright (c) 2013年 je_ffy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JeffyTextCell.h"
#import "JeffyHumorousColsction.h"
#import "JeffyTextCell.h"
#import "topRefreshView.h"
@class FootLoadView;

@interface JeffyTextViewController : UITableViewController<JeffyHumorousColsctionDelegate,JeffyTextCellDelegate,UIScrollViewDelegate>
{
    
}
@property (nonatomic,retain) NSMutableArray *allHumorous;//存放所有的笑话文本
@property (nonatomic,retain) UIScrollView *scroll;
@property (nonatomic,assign) float slidebarWidth;
@property (nonatomic,retain) JeffyHumorousColsction *colection;
@property(nonatomic,retain) topRefreshView *topRefresh;
@property(nonatomic,retain) FootLoadView *footLoad;
@property (nonatomic,assign)BOOL fresh;


@end
