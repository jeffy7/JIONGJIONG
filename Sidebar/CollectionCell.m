//
//  CollectionCell.m
//  JIONGJIONG
//
//  Created by lanou on 13-12-4.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "CollectionCell.h"
#import "UIImageView+ImageZoom.h"
#import "AudioVideoViewController.h"
@implementation CollectionCell
-(void)dealloc
{
    [_collectionArray release];
    [super dealloc];
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self CollectionCellView];
        self.collectionArray = [NSMutableArray array];
    }
    return self;
}
- (void)CollectionCellView
{
    
    _showView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 40, 40)];
    [self.contentView addSubview:self.showView];
    _showView.userInteractionEnabled = YES;
    _showView.contentMode = UIViewContentModeScaleAspectFit;
    [_showView release];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(publishImageAction2:)];
    [_showView addGestureRecognizer:tap2];
    [tap2 release];
    
    
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 200, 40)];
    [self.contentView addSubview:_userNameLabel];
    _userNameLabel.backgroundColor = [UIColor clearColor];
    [_userNameLabel release];
    
    
    _collectLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 300, 50)];
    [self.contentView addSubview:_collectLabel];
    _collectLabel.backgroundColor = [UIColor clearColor];
    [_collectLabel release];
    
    
    _collectView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 60, 100, 100)];
    [self.contentView addSubview:_collectView];
    _collectView.contentMode = UIViewContentModeScaleAspectFit;
    _collectView.userInteractionEnabled  = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(publishImageAction:)];
    [_collectView addGestureRecognizer:tap];
    tap.delegate = _collectView;
    [tap release];
    [_collectView release];

}

#pragma mark 图片相应事件  头像的相关事件
- (void)publishImageAction2:(id)senter{
    if (!_vedioURL||_vedioURL.length<1) {
        
        [_showView pictureBecomeBig];
        
    }else
    {
        //创建播放器对象
        AudioVideoViewController *videoPlayer = [[AudioVideoViewController alloc]initWithContentURL:[NSURL URLWithString:_vedioURL]];
        [self.window.rootViewController presentViewController:videoPlayer animated:YES completion:^{
            
        }];
        [videoPlayer release];
        
    }
    
}
#pragma mark 图片相应事件
- (void)publishImageAction:(id)senter{
    if (!_vedioURL||_vedioURL.length<1) {
        
        [_collectView pictureBecomeBig];
    }else
    {
                //创建播放器对象
        AudioVideoViewController *videoPlayer = [[AudioVideoViewController alloc]initWithContentURL:[NSURL URLWithString:_vedioURL]];
        [self.window.rootViewController presentViewController:videoPlayer animated:YES completion:^{
            
        }];
        [videoPlayer release];
        
    }
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
