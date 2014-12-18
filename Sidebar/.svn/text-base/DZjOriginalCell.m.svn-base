//
//  DZjOriginalCell.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-5.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "DZjOriginalCell.h"
#import "UIImageView+ImageZoom.h"
#import "KeyBoard.h"
#import "UserInfo.h"
#import "AudioVideoViewController.h"

@implementation DZjOriginalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        _userImageView.contentMode = UIViewContentModeScaleAspectFit;
        _userImageView.image = [UIImage imageNamed:@"defaultHeadImage"];
        UITapGestureRecognizer *userImgetap = [[UITapGestureRecognizer alloc]initWithTarget:_userImageView action:@selector(pictureBecomeBig)];
        [_userImageView addGestureRecognizer: userImgetap];
        _userImageView.userInteractionEnabled = YES;
        userImgetap.delegate = self;
        [userImgetap release];
        
        _usernameLabel = [[DZJLabel alloc]initWithFrame:CGRectMake(_userImageView.frame.size.width+10, 0, 100, 20)];
        _usernameLabel.textColor = [UIColor colorWithRed:0.127 green:0.548 blue:1.000 alpha:1.000];
        _usernameLabel.font = [UIFont boldSystemFontOfSize:15];
        _usernameLabel.text = @"囧囧游客";
        _publishTime = [[DZJLabel alloc]initWithFrame:CGRectMake(self.bounds.size.width - 80, 0, 80, 20)];
         _publishTime.text = @"今天";
        _publishTime.font = [UIFont systemFontOfSize:12];
        
        _text = [[DZJLabel alloc]initWithFrame:CGRectMake(40, _userImageView.bounds.size.height, self.bounds.size.width-40, 0)];
        _publishImageView = [[UIImageView alloc]initWithFrame:CGRectMake(40, _text.frame.origin.y + _text.bounds.size.height, self.bounds.size.width-40, self.bounds.size.width-40)];
        _publishImageView.contentMode = UIViewContentModeScaleAspectFit;
        _publishImageView.userInteractionEnabled = YES;
        _commentsIcon = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - 40, _publishImageView.frame.origin.y + _publishImageView.bounds.size.height, 40, 40)];
        _commentsIcon.contentMode = UIViewContentModeScaleAspectFill;
        _commentsIcon.userInteractionEnabled = YES;
        [_commentsIcon setImage:[UIImage imageNamed:@"pluginboard_icon_comment"] forState:UIControlStateNormal];
        [_commentsIcon addTarget:self action:@selector(commentAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _comments = [[UITextView alloc]initWithFrame:CGRectMake(40,  _commentsIcon.frame.origin.y +  _commentsIcon.bounds.size.height,self.bounds.size.width-40, 0)];
        _comments.backgroundColor = [UIColor colorWithWhite:0.897 alpha:0.490];
        _comments.layer.cornerRadius = 5;
        _comments.userInteractionEnabled = NO;
         [self.contentView addSubview:_userImageView];
         [self.contentView addSubview:_usernameLabel];
         [self.contentView addSubview:_publishTime];
         [self.contentView addSubview:_text];
         [self.contentView addSubview:_publishImageView];
         [self.contentView addSubview:_commentsIcon];
         [self.contentView addSubview:_comments];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(publishImageAction:)];
        [_publishImageView addGestureRecognizer:tap];
        tap.delegate = self;
        [tap release];
        
        self.viedoPlay = [UIButton buttonWithType:UIButtonTypeCustom];
        [_viedoPlay addTarget:self action:@selector(publishImageAction:) forControlEvents:UIControlEventTouchUpInside];
        [_viedoPlay setImage:[UIImage imageNamed:@"VieoCorn"] forState:UIControlStateNormal];
        [_viedoPlay setImage:[UIImage imageNamed:@"VieoCornSelect"] forState:UIControlStateHighlighted];
        _viedoPlay.bounds = CGRectMake(0, 0, 50, 50);
        _viedoPlay.backgroundColor = [UIColor clearColor];
        [_publishImageView addSubview:_viedoPlay];
        _viedoPlay.showsTouchWhenHighlighted = YES;
        _viedoPlay.hidden = YES;
    }
    return self;
}

#pragma mark 图片相应事件
- (void)publishImageAction:(id)senter{
    if (!_viedoUrlSting||_viedoUrlSting.length<1) {
        [_publishImageView pictureBecomeBig];
    }else
    {
        if (![senter isMemberOfClass:[UIButton class]]) {
            return;
        }
        //创建播放器对象
        AudioVideoViewController *videoPlayer = [[AudioVideoViewController alloc]initWithContentURL:[NSURL URLWithString:_viedoUrlSting]];
        [self.window.rootViewController presentViewController:videoPlayer animated:YES completion:^{
            
        }];
        [videoPlayer release];

    }
    
}



