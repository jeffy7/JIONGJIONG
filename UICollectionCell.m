//
//  UICollectionCell.m
//  Sidebar
//
//  Created by dongzhejia on 13-12-2.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "UICollectionCell.h"

@implementation UICollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.collectionArray = [NSMutableArray array];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width*2/3)];
       _label = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.width*2/3, self.bounds.size.width, self.bounds.size.width/3)];
        _imageView.backgroundColor = [UIColor blackColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.numberOfLines = 2;
        self.label.font = [UIFont systemFontOfSize:15];
        self.label.backgroundColor = [UIColor clearColor];
        _numberOFplaylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _label.frame.origin.y + _label.bounds.size.height, self.bounds.size.width, self.bounds.size.width*1/6)];
        self.numberOFplaylabel.textAlignment = NSTextAlignmentLeft;
        self.numberOFplaylabel.numberOfLines = 1;
        self.numberOFplaylabel.font = [UIFont systemFontOfSize:13];
        self.numberOFplaylabel.backgroundColor = [UIColor clearColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_numberOFplaylabel];
        [self addSubview:self.imageView];
        [self addSubview:self.label];
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(colection:)];
        [self.contentView addGestureRecognizer:longPress];
        [longPress release];

    }
    return self;
}
- (void)colection:(UILongPressGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateBegan) {
        //显示收藏与分享
        [self becomeFirstResponder];
        //        显示菜单栏

        UIMenuItem *collect = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(collect:)];
        UIMenuItem *share = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(share:)];
        _menu = [UIMenuController sharedMenuController];
        
        CGRect rect = _menu.menuFrame;
        rect.origin = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        _menu.menuItems = [NSArray arrayWithObjects:share,collect, nil];
        [_menu setTargetRect:rect inView:self];
        [_menu setMenuVisible:YES animated:YES];
        [collect release];
        [share release];

    }
    
}
- (BOOL)canBecomeFirstResponder
{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
   
    if (action == @selector(share:)) {
        return YES;
    }
    if (action == @selector(collect:)) {
        return YES;
    }
    return NO;
}

#pragma  mark -----------
#pragma  mark  收藏
static inline NSString * cachePath ()
{
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collect"];
    return document;
}
- (void)collect:(id)sender
{
    //1把数据传回去
    _collect = [[Collection alloc] init];
    _collect.collectHum = self.label.text;
    _collect.userName = @"视频";
    _collect.userImage = [UIImage imageNamed:@"VieoCorn"];
    _collect.collectImage = _imageView.image;
    _collect.vedioURL = self.vedioUrlString;
    
    NSFileManager *fileManger = [NSFileManager defaultManager];
    //先判断有没有    有就反归档
    if ([fileManger fileExistsAtPath:cachePath()]) {
        [self unarchiver];
    }else{
        [self.collectionArray addObject:_collect];
        [_collect release];
        
    }
    
    //2  存储到数据库
    //归档这个可变数组
    [self archiver];
    
    //3提示存储成
    
}
- (void)archiver
{
    NSFileManager *fileManger = [NSFileManager defaultManager];
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.collectionArray forKey:@"coll"];
    [archiver finishEncoding];
    [fileManger createFileAtPath:cachePath() contents:data attributes:nil];
    [archiver release];
}
- (void)unarchiver
{
    
    //放归档
    NSMutableData *data = [NSData dataWithContentsOfFile:cachePath()];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    self.collectionArray = [unarchiver decodeObjectForKey:@"coll"];
    [unarchiver finishDecoding];
    [self.collectionArray addObject:_collect];
    [unarchiver release];
    
}
#pragma  mark -----------
#pragma  mark  分享
- (void)share:(id)sender
{
    NSString *text = [self.label.text stringByAppendingString:self.vedioUrlString];
    //代理   让controller来触发分享按钮
    if ([self.delegate respondsToSelector:@selector(didShareButtonWith:showTextLabel:showImage:)]) {
        [self.delegate didShareButtonWith:sender showTextLabel:text showImage:_imageView.image];
    }
    
}
- (void)reflashLabelSize
{
    self.label.frame = CGRectMake(0, self.bounds.size.width*2/3, self.bounds.size.width, self.bounds.size.width*1/6);
    [self.label sizeToFit];
    self.numberOFplaylabel.frame = CGRectMake(0, _label.frame.origin.y + _label.bounds.size.height, self.bounds.size.width, self.bounds.size.width*1/6);
    
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [_numberOFplaylabel release];
    [_vedioUrlString release];
    [_menu release];
    [_collect release];//一个收藏的实例对象
    [_collectionArray release];//收藏的
    [_imageView release];
    [_label release];
    [super dealloc];
}
@end
