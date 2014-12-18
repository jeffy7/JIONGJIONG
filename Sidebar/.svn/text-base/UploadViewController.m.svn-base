//
//  UploadViewController.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-9.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "UploadViewController.h"
#import "WebAddress.h"
#import "Singleton.h"
#import "ShareMood.h"
#import "UserInfo.h"
#import "UIImage+Resizing.h"
@interface UploadViewController ()

@end

@implementation UploadViewController
{
    //分割线
    NSString        *boundary;
    NSMutableData   *mutableData;
    //报体长度
    NSInteger       bodyLength;
    UIView *MybottomView;
    UILabel *loadLabel;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    
    [_insertParser cancelResquest];
    [_adressParser cancelResquest];
    [_allUrlArray release];
    [_insertParser release];
    
    [_videoAddress release];
    [_keyboardtool release];
    [_adressParser release];
    [_comment release];
    [_UploadImageView release];
    [_locationManager release];
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.490];
    int height = 50;
    if ([[UIDevice currentDevice].systemVersion floatValue]<7.0) {
        height = 70;
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y-44, self.view.frame.size.width, self.view.frame.size.height);
    }
    int sizeHeight = 200;
    if ([UIScreen mainScreen].bounds.size.height<500) {
        sizeHeight = 120;
    }
    self.allUrlArray = [NSMutableArray array];
    
    #pragma mark 发表栏
    _comment = [[UITextView alloc]initWithFrame:CGRectMake(20, 40, 280, sizeHeight)];
    self.comment.delegate = self;
    _comment.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    _comment.layer.cornerRadius = 2;
    _comment.font = [UIFont systemFontOfSize:17];
    _UploadImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, height+40, 280, sizeHeight)];
    _UploadImageView.backgroundColor = [UIColor clearColor];
    _UploadImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_UploadImageView];
    
    #pragma mark 发表栏工具栏
    UIView * toolView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, 280, 40)];
    toolView.backgroundColor = [UIColor colorWithWhite:1.000 alpha:0.500];
    toolView.layer.cornerRadius = 2;
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 40)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(exitEditing) forControlEvents:UIControlEventTouchUpInside];
    
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor clearColor];
    button.showsTouchWhenHighlighted = YES;
    [toolView addSubview:button];
    [button release];
    button = [[UIButton alloc]initWithFrame:CGRectMake(toolView.bounds.size.width-50, 0, 40, 40)];
    [button setTitleColor:[UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.770] forState:UIControlStateNormal];
    [button setTitle:@"发送" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    button.backgroundColor = [UIColor clearColor];
    button.showsTouchWhenHighlighted = YES;
    [toolView addSubview:button];
    [button release];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((toolView.bounds.size.width-40)/2, 0, 40, 40)];
    titleLabel.text = @"发布";
    titleLabel.textColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.420];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [toolView addSubview:titleLabel];
    [titleLabel release];
    
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 38, 240, 0.5)];
    label.backgroundColor = [UIColor blueColor];
    [toolView addSubview:label];
    
    MybottomView = [[UIView alloc]initWithFrame:CGRectMake(0, height-self.view.frame.size.height/2, self.view.bounds.size.width, _comment.bounds.size.height + toolView.bounds.size.height)];
    
    [MybottomView addSubview:_comment];
    [MybottomView addSubview:toolView];
    [self.view addSubview:MybottomView];
    [MybottomView release];
    [label release];
    [toolView release];
    
    
    //创建位置解析
    _adressParser = [[JeffyHumorousColsction alloc]init];
    _adressParser.delegate = self;
