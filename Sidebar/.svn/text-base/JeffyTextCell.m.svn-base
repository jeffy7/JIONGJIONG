//
//  JeffyTextCell.m
//  Program
//
//  Created by lanou on 13-12-2.
//  Copyright (c) 2013年 je_ffy. All rights reserved.
//

#import "JeffyTextCell.h"
#import "Collection.h"
#import "UIImageView+ImageZoom.h"
@implementation JeffyTextCell
- (void)dealloc
{
    [_collectionArray release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.collectionArray = [NSMutableArray array];
        [self EveryView];
    }
    return self;
}
- (void)EveryView
{
//    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView  *backGround = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_background.jpg"]];
    self.backgroundView = backGround;
    [backGround release];
    //三个视图
    _showView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [self.contentView addSubview:self.showView];
    [_showView release];
    
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 200, 40)];
    _userNameLabel.font = [UIFont boldSystemFontOfSize:17];
    _userNameLabel.textColor = [UIColor colorWithRed:0.000 green:0.004 blue:0.868 alpha:0.660];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_userNameLabel];
    [_userNameLabel release];
    
    
    
    _showTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 140)];
    _showTextLabel.backgroundColor = [UIColor clearColor];
    _showTextLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_showTextLabel];
    
    //给笑话添加一个手势   可以长按分享复制收藏
    self.contentView.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showShareAndCopy:)];
    [self.contentView addGestureRecognizer:longPress];
    [longPress release];
    
    //显示图片的位置
    _picImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 100, 100)];
    //往imageView里面放图片自适应
    _picImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_picImage];
    [_picImage release];
    _picImage.userInteractionEnabled = YES;
    //点击图片  放大

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.picImage action:@selector(pictureBecomeBig)];
    [_picImage addGestureRecognizer:tap];
    tap.delegate = _picImage;
    [tap release];
}

//计算行高
+ (CGFloat)calcultorHeightwith:(NSString *)humorous
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 10)];
    label.text = humorous;
    label.numberOfLines = 0;
    [label sizeToFit];
    int height = label.frame.size.height;
    [label release];
    return  height;
}

//长按执行的方法
- (void)showShareAndCopy:(UILongPressGestureRecognizer *)gester
{
    if (gester.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
//        显示菜单栏
        UIMenuItem *copy = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(coppy:)];
        UIMenuItem *collect = [[UIMenuItem alloc] initWithTitle:@"收藏" action:@selector(collect:)];
        UIMenuItem *share = [[UIMenuItem alloc] initWithTitle:@"分享" action:@selector(share:)];
        _menu = [UIMenuController sharedMenuController];
        
        CGRect rect = _menu.menuFrame;
        rect.origin = CGPointMake(0, 100);
        _menu.menuItems = [NSArray arrayWithObjects:share,collect,copy, nil];
        [_menu setTargetRect:rect inView:self];
        [_menu setMenuVisible:YES animated:YES];
        [copy release];
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
    if (action == @selector(coppy:)) {
        return YES;
    }
    if (action == @selector(share:)) {
        return YES;
    }
    if (action == @selector(collect:)) {
        return YES;
    }
    return NO;
}
#pragma  mark -----------
#pragma  mark  复制
- (void)coppy:(id)sender
{
    [UIPasteboard generalPasteboard].string = _showTextLabel.text;;
    [_menu setMenuVisible:NO animated:YES];
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
    _collect.collectHum = _showTextLabel.text;
    _collect.userName = _userNameLabel.text;
    _collect.userImage = _showView.image;
    _collect.collectImage = _picImage.image;
    
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
    NSKeyedArchiver *archiver = [[[NSKeyedArchiver alloc] initForWritingWithMutableData:data] autorelease];
    [archiver encodeObject:self.collectionArray forKey:@"coll"];
    [archiver finishEncoding];
    [fileManger createFileAtPath:cachePath() contents:data attributes:nil];
}
- (void)unarchiver
{

    //放归档
    NSMutableData *data = [NSData dataWithContentsOfFile:cachePath()];
    NSKeyedUnarchiver *unarchiver = [[[NSKeyedUnarchiver alloc] initForReadingWithData:data] autorelease];
    self.collectionArray = [unarchiver decodeObjectForKey:@"coll"];
    [unarchiver finishDecoding];
    [self.collectionArray addObject:_collect];
    [_collect release];
    
}
#pragma  mark -----------
#pragma  mark  分享
- (void)share:(id)sender
{
    //代理   让controller来触发分享按钮
    if ([self.delagate respondsToSelector:@selector(didShareButtonWith:showTextLabel:showImage:)]) {
        [self.delagate didShareButtonWith:sender showTextLabel:_showTextLabel.text showImage:_picImage.image];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
