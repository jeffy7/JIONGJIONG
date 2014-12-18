//
//  ShareMood.h
//  PHPTextTest
//
//  Created by lanou on 13-12-9.
//  Copyright (c) 2013年 je_ffy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShareMood : NSObject

@property (nonatomic,assign)int userID;
@property (nonatomic,retain)NSString *userName;
//@property (nonatomic,retain) UIImage *image;
@property (nonatomic,retain)NSString *userImageURL;//未完待续
@property (nonatomic,retain)NSString *publishedTime;
@property (nonatomic,retain)NSString *contentURL;
@property (nonatomic,retain)NSString *pictureURL;
@property (nonatomic,retain)NSString *videoURL;
@property (nonatomic,retain)NSString *comment;

- (void)initWithDictionary:(NSDictionary *)dic;
@end
