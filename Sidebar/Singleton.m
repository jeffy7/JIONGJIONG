//
//  Singleton.m
//  UpLoad
//
//  Created by lanou on 13-12-7.
//  Copyright (c) 2013年 je_ffy. All rights reserved.
//

#import "Singleton.h"

@implementation Singleton

static Singleton *singl = nil;
- (void)dealloc
{
    [_content release];
    [super dealloc];
}
+ (Singleton *)instance
{
    if (!singl) {
        singl = [[self alloc] init];
    }
    return singl;
}
- (id)init
{
   self = [super init];
    if (self) {
        self.isUploading = NO;
        self.isDownloading = NO;
    }
    return self;
}
@end
