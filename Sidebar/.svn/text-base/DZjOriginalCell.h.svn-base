//
//  DZjOriginalCell.h
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-5.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZJLabel.h"

@protocol  DZjOriginalCellDelagate <NSObject>

- (void)updataCommentWith:(int)index;

@end

@interface DZjOriginalCell : UITableViewCell<UIScrollViewDelegate,UITextViewDelegate>
@property(nonatomic,retain) UIImageView *userImageView;
@property(nonatomic,retain) DZJLabel *usernameLabel;
@property(nonatomic,retain) DZJLabel *publishTime;
@property(nonatomic,retain) DZJLabel *text;
@property(nonatomic,retain) NSString *viedoUrlSting;
@property(nonatomic,retain) UIButton *viedoPlay;
@property(nonatomic,retain) UIButton *commentsIcon;
@property(nonatomic,retain) UITextView *comments;
@property(nonatomic,retain) UIImageView *publishImageView;
@property(nonatomic,retain) NSIndexPath *indexPath;
@property(nonatomic,retain) NSMutableArray *dataArray;
- (void)comentsAction:(UITextView *)text;

@property (nonatomic,assign)id <DZjOriginalCellDelagate> delegete;
-(CGFloat)returnHightForCell:(NSString *)textSting cellImage:(BOOL)exit comments:(NSString *) comments;
- (void)refreshposition:(BOOL)imageExist;
@end
