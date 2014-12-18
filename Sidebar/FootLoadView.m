//
//  FootLoadView.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-14.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "FootLoadView.h"

@implementation FootLoadView

- (void)dealloc
{
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width-20, frame.size.height)];
        loadLabel.text = @"正在加载";
        loadLabel.textAlignment = NSTextAlignmentCenter;
        loadLabel.backgroundColor = [UIColor clearColor];
        loadLabel.textColor = [UIColor colorWithWhite:0.388 alpha:1.000];
        loadLabel.layer.borderWidth = 1;
        loadLabel.layer.borderColor = [UIColor colorWithWhite:0.893 alpha:1.000].CGColor;
        [self addSubview:loadLabel];
        [loadLabel release];
        //添加加载效果的菊花
        UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        activityIndicatorView.color = [UIColor redColor];
        activityIndicatorView.center = CGPointMake(loadLabel.bounds.size.width/2-50, self.bounds.size.height/2);
        [loadLabel addSubview:activityIndicatorView];
        [activityIndicatorView startAnimating];
        [activityIndicatorView release];
    }
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