- (void)commentAction:(UIButton *)senter
{
    KeyBoard *keyboard = [KeyBoard keyBoardShare];
    keyboard.text = @"";
    //关闭屏幕相应
    self.window.rootViewController.view.userInteractionEnabled = NO;
    keyboard.delegate = self;
    [keyboard becomeFirstResponder];
    
}

#pragma mark 点击键盘的完成调用的方法
- (void)comentsAction:(UITextView *)textView
{
    //开启屏幕相应
    
    self.window.rootViewController.view.userInteractionEnabled =YES;
    //如果内容不为空则刷新内容
    if (textView.text.length) {
        textView.text = [textView.text stringByAppendingString:@"\n"];
        NSString *userName = @"囧友用户: ";
        UserInfo *user = [UserInfo userShare];
        if (user.passWord.length >=6&&user.userName.length>=6) {
            userName = [NSString stringWithFormat:@"%@: ",user.userName];
        }
        self.dataArray[self.indexPath.row] = [self.comments.text stringByAppendingString:[userName stringByAppendingString: textView.text]];
        UITableView *tableView = (UITableView *)self.tag;
        [tableView reloadData];
        if ([self.delegete respondsToSelector:@selector(updataCommentWith:)]) {
            
            [self.delegete updataCommentWith:self.indexPath.row];
        }
        
    }
    [textView resignFirstResponder];
    textView.delegate = nil;

}




-(CGFloat)returnHightForCell:(NSString *)textSting cellImage:(BOOL)exit comments:(NSString *) comments
{
    float fixedHight = 80;
    float picHight = 0;
    float textHight = 0;
    float conmmentsHight = 0;
    if (exit) {
        picHight = (self.bounds.size.width-40)/2;
    }
    _text.text = textSting;
    _text.frame = CGRectMake(_text.frame.origin.x, _text.frame.origin.y, self.bounds.size.width-40, 0);
    [_text sizeToFit];
    textHight = _text.bounds.size.height;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        _comments.bounds = CGRectMake(0, 0,self.bounds.size.width-40, 0);
        _comments.text = comments;
        [_comments sizeToFit];
        conmmentsHight = _comments.bounds.size.height;
    }else
    {
        _comments.bounds = CGRectMake(0, 0, self.bounds.size.width-40, 0);
        _comments.contentSize = CGSizeMake(self.bounds.size.width-40, 0);
        _comments.text = comments;
        conmmentsHight = _comments.contentSize.height;
    }
    if (!_comments.text.length) {
        conmmentsHight = 0;
    }
   
    return fixedHight + picHight + textHight + conmmentsHight+10;
    
}


- (void)refreshposition:(BOOL)imageExist
{
    _text.frame = CGRectMake(_text.frame.origin.x, _text.frame.origin.y, self.bounds.size.width-40, 0);
    [_text sizeToFit];
    float picHight = 0;
    float conmmentsHight = 0;
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0)
    {
        _comments.bounds = CGRectMake(0, 0,self.bounds.size.width-40, 0);
        [_comments sizeToFit];
        conmmentsHight = _comments.bounds.size.height;
    }else
    {
        conmmentsHight =_comments.contentSize.height;
    }
    if (imageExist) {
        picHight = (self.bounds.size.width-40)/2;
    }
    if (!_comments.text.length) {
        conmmentsHight = 0;
    }
    
    _publishImageView.frame = CGRectMake(40, _text.frame.origin.y + _text.bounds.size.height,  _publishImageView.frame.size.width,picHight);
    _commentsIcon.frame = CGRectMake(self.bounds.size.width - 40, _publishImageView.frame.origin.y + _publishImageView.bounds.size.height, _commentsIcon.frame.size.width, _commentsIcon.frame.size.height);
    _comments.frame = CGRectMake(40,  _commentsIcon.frame.origin.y +  _commentsIcon.bounds.size.height, self.bounds.size.width-40, conmmentsHight);
    if (_viedoUrlSting.length > 1) {
        _viedoPlay.center = CGPointMake(_publishImageView.bounds.size.width/2, _publishImageView.bounds.size.height/2);
        _viedoPlay.hidden = NO;
    }else
    {
        _viedoPlay.hidden = YES;
    }

}


- (void)dealloc
{
   
    [_viedoUrlSting release];
    [_viedoPlay release];
    [_indexPath release];
    [_dataArray release];
    [_publishImageView release];
    [_userImageView release];
    [_usernameLabel release];
    [_publishTime release];
    [_text release];
    [_commentsIcon release];
    [_comments release];
    [super dealloc];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
