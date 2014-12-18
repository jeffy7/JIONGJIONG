//
//  DZJLabel.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-5.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "DZJLabel.h"

@implementation DZJLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentLeft;
        self.numberOfLines = 0;
        self.font = [UIFont systemFontOfSize:15];
        self.backgroundColor = [UIColor clearColor];
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
