//
//  UICollectionCell.h
//  Sidebar
//
//  Created by dongzhejia on 13-12-2.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Collection.h"

@protocol UICollectionCellDelegate <NSObject>
- (void)didShareButtonWith:(UIButton *)sender showTextLabel:(NSString *)text showImage:(UIImage *)image ;

@end
@interface UICollectionCell : UICollectionViewCell
@property (retain, nonatomic) UIImageView *imageView;
@property (retain, nonatomic) UILabel *label;
@property (retain, nonatomic) UILabel *numberOFplaylabel;
@property (retain,nonatomic)NSString *vedioUrlString;

@property (retain,nonatomic)UIMenuController *menu;
@property (nonatomic,retain)Collection *collect;//一个收藏的实例对象
@property (nonatomic,retain)NSMutableArray *collectionArray;//收藏的数组
@property (nonatomic,assign)id <UICollectionCellDelegate> delegate;

- (void)reflashLabelSize;

@end
