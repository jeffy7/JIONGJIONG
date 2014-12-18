//
//  UploadViewController.h
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-9.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "JeffyHumorousColsction.h"
#import "VideoRecordViewController.h"
@interface UploadViewController : UIViewController<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate,JeffyHumorousColsctionDelegate,HLVideoRecordViewControllerDelegate,UIActionSheetDelegate,UITextViewDelegate>
@property(nonatomic,retain) UITextView * comment;
@property(nonatomic,retain) UIImageView *UploadImageView;
@property(nonatomic,retain) CLLocationManager *locationManager;
@property(nonatomic,retain) JeffyHumorousColsction *adressParser;
@property(nonatomic,retain) NSString *videoAddress;
@property(nonatomic,retain) UIToolbar *keyboardtool;
@property(nonatomic,assign) UIBarButtonItem *rightIterm;

@property (nonatomic,retain)NSMutableArray *allUrlArray;//存储上床数据回来的网址
@property(nonatomic,retain) JeffyHumorousColsction *insertParser;
@property (nonatomic,assign) id target;
@property (nonatomic,assign) SEL action;
- (void)commentsStartAnimation;
@end
