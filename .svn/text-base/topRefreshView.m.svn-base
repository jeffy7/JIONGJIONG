//
//  topRefreshView.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-13.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "topRefreshView.h"

@implementation topRefreshView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIImage *image0 = [UIImage imageNamed:@"fresh0"];
        UIImage *image1 = [UIImage imageNamed:@"fresh1"];
       _topfresh = [[UIImageView alloc]initWithImage:image0];
        self.topfresh.animationImages = @[image0,image1];
        self.topfresh.animationDuration = 0.2;
        self.topfresh.frame = CGRectMake((self.bounds.size.width-self.topfresh.bounds.size.width)/2, self.topfresh.frame.origin.y, self.topfresh.bounds.size.width, self.topfresh.bounds.size.height);
        
        [self addSubview:_topfresh];
        self.contentMode = UIViewContentModeScaleAspectFit;
        
       
        _topfresh2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"0"]];
        NSMutableArray *imagearray = [NSMutableArray array];
        UIImage *image = [UIImage imageNamed:@"0"];
        [imagearray addObject:image];
        for (int i = 1; i<=4; i++) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [imagearray addObject:image];
        }
        for (int i = 3; i>=0; i--) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [imagearray addObject:image];
        }
        for (int i = 5; i<=8; i++) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [imagearray addObject:image];
        }
        for (int i = 7; i>=5; i--) {
            image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [imagearray addObject:image];
        }
        self.topfresh2.animationImages = imagearray;
        self.topfresh2.animationDuration = 0.5;
        self.topfresh2.contentMode = UIViewContentModeScaleAspectFit;
        self.topfresh2.frame = CGRectMake(self.topfresh2.frame.origin.x, self.topfresh2.frame.origin.y+10, self.topfresh2.frame.size.width, self.topfresh2.frame.size.height);
        [self addSubview:_topfresh2];
        self.topfresh2.hidden = YES;
        [self.topfresh2 startAnimating];
    }
    return self;
}
- (void)dealloc
{
    [_topfresh release];
    [_topfresh2 release];
    [super dealloc];
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