#pragma mark 创建一个键盘工具栏
    _keyboardtool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];


    UIBarButtonItem *location = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"loacation.png"] style:UIBarButtonItemStylePlain target:self action:@selector(location:)];
    UIBarButtonItem *takePhotos = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"photo"] style:UIBarButtonItemStylePlain target:self action:@selector(acheivePic)];
    UIBarButtonItem *cameraShooting = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"view"] style:UIBarButtonItemStylePlain target:self action:@selector(cameraShooting)];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消"style:UIBarButtonItemStylePlain target:self action:@selector(exitEditing)];
    [cancel setTintColor:[UIColor redColor]];
    UIBarButtonItem *flax = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

    
    NSArray *array = @[location,takePhotos,cameraShooting,flax,cancel];
    [self.keyboardtool setItems:array animated:YES];
    _comment.inputAccessoryView = _keyboardtool;
    [location release];
    [takePhotos release];
    [cameraShooting release];
    [flax release];
    //添加
    boundary = [[NSString stringWithFormat:@"----------------%d---------",(int)[[NSDate date] timeIntervalSince1970]] retain];
    
}

- (void)commentsStartAnimation
{
    if (MybottomView.frame.origin.y>0) {
        return;
    }
    _comment.text = @"";
    _UploadImageView.image = nil;
    _videoAddress = nil;
    [self.allUrlArray removeAllObjects];
    [UIView animateWithDuration:0.25 animations:^{
        MybottomView.frame = CGRectMake(0, MybottomView.frame.origin.y + self.view.frame.size.height/2, MybottomView.frame.size.width, MybottomView.frame.size.height);
    }];
    [_comment becomeFirstResponder];
    

}








- (void)acheivePic
{
   UIActionSheet * sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择",@"拍照", nil];
    [sheetView showInView:self.view.window];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self myMethod:nil];
            break;
        case 1:
            [self takePhotos];
            break;
        default:
            break;
    }
}


- (void)takePhotos
{
     _videoAddress = nil;
    VideoRecordViewController *takephoto = [[VideoRecordViewController alloc]init];
    takephoto.HLdelegate = self;
    takephoto.mediaTypes = [NSArray arrayWithObjects:@"public.image", nil];
    [self.view.window.rootViewController presentViewController:takephoto animated:YES completion:^{
    }];
    [takephoto release];
}
#pragma mark 拍照回来的照片
- (void)hlImage:(UIImage *)Image
{
    _UploadImageView.image = [self compress:Image];
}

- (void)cameraShooting
{
   
    VideoRecordViewController *cameraShooting = [[VideoRecordViewController alloc]init];
    cameraShooting.HLdelegate = self;
    cameraShooting.mediaTypes = [NSArray arrayWithObjects:@"public.movie", nil];
    [self.view.window.rootViewController presentViewController:cameraShooting animated:YES completion:^{
    }];
    


}
- (void)hlVideoWithMp4Path:(NSString *)urlString andImage:(UIImage *)image
{
    CGSize newSize = CGSizeMake(280, 140);
    _UploadImageView.image = [image scaleToFitSize:newSize];
    _videoAddress = urlString;
}



