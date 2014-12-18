//
//  BottomView.h
//  TextProgect
//
//  Created by dongzhejia on 13-11-29.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UITableView<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
@property(nonatomic,retain) UIImageView *background;
@property(nonatomic,retain) UIImageView* userImageView;;
@property(nonatomic,retain) UILabel * username;
@end
