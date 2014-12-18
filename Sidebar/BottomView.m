//
//  BottomView.m
//  TextProgect
//
//  Created by dongzhejia on 13-11-29.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "BottomView.h"
#import "UserInfo.h"
#import "UIImage+Resizing.h"
#import "landingViewController.h"
@implementation BottomView


#pragma mark 返回对应文件名的Caches路径
static inline NSString *Cachespath(NSString *name)
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:name];
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
#pragma mark 获取用户信息
        UserInfo *userInfo = [UserInfo userShare];
        userInfo.userName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        userInfo.passWord = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPassWord"];
        
        _background = [[UIImageView alloc]initWithFrame:frame];
        if ([@"ON" isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"daySwitch"]]) {
            self.background.image = [UIImage imageNamed:@"sliderBarBackGroundNight"];
        }else
        {
            self.background.image = [UIImage imageNamed:@"sidebar_bg.jpg"];
        }
        
        self.backgroundView = self.background;
        self.backgroundColor = [UIColor clearColor];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        _userImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 30, 80, 80)];
        //设置默认图片
        _userImageView.image = [UIImage imageNamed:@"半透明图标"];
        NSString *imagePath = Cachespath([NSString stringWithFormat:@"Photoes/%@",userInfo.userName]);
        NSFileManager *fileManager = [NSFileManager defaultManager];
        if ([fileManager fileExistsAtPath:imagePath]&&userInfo.passWord.length>=6&&userInfo.userName.length>=6) {
            UIImage *image = [[UIImage alloc]initWithContentsOfFile:imagePath];
            _userImageView.image = image;
            [image release];
        }
        
        
        _userImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userImageView.layer.cornerRadius = _userImageView.bounds.size.width/2;
        _userImageView.layer.masksToBounds = YES;
        _userImageView.userInteractionEnabled = YES;
        //为照片添加手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setUserImage)];
        [_userImageView addGestureRecognizer:tap];
        [tap release];
        
        _username = [[UILabel alloc]initWithFrame:CGRectMake(20, _userImageView.frame.origin.y+_userImageView.bounds.size.height+5, 80, 20)];
        _username.textAlignment = NSTextAlignmentCenter;
        _username.textColor = [UIColor whiteColor];
        _username.text = @"囧囧用户";
        if (userInfo.userName&&userInfo.passWord.length>=6&&userInfo.userName.length>=6) {
            _username.text = userInfo.userName;
        }
        
        _username.backgroundColor = [UIColor clearColor];
        _username.adjustsFontSizeToFitWidth = YES;
         UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, _userImageView.bounds.size.height + _username.bounds.size.height + 40)];
        [headView addSubview:_username];
        [headView addSubview:_userImageView];
        self.tableHeaderView = headView;
        [headView release];
    }
    return self;

}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setUserImage
{
    UserInfo *userInfo = [UserInfo userShare];
    if (userInfo.passWord.length>=6&&userInfo.userName.length>=6){
        [self myMethod:nil];
    }else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您还未登录,是否登录" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [self addSubview:alert];
        [alert show];
        [alert release];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex) {
        landingViewController *landing = [[landingViewController alloc]init];
        landing.dismiss = YES;
        #pragma mark 登陆视图
        [self.window.rootViewController presentViewController:landing animated:YES completion:^{
            
        }];
        [landing release];

    }
}

#pragma mark 打开相册
-(void) myMethod:(id)sender{
    UIImagePickerController *pc = [[UIImagePickerController alloc]init];
    pc.delegate = self;
    pc.allowsEditing = YES;
    pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.window.rootViewController presentViewController:pc animated:YES completion:^{
        
    }];
    [pc release];
}

#pragma mark 代理方法
-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _userImageView.image = [self compress:image];;
    [self completedAction];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(UIImage *)compress:(UIImage *)image
{
    return [image scaleToFitSize:CGSizeMake(_userImageView.bounds.size.width*2, _userImageView.bounds.size.height*2)];
    
}



#pragma mark 完成按钮响应事件
- (void)completedAction{
#pragma mark 将图片插入到图片库
    if (_userImageView.image) {
        UserInfo *userInfo = [UserInfo userShare];
        NSString *imagePath = Cachespath([NSString stringWithFormat:@"Photoes/%@",userInfo.userName]);
        NSData *imagedata = UIImageJPEGRepresentation(_userImageView.image, 1);
        [imagedata writeToFile:imagePath atomically:YES];
    }
}



- (void)dealloc
{
    [_username release];
    [_userImageView release];
    [_background release];
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
