//
//  landingView.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-9.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "landingView.h"
#import "UserInfo.h"
#import "UIImage+ImageEffects.h"
#import "UIImage+Resizing.h"
#import "WebAddress.h"
@implementation landingView

static int height = 0;
-(void)dealloc
{

    [_password release];
    
    [_allUser release];
    [_oneUser release];
    
    [_insertData cancelResquest];
    [_allUserData cancelResquest];
    [_slectedUsetData cancelResquest];
    
    [_allUserData release];
    [_insertData release];
    [_slectedUsetData release];
    
    if ([UIScreen mainScreen].bounds.size.height ==480) {

        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    }
    

    [super dealloc];
}
+(void)MoveView:(UIView *)view To:(CGRect)frame During:(float)time{
    
    // 动画开始
    [UIView beginAnimations:nil context:nil];
    // 动画时间曲线 EaseInOut效果
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 动画时间
    [UIView setAnimationDuration:time];
    view.frame = frame;
    [UIView commitAnimations];
    
}
-(void)makeLoginViewVisiable
{
    
    [landingView MoveView:_frostedGlassEffectImageView To:self.bounds During:0.5];
    if ([[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        height = 44;
    }else{
        height = 10;
    }
    [landingView MoveView:_logoImageView To:CGRectMake(110,height, 100, 100) During:0.5];
    [landingView MoveView:_loginView To: CGRectMake(20, height+111, 280, 180) During:0.5];
    
}
- (void)keyboardShow:(NSNotification *)notification
{
    [landingView MoveView:_frostedGlassEffectImageView To:self.bounds During:0.5];
    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect rect = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration animations:^{
            
//            CGRect temp = _logoImageView.frame;
//            temp.origin.y = _logoImageView.frame.origin.y - 90;
//            _logoImageView.frame = temp;
        
            CGRect temp2 = _loginView.frame;
            temp2.origin.y = self.bounds.size.height - rect.size.height-_loginView.bounds.size.height;
            _loginView.frame = temp2;
            
            CGRect temp3 = _registerView.frame;
            temp3.origin.y = self.bounds.size.height - rect.size.height-_registerView.bounds.size.height;
            _registerView.frame = temp3;
        [UIView setAnimationCurve:[curve intValue]];


    }];

}

- (void)keyboardHide:(NSNotification *)notification
{

    CGFloat duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
	NSNumber *curve = [notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];
    [UIView animateWithDuration:duration animations:^{
        
//        CGRect temp = _logoImageView.frame;
//        temp.origin.y = _logoImageView.frame.origin.y + 90;
//        _logoImageView.frame = temp;
        
        CGRect temp2 = _loginView.frame;
        temp2.origin.y = _loginView.frame.origin.y + 90;
        _loginView.frame = temp2;
        
        CGRect temp3 = _registerView.frame;
        temp3.origin.y = _registerView.frame.origin.y + 90;
        _registerView.frame = temp3;
        
        [UIView setAnimationCurve:[curve intValue]];
        
    }];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.allUser = [NSMutableArray array];
        self.oneUser = [NSMutableArray array];
        
        if ([UIScreen mainScreen].bounds.size.height ==480) {
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        }
        
        
        //1
        _allUserData = [[JeffyHumorousColsction alloc] init];
        [_allUserData dataGetWithUrl:@"http://msg.lanou3g.com/student/class_11/team_three/resource/AllPHP/JJSlectedAllUser.php"];
        self.allUserData.delegate = self;
        
        //2
        _insertData = [[JeffyHumorousColsction alloc] init];
        
        //3查找用户的
        _slectedUsetData = [[JeffyHumorousColsction alloc] init];
        _slectedUsetData.delegate = self;
    
        
        _accountNumberField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
        _passWordField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"userPassWord"];
        
        
        [self frostedGlassEffectImageView];
        [self performSelector:@selector(makeLoginViewVisiable) withObject:self afterDelay:0.5];
        
    }
    return self;
}


-(void)frostedGlassEffectImageView
{
    //---------------------------------------------------------------------------
    //毛玻璃效果
    _frostedGlassEffectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height)];
    [_frostedGlassEffectImageView setImage:[[UIImage imageNamed:@"night_user_header_defaultbg.jpg"] applyBlurWithRadius:5 tintColor:[UIColor colorWithWhite:0.5 alpha:0.2] saturationDeltaFactor:1.8 maskImage:nil]];
//    _frostedGlassEffectImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_frostedGlassEffectImageView];
    [_frostedGlassEffectImageView release];
    //---------------------------------------------------------------------------
    //Logo
    _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(110, 586, 100, 100)];
    _logoImageView.image = [UIImage imageNamed:@"不透明图标"];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _logoImageView.layer.masksToBounds = YES;
    _logoImageView.layer.cornerRadius = 50;
    _logoImageView.layer.opacity = 0.8;
    _logoImageView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_logoImageView];
    [_logoImageView release];
    

    //为照片添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myMethod:)];
    [_logoImageView addGestureRecognizer:tap];
    [tap release];
    
