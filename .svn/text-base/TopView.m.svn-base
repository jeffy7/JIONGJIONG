//
//  TopView.m
//  Sidebar
//
//  Created by dongzhejia on 13-12-2.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "TopView.h"

@implementation TopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
          }
    return self;
}

- (void)dealloc
{
    [_background release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(140,140)];
    //设置每个cell显示数据的宽和高必须
    //[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal]; //水平滑动
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical]; //控制滑动分页用
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    [self setUserInteractionEnabled:YES];
    [super initWithFrame:frame collectionViewLayout:flowLayout];
    
    
    _background = [[UIImageView alloc]initWithFrame:frame];
    if ([@"ON" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"daySwitch"]]) {
        self.background.image = [UIImage imageNamed:@"mainViewBackGroundDay"];
        self.backgroundColor = [UIColor clearColor];
    }else
    {
        self.backgroundColor = [UIColor whiteColor];
    }
    self.backgroundView = self.background;
    
    self.contentInset = UIEdgeInsetsMake(self.bounds.size.height/3, 0, 0, 0);
   [flowLayout release];
    self.showsHorizontalScrollIndicator = NO;
    //self.showsVerticalScrollIndicator = NO;
    
  
    
      return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
