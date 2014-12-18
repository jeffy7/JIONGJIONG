//
//  landingView.h
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-9.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JeffyHumorousColsction.h"

@interface landingView : UIView<UITextFieldDelegate,JeffyHumorousColsctionDelegate,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImageView * _frostedGlassEffectImageView;
    UIImageView * _logoImageView;
    UIView      * _loginView;
    UIView      * _registerView;
}
@property(nonatomic,retain)UITextField * accountNumberField;//用户名输入框
@property(nonatomic,retain)UITextField * passWordField;//密码输入框

@property(nonatomic,retain)UITextField * userName_register;//用户名输入框
@property(nonatomic,retain)UITextField * passWord_register;//密码输入框
@property(nonatomic,retain)UITextField * confirmPassword_register;//密码确认

@property(nonatomic,assign) UIViewController *presentVC;
@property(nonatomic,assign) BOOL keyBoard;
@property(nonatomic,assign) BOOL dismiss;


@property (nonatomic,retain)NSMutableArray *allUser;//所有 的用户
@property(nonatomic,retain) NSMutableArray *oneUser;//单个用户,用来判断密码用的

@property (nonatomic,retain)JeffyHumorousColsction *allUserData;//如果是所有的用户
@property(nonatomic,retain) JeffyHumorousColsction *insertData;//插入一个用户的回传
@property(nonatomic,retain) JeffyHumorousColsction *slectedUsetData;//查找一个用户汇创的数据
@property (nonatomic,retain)NSString *password;//中间存储 的密码
@end