#pragma mark 发表按钮的相关操作
- (void)uploadAction
{
    //关闭发表按钮
    self.rightIterm.enabled = NO;
    //自身retain加1防止被释放;
    [self retain];
    //添加加载效果的菊花
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    if ([[UIDevice currentDevice].systemVersion floatValue]<7.0){
        loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 64, 320, 20)];
        loadLabel.text = @"正在上传...";
        loadLabel.textAlignment = NSTextAlignmentCenter;
        activityIndicatorView.center = CGPointMake(loadLabel.bounds.size.width/2+50, loadLabel.bounds.size.height/2);
    }else
    {
        loadLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 20)];
        loadLabel.text = @"                 正在上传...";
        activityIndicatorView.center = CGPointMake(loadLabel.bounds.size.width/2-30, loadLabel.bounds.size.height/2);
    }
    
    loadLabel.tag = 101;
    loadLabel.backgroundColor = [UIColor colorWithRed:1.000 green:0.000 blue:0.000 alpha:0.780];
    loadLabel.font = [UIFont systemFontOfSize:12];
    loadLabel.adjustsFontSizeToFitWidth = YES;
    [loadLabel addSubview:activityIndicatorView];
    [activityIndicatorView startAnimating];
    [activityIndicatorView release];
    [self.view.window addSubview:loadLabel];
    [loadLabel release];

    //将发表的 心情存入到数据库
    //首先将文字图片视频全部装换为网址   调用upload php
    
    [self upload];
    //在完成上传的方法里面实现以下操作
    
    //得到返回的网址,调用插入心情的php   存储到服务器
    //    [self insertShare];
    
    //返回原创社区
    [self exitEditing];
}
- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response
{
    mutableData = [[NSMutableData alloc] init];
    return request;
}
//获取发送的进度
- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [mutableData appendData:data];
    
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    NSArray *array = [NSJSONSerialization JSONObjectWithData:mutableData options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dic in array) {
        NSString *url = [dic objectForKey:@"url"];
        [self.allUrlArray addObject:url];
    }
    
    //得到返回的网址,调用插入心情的php   存储到服务器
    [self insertShare];
    
}
- (void)insertShare
{
    
    UserInfo *user = [UserInfo userShare];
    
    
    //显示时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd HH:mm"];
    NSString *dateString = [formatter stringFromDate:date];
    [formatter release];
    //插入share的接口
    NSString * url = @"http://msg.lanou3g.com/student/class_11/team_three/resource/AllPHP/JJInsertShare.php";
    
    ShareMood *mood = [[ShareMood alloc] init];
    
    
    mood.userName = user.userName;
    mood.publishedTime = dateString;
    
    //判断是否为没有图片
    mood.contentURL = self.allUrlArray[0];
    if (_UploadImageView.image ) {
        mood.pictureURL = self.allUrlArray[1];
    }
    //判断
    if (_videoAddress) {
        mood.videoURL = self.allUrlArray[2];

    }
    
    //用户的头像
    NSString *userImagepath = [NSString stringWithFormat:@"Photoes/%@",user.userName];
    UIImage *image = [UIImage imageWithContentsOfFile:Cachespath(userImagepath)];
    //判断头像是否为空
    if (image) {
        mood.userImageURL = self.allUrlArray[3];
    }else{
        mood.userImageURL = @"";
    }

    
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"",@"userID",mood.userName,@"userName",mood.userImageURL,@"userImageURL",mood.publishedTime,@"publishedTime",mood.contentURL,@"contentURL",mood.pictureURL,@"pictureURL",mood.videoURL,@"videoURL",@"",@"comment",nil];
    [mood release];
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *content = [@"jsonContent" stringByAppendingFormat:@"=%@",jsonString];
    [jsonString release];
    
    _insertParser = [[JeffyHumorousColsction alloc] init];
    _insertParser.delegate = self;
    [_insertParser dataPOSTWithUrl:url body:[content dataUsingEncoding:NSUTF8StringEncoding]];
}
#pragma mark 需要上床的body
- (NSData *)body
{
    UserInfo *user = [UserInfo userShare];
    //用户的头像
    NSString *userImagepath = [NSString stringWithFormat:@"Photoes/%@",user.userName];
    UIImage *image = [UIImage imageWithContentsOfFile:Cachespath(userImagepath)];
    
    NSDate *date = [NSDate date];
    
    
    NSString *content_Dispostion_text = [NSString stringWithFormat:@"Content-Disposition: attachment; name=\"textfile\";filename=\"%d.text\"\r\n",(int)[date timeIntervalSince1970]];
    NSString *content_Dispostion_image = [NSString stringWithFormat:@"Content-Disposition: attachment; name=\"imagefile\";filename=\"%d.jpg\"\r\n",(int)[date timeIntervalSince1970]+2];
    NSString *content_Dispostion_video = [NSString stringWithFormat:@"Content-Disposition: attachment; name=\"videofile\";filename=\"%d.mp4\"\r\n",(int)[date timeIntervalSince1970]+4];
    NSString *content_Dispostion_userImage = [NSString stringWithFormat:@"Content-Disposition: attachment; name=\"photofile\";filename=\"%d.jpg\"\r\n",(int)[date timeIntervalSince1970]+6];
    
    NSString *content_Type = @"Content-Type: application/octet-stream\r\n\r\n";
    NSMutableData *body = [NSMutableData data];
    
    
    //文本
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[content_Dispostion_text dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[content_Type dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[_comment.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    //image
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[content_Dispostion_image dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[content_Type dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:UIImageJPEGRepresentation(_UploadImageView.image, 1.0f)];
    
    //video
    NSData *data = [[NSData alloc]initWithContentsOfFile:_videoAddress];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[content_Dispostion_video dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[content_Type dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    [data release];


    
    //用户头像  photo
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[content_Dispostion_userImage dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[content_Type dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:UIImageJPEGRepresentation(image, 1.0f)];

    
    
    
    
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    //    bodyLength = body.length;
    return body;
    
}

- (void)upload
{

    NSURL *url = [NSURL URLWithString:@"http://124.205.147.26/student/class_11/team_three/resource/AllPHP/JJUpload.php"];
    
    NSMutableURLRequest *resquest = [NSMutableURLRequest requestWithURL:url];
    [resquest setHTTPMethod:@"POST"];
    //文件格式
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    
    [resquest setValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSData *body = [self body];
    
    [resquest setHTTPBody:body];
    [NSURLConnection connectionWithRequest:resquest delegate:self];
    
    
}

- (void)location:(UIBarButtonItem *)senter
{
    [self setupLocationManager];
}
#pragma mark 地图代理获取当前位置
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [_locationManager stopUpdatingLocation];
    [_adressParser dataGetWithUrl:DZJAddress(newLocation.coordinate.latitude, newLocation.coordinate.longitude)];
    
}

- (void) setupLocationManager {
    if (!_locationManager) {
         _locationManager = [[CLLocationManager alloc] init];
    }
   
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = 100;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
    }

}
- (void)requestDataSuccessful:(JeffyHumorousColsction *)humConnection
{
    if (humConnection ==_insertParser) {
        [UIView animateWithDuration:1 animations:^{
            loadLabel.alpha = 0;
        }completion:^(BOOL finished) {
           [loadLabel removeFromSuperview];
        }];
        self.rightIterm.enabled = YES;
        [self.target performSelector:self.action];
        //计数减一
        [self release];
    }
    
    if (humConnection == _adressParser) {
        NSMutableString *currentAddress = [NSJSONSerialization JSONObjectWithData:humConnection.receiveData options:NSJSONReadingMutableContainers error:nil][@"results"][0][@"formatted_address"];
        NSString *str = [NSString stringWithFormat:@"\n\t\t----%@",[currentAddress substringFromIndex:2]];
        _comment.text =   [_comment.text stringByAppendingString:  str];
    }
}



#pragma mark 打开相册
-(void) myMethod:(id)sender{
    UIImagePickerController *pc = [[UIImagePickerController alloc]init];
    pc.delegate = self;
    pc.allowsEditing = YES;
    pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.view.window.rootViewController presentViewController:pc animated:YES completion:^{
        
    }];
    [pc release];
}

#pragma mark 代理方法
-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _UploadImageView.image = [self compress:image];
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [_comment becomeFirstResponder];
}


-(UIImage *)compress:(UIImage *)image
{
    return [image scaleToFillSize:[image creatSize]];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //结束编辑状态侧边栏恢复滚动并移除发表页面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeScroll" object:nil userInfo:nil];

}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    //结束编辑状态侧边栏恢复滚动并移除发表页面
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeScroll" object:nil userInfo:nil];
}

- (void)exitEditing
{
    [self.comment endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        if (MybottomView.frame.origin.y >0) {
             MybottomView.frame = CGRectMake(0, MybottomView.frame.origin.y - self.view.bounds.size.height/2, MybottomView.bounds.size.width, MybottomView.bounds.size.height);
        }
    }completion:^(BOOL finished) {
        [self.view removeFromSuperview];
}];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if ([self isViewLoaded] && ![self.view window]) {
        self.view = nil;
        self.allUrlArray = nil;
        self.insertParser = nil;
        
        self.videoAddress = nil;
        self.keyboardtool = nil;
        self.adressParser = nil;
        self.comment = nil;
        self.UploadImageView = nil;
        self.locationManager = nil;
        
    }
    // Dispose of any resources that can be recreated.
}

@end
