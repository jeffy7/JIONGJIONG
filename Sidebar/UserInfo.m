//
//  UserInfo.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-9.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "UserInfo.h"

static UserInfo *user = nil;
@implementation UserInfo
- (void)dealloc
{
    [_userName release];
    [_photoURL release];
    [_passWord release];
    [super dealloc];
}
+(UserInfo *)userShare{
    
    
    static dispatch_once_t predicate;
    
    dispatch_once(&predicate, ^{
        user = [[UserInfo alloc] init];
    });
//    if (!user) {
//        user = [[UserInfo alloc]init];
//    }
    return user;
    
    
}

@end
