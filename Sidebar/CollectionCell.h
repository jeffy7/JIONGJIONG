//
//  CollectionCell.h
//  JIONGJIONG
//
//  Created by lanou on 13-12-4.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CollectionCellDelegate <NSObject>

@optional

- (void)didShareButtonWith:(UIButton *)sender showTextLabel:(NSString *)text showImage:(UIImage *)image;
@end
@interface CollectionCell : UITableViewCell

//一个显示图片  一个显示文字  后续增加一个昵称 一个头像
@property (nonatomic,retain)UIImageView *collectView;//图片
@property (nonatomic,retain)UILabel *collectLabel;//文本
@property (nonatomic,retain)UIImageView *showView;//头像
@property (nonatomic,retain)UILabel *userNameLabel;//昵称
@property (nonatomic,retain)NSString *vedioURL;


@property (nonatomic,retain)NSMutableArray *collectionArray;//收藏笑话的数组
@property (nonatomic,assign)id <CollectionCellDelegate> delegate;

//计算行高
+ (CGFloat)calcultorHeightwith:(NSString *)humorous;
@end
