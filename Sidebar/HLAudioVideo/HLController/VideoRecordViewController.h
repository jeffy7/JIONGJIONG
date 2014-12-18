//
//  VideoRecordViewController.h
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-19.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLVideoRecordViewControllerDelegate <NSObject>

@optional
- (void)hlVideoWithMp4Path:(NSURL *)url;    //DEPRECATED 2013.12.17

- (void)hlImage:(UIImage *)Image;

- (void)hlVideoWithMp4Path:(NSString *)urlString  andImage:(UIImage *)image;

@end

@interface VideoRecordViewController : UIImagePickerController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, assign)id<HLVideoRecordViewControllerDelegate> HLdelegate;
@end
