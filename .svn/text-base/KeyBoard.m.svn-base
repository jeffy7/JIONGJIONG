//
//  KeyBoard.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-7.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "KeyBoard.h"
#import "DZjOriginalCell.h"
@implementation KeyBoard
static KeyBoard *keyboard = nil;

-(void)dealloc
{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [_keyboardtool release];
    [_MybottomView release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

+ (KeyBoard *)keyBoardShare
{
    if (!keyboard) {
        
        int height = 70;
        int sizeHeight = 200;
        if ([UIScreen mainScreen].bounds.size.height<500) {
            sizeHeight = 120;
        }
        
        #pragma mark 评论栏
        keyboard = [[KeyBoard alloc]initWithFrame:CGRectMake(20, 40, 280, sizeHeight)];
        [keyboard creatToolView:height];
}
    return keyboard;
}

- (void)creatToolView:(float)height
{
    self.backgroundColor = [UIColor colorWithWhite:0.803 alpha:0.780];
    self.layer.cornerRadius = 2;
    self.font = [UIFont systemFontOfSize:17];
    #pragma mark 发表栏工具栏
    UIView * toolView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 280, 40)];
    toolView.backgroundColor = [UIColor colorWithWhite:0.803 alpha:0.780];
    toolView.layer.cornerRadius = 2;
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor clearColor];
    button.showsTouchWhenHighlighted = YES;
    [toolView addSubview:button];
    [button release];
    button = [[UIButton alloc]initWithFrame:CGRectMake(toolView.bounds.size.width-50, 0, 40, 40)];
    [button setTitleColor:[UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.770] forState:UIControlStateNormal];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(complete) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor clearColor];
    button.showsTouchWhenHighlighted = YES;
    [toolView addSubview:button];
    [button release];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((toolView.bounds.size.width-40)/2, 0, 40, 40)];
    titleLabel.text = @"评论";
    titleLabel.textColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.420];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [toolView addSubview:titleLabel];
    [titleLabel release];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 38, 240, 0.5)];
    label.backgroundColor = [UIColor blueColor];
    [toolView addSubview:label];
    [label release];
    _MybottomView = [[UIView alloc]initWithFrame:CGRectMake(0, height-[UIScreen mainScreen].bounds.size.height/2-40, [UIScreen mainScreen].bounds.size.width, self.bounds.size.height + toolView.bounds.size.height)];
    [_MybottomView addSubview:self];
    [_MybottomView addSubview:toolView];
    [toolView release];
}

- (void)commentsStartAnimation:(NSString *)height
{
    if (_MybottomView.frame.origin.y > 0) {
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        _MybottomView.frame = CGRectMake(0, _MybottomView.frame.origin.y + [UIScreen mainScreen].bounds.size.height/2+40, _MybottomView.frame.size.width, _MybottomView.frame.size.height);
    }];
}


-(void)cancel
{
    KeyBoard *keyboard = [KeyBoard keyBoardShare];
    keyboard.text = nil;
    [self complete];
}

- (void)complete
{
    if (_MybottomView.frame.origin.y > 0) {
        [UIView animateWithDuration:0.25 animations:^{
            _MybottomView.frame = CGRectMake(0, _MybottomView.frame.origin.y - [UIScreen mainScreen].bounds.size.height/2-40, _MybottomView.bounds.size.width, _MybottomView.bounds.size.height);
        }completion:^(BOOL finished) {
        }];
    }
    KeyBoard *keyboard = [KeyBoard keyBoardShare];
    [(DZjOriginalCell *)keyboard.delegate performSelector:@selector(comentsAction:) withObject:keyboard];
    
    
}

- (void)keyboardShow:(NSNotification *)notification
{
    if (![self isFirstResponder]) {
        return;
    }
    [self commentsStartAnimation:nil];
    
}

- (void)keyboardHide:(NSNotification *)notification
{
    
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
