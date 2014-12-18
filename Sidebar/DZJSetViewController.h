//
//  DZJSetViewController.h
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-15.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DZJSetViewController : UITableViewController<UIActionSheetDelegate>
@property(nonatomic,retain) UIScrollView *scroll;
@property(nonatomic,assign) float slidebarWidth;
@property(nonatomic,retain) NSArray *itermArray;
@property(nonatomic, retain)NSArray *imageItems;
@property(nonatomic,retain)  UIActionSheet *sheetViewResigh;
@property(nonatomic,retain)  UIActionSheet *sheetViewDelete;

@end