#pragma mark 登录部分
    //---------------------------------------------------------------------------
    //登录
    _loginView = [[UIView alloc] initWithFrame:CGRectMake(500, height+111, 280, 180)];
    _loginView.layer.cornerRadius = 5;
    _loginView.layer.opacity = 0.8;
    _loginView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_loginView];
    [_loginView release];
    //----------------------------------------------------------------------------
    //用户名输入框
    _accountNumberField = [[UITextField alloc] initWithFrame:CGRectMake(50, 15, 180, 35)];
    _accountNumberField.borderStyle = UITextBorderStyleRoundedRect;
    _accountNumberField.placeholder = @"请输入用户名";
    _accountNumberField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_loginView addSubview:_accountNumberField];
    [_accountNumberField release];
    _accountNumberField.delegate = self;
    //----------------------------------------------------------------------------
    //密码输入框
    _passWordField = [[UITextField alloc] initWithFrame:CGRectMake(50, 65, 180, 35)];
    _passWordField.borderStyle = UITextBorderStyleRoundedRect;
    _passWordField.placeholder = @"请输入密码";
    _passWordField.secureTextEntry = YES;
    _passWordField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_loginView addSubview:_passWordField];
    [_passWordField release];
    _passWordField.delegate = self;
    
    //----------------------------------------------------------------------------
    //登录按钮
    UIButton * login = [UIButton buttonWithType:UIButtonTypeCustom];
    login.frame = CGRectMake(50, 115, 180, 40);
    login.backgroundColor = [UIColor colorWithRed:1.000 green:0.207 blue:0.103 alpha:0.800];
    login.layer.cornerRadius = 5;
    [login setTitle:@"登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [login setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_loginView addSubview:login];
    [login addTarget:self action:@selector(landAction) forControlEvents:UIControlEventTouchUpInside];
    
    //----------------------------------------------------------------------------
    //推出注册界面
    UIButton * pushRegisterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushRegisterButton.frame = CGRectMake(236, 115, 40, 40);
    pushRegisterButton.backgroundColor = [UIColor colorWithRed:0.120 green:0.907 blue:1.000 alpha:0.900];
    pushRegisterButton.layer.cornerRadius = 5;
    [pushRegisterButton setImage:[UIImage imageNamed:@"_CJRegister"] forState:UIControlStateNormal];
    [pushRegisterButton addTarget:self action:@selector(pushRegisterButtonAction) forControlEvents:UIControlEventTouchDown];
    [_loginView addSubview:pushRegisterButton];

    
    //---------------------------------------------------------------------------
#pragma mark 注册部分
    //---------------------------------------------------------------------------
    //注册
    _registerView = [[UIView alloc] initWithFrame:CGRectMake(-280, height+111, 280, 180)];
    _registerView.layer.cornerRadius = 5;
    _registerView.layer.opacity = 0.8;
    _registerView.backgroundColor = [UIColor whiteColor];
    _registerView.hidden = YES;
    [self addSubview:_registerView];
    [_registerView release];
    
    //---------------------------------------------------------------------------
    //用户名输入框
    _userName_register = [[UITextField alloc] initWithFrame:CGRectMake(50, 10, 180, 35)];
    _userName_register.borderStyle = UITextBorderStyleRoundedRect;
    _userName_register.placeholder = @"用户名(6~12位)";
    _userName_register.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_registerView addSubview:_userName_register];
    [_userName_register release];
    _userName_register.delegate = self;
    //---------------------------------------------------------------------------
    //密码输入框
    _passWord_register = [[UITextField alloc] initWithFrame:CGRectMake(50, 50, 180, 35)];
    _passWord_register.borderStyle = UITextBorderStyleRoundedRect;
    _passWord_register.placeholder = @"密码(6~12位)";
    _passWord_register.secureTextEntry = YES;
    _passWord_register.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_registerView addSubview:_passWord_register];
    [_passWord_register release];
    _passWord_register.delegate = self;
    //---------------------------------------------------------------------------
    //密码确认
    _confirmPassword_register = [[UITextField alloc] initWithFrame:CGRectMake(50, 90, 180, 35)];
    _confirmPassword_register.borderStyle = UITextBorderStyleRoundedRect;
    _confirmPassword_register.placeholder = @"再次输入密码";
    _confirmPassword_register.secureTextEntry = YES;
    _confirmPassword_register.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_registerView addSubview:_confirmPassword_register];
    [_confirmPassword_register release];
    _confirmPassword_register.delegate = self;
    
    //---------------------------------------------------------------------------
    //注册按钮
    UIButton * regist = [UIButton buttonWithType:UIButtonTypeCustom];
    regist.frame = CGRectMake(50, 135, 180, 40);
    regist.backgroundColor = [UIColor colorWithRed:1.000 green:0.207 blue:0.103 alpha:0.800];
    regist.layer.cornerRadius = 5;
    [regist setTitle:@"注册" forState:UIControlStateNormal];
    [regist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [regist setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_registerView addSubview:regist];
    [regist addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];
    
    //---------------------------------------------------------------------------
    //推出登录界面
    UIButton * pushLoginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    pushLoginButton.frame = CGRectMake(4, 135, 40, 40);
    pushLoginButton.backgroundColor = [UIColor colorWithRed:0.120 green:0.907 blue:1.000 alpha:0.900];
    pushLoginButton.layer.cornerRadius = 5;
    [pushLoginButton setImage:[UIImage imageNamed:@"CJLogin"] forState:UIControlStateNormal];
    [pushLoginButton addTarget:self action:@selector(pushLoginButtonAction) forControlEvents:UIControlEventTouchDown];
    [_registerView addSubview:pushLoginButton];
    //---------------------------------------------------------------------------
    
}


