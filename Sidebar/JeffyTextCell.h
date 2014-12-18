//
//  JeffyTextCell.h
//  Program
//
//  Created by lanou on 13-12-2.
//  Copyright (c) 2013年 je_ffy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JeffyTextCell;
@class Humorous;
@class Collection;
@protocol JeffyTextCellDelegate <NSObject>

@optional

- (void)didShareButtonWith:(UIButton *)sender showTextLabel:(NSString *)text showImage:(UIImage *)image ;

- (void)backCollectionButtonWith:(UIButton *)sender WithAHum:(Humorous *)hum;

@end
//自定义cell
@interface JeffyTextCell : UITableViewCell


@property (nonatomic,retain)UIImageView *showView;//头像
@property (nonatomic,retain)UILabel *userNameLabel;//昵称
@property (nonatomic,retain)UILabel *showTextLabel;//显示笑话的label
@property (nonatomic,retain)UIImageView *picImage;//显示笑话的图片
@property (nonatomic,retain)NSMutableArray *collectionArray;//收藏笑话的数组
@property (nonatomic,retain)Collection *collect;//一个笑话的实例对象

@property (nonatomic,retain)UIMenuController *menu;
@property (nonatomic,assign)id <JeffyTextCellDelegate> delagate;

//计算行高
+ (CGFloat)calcultorHeightwith:(NSString *)humorous;
@end