#pragma mark 打开相册
-(void) myMethod:(id)sender{
    UIImagePickerController *pc = [[UIImagePickerController alloc]init];
    pc.delegate = self;
    pc.allowsEditing = NO;
    pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.window.rootViewController presentViewController:pc animated:YES completion:^{
        
    }];
    [pc release];
}

#pragma mark 代理方法
-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _logoImageView.image = [self compress:image];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)completedAction{
#pragma mark 将图片插入到图片库
    if (_logoImageView.image) {
        UserInfo *userInfo = [UserInfo userShare];
        NSString *userPath = [NSString stringWithFormat:@"Photoes/%@",userInfo.userName];
        NSString *imagePath = Cachespath(userPath);
        NSData *imagedata = UIImageJPEGRepresentation(_logoImageView.image, 1);
        [imagedata writeToFile:imagePath atomically:YES];
    }
}


-(UIImage *)compress:(UIImage *)image
{
    return [image scaleToFitSize:CGSizeMake(_logoImageView.bounds.size.width*2, _logoImageView.bounds.size.height*2)];
    
}
#pragma mark -----------------------------
#pragma mark 登陆注册界面切换
-(void)pushRegisterButtonAction
{
    _registerView.hidden = NO;
    _presentVC.navigationItem.title = @"欢迎注册";
    _logoImageView.userInteractionEnabled = YES;
    
    if (_logoImageView.frame.origin.y >= 10 ) {
       
        [landingView MoveView:_loginView To:CGRectMake(20+320, height+111, 280, 180) During:1];
        [landingView MoveView:_registerView To:CGRectMake(20, height+111, 280, 180) During:1];
    }else{
        [landingView MoveView:_loginView To:CGRectMake(20+320, height+111-90, 280, 180) During:1];
        [landingView MoveView:_registerView To:CGRectMake(20, height+111-90, 280, 180) During:1];
        
    }
    
}

-(void)pushLoginButtonAction
{
    _logoImageView.userInteractionEnabled = NO;
    _presentVC.navigationItem.title = @"欢迎登陆";
    if (_logoImageView.frame.origin.y >= 10 ) {
        [landingView MoveView:_registerView To:CGRectMake(20-640, height+111, 280, 180) During:1];
        [landingView MoveView:_loginView To:CGRectMake(20, height+111, 280, 180) During:1];
    }else{
        [landingView MoveView:_registerView To:CGRectMake(20-640, height+111-90, 280, 180) During:1];
        [landingView MoveView:_loginView To:CGRectMake(20, height+111-90
                                                       , 280, 180) During:1];
    }
   
    
}

///数据回传的代理方法
- (void)requestDataSuccessful:(JeffyHumorousColsction *)humConnection
{
    if (humConnection == self.allUserData) {
        
        //输出所有的用户
        NSArray *array = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:humConnection.receiveData options:0 error:nil]];
        for (NSDictionary *dic in array) {
            UserInfo *user = [[UserInfo alloc] init];
            user.userName = dic[@"userName"];
            user.passWord = dic[@"password"];
            user.photoURL = dic[@"photoURL"];
            user.userID = [dic[@"userID"] intValue];
            [self.allUser addObject:user];
            [user release];
            
        }
    }
    
    if (humConnection == self.slectedUsetData) {
        
        NSArray * arrayy = [NSMutableArray arrayWithArray:[NSJSONSerialization JSONObjectWithData:humConnection.receiveData options:0 error:nil]];
        
        //首先得判断是否为空
        if (arrayy.count) {
            for (NSDictionary *dic in arrayy) {
                UserInfo * user = [[UserInfo alloc] init];
                user.userName = dic[@"userName"];
                user.passWord = dic[@"password"];
                user.photoURL = dic[@"photoURL"];
                user.userID = [dic[@"userID"] intValue];
                [self.oneUser addObject:user];
                [user release];
                
            }
        }
        
        
        if (!arrayy.count) {
            //账号不存在
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名不存在" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alert show];
        }else{
            for (UserInfo *use in self.oneUser) {
                if (![use.passWord isEqualToString:_password]) {
                    
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
                    [alert show];
                    return;
                    
                }
            }
        }
    }
}


//登录
-(void)landAction{
    
    //输入框的东西
    self.password = _passWordField.text;//全局变量
    
    for (UserInfo *use in self.allUser) {
        
        if ([_accountNumberField.text isEqualToString: use.userName] && [_passWordField.text isEqualToString: use.passWord]) {
            UserInfo *user = [UserInfo userShare];
            user.userName = _accountNumberField.text;
            user.passWord = _passWordField.text;
            
            //可以登录
            [[NSUserDefaults standardUserDefaults] setObject:user.userName forKey:@"userName"];
            [[NSUserDefaults standardUserDefaults] setObject:user.passWord forKey:@"userPassWord"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserInfo" object:nil userInfo:nil];
            
            if (_keyBoard) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"myKeboard" object:nil userInfo:nil];
            }
            
            if (_dismiss) {
                [self.presentVC dismissViewControllerAnimated:YES completion:^{
                    
                }];
            }else
            {
                [self.presentVC.navigationController popToRootViewControllerAnimated:YES];
            }


        }
    }
    
    //根据姓名来找密码 ,找不到就是密码错误
    NSString * url = @"http://124.205.147.26/student/class_11/team_three/resource/AllPHP/JJSlectAndJugeName.php";
    
    NSData * data = [[NSString stringWithFormat:@"userName=%@",_accountNumberField.text] dataUsingEncoding:NSUTF8StringEncoding];
    
    [self.slectedUsetData dataPOSTWithUrl:url body:data];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_accountNumberField resignFirstResponder];
    [_passWordField resignFirstResponder];
    [_userName_register resignFirstResponder];
    [_passWord_register resignFirstResponder];
    [_confirmPassword_register resignFirstResponder];
    return YES;
}


//注册
-(void)registerAction{
    
    
    //判断  首先把所有用户取出拉
    //输出所有的用户
    for (UserInfo *use in self.allUser) {
        
        
        if ([_userName_register.text isEqualToString: use.userName]) {
            //该用户已经存在  注册失败
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"该用户已经存在" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        
    }
    //~没有与数据库匹配的用户,可以注册
    if (_userName_register.text.length < 6 || _userName_register.text.length > 12 ||_passWord_register.text.length < 6|| _passWord_register.text.length > 12) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"账户或密码长度不对" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
    }
    if (![_passWord_register.text isEqual:_confirmPassword_register.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"两次密码不一致" delegate:self cancelButtonTitle:@"取消" otherButtonTitles: nil];
        [alert show];
        return;
        
        
    }
    if (_passWord_register.text.length>=6&&_passWord_register.text.length<=12&&_userName_register.text.length>=6&&_userName_register.text.length<=12&&
        [_passWord_register.text isEqual:_confirmPassword_register.text]) {
        UserInfo *user = [UserInfo userShare];
        user.userName = _userName_register.text;
        user.passWord = _passWord_register.text;
        
        [[NSUserDefaults standardUserDefaults] setObject:user.userName forKey:@"userName"];
        [[NSUserDefaults standardUserDefaults] setObject:user.passWord forKey:@"userPassWord"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self completedAction];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"changeUserInfo" object:nil userInfo:nil];
        
        if (_keyBoard) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"myKeboard" object:nil userInfo:nil];
        }

        
#pragma mark 将用户加入数据库
        NSString * url = @"http://msg.lanou3g.com/student/class_11/team_three/resource/AllPHP/JJInsertUser.php";
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"userID",user.userName,@"userName",user.passWord,@"password",@"",@"photo" ,nil];
        NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *content = [@"jsonContent" stringByAppendingFormat:@"=%@",jsonString];
        [jsonString release];
        _insertData = [[JeffyHumorousColsction alloc] init];
        _insertData.delegate = self;
        [self.insertData dataPOSTWithUrl:url body:[content dataUsingEncoding:NSUTF8StringEncoding]];
        //提示注册成功  并进入下一个界面
        if (_dismiss) {
            [self.presentVC dismissViewControllerAnimated:YES completion:^{
                
            }];
        }else
        {
            [self.presentVC.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//    [self endEditing:YES];
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
