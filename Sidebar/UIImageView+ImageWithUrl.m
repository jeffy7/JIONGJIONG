//
//  UIImageView+ImageWithUrl.m
//  MultithreadHomeWork
//
//  Created by dongzhejia on 13-12-12.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "UIImageView+ImageWithUrl.h"
#import "webAddress.h"
@implementation UIImageView (ImageWithUrl)
-(void)loadImageWithUrlSting:(NSString *)urlSting
{
    self.tag ++;
    self.image = nil;
    if (urlSting.length<1||!urlSting) {
        return;
    }
    self.image = [UIImage imageNamed:@"defut"];
    //创建路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imageDirectory = Cachespath(@"DZJPhotoes/");
    [fileManager createDirectoryAtPath:imageDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSString *imageName = [[urlSting componentsSeparatedByString:@"/"] lastObject];
    //创建存储图片的路径
    NSString *str = [NSString stringWithFormat:@"DZJPhotoes/%@",imageName];
    NSString *imagePath = Cachespath(str);
//    //添加加载效果的菊花
//    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    activityIndicatorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
//    [self addSubview:activityIndicatorView];
//    [activityIndicatorView startAnimating];
    
    
    //自定义队列
    dispatch_queue_t queue = dispatch_queue_create([[NSString stringWithFormat:@"%d",self.tag] UTF8String], NULL);
    dispatch_async(queue, ^{
        UIImage *image;
        //如果缓存照片不存在则请求
        if (![fileManager fileExistsAtPath:imagePath]) {
            NSURL *url = [NSURL URLWithString:urlSting];
            NSData *data = [NSData dataWithContentsOfURL:url];
            image = [UIImage imageWithData:data];
            [data writeToFile:imagePath atomically:YES];
        }else
        {
            //存在则加载本地图片
            image = [UIImage imageWithContentsOfFile:imagePath];
        }
        
        //进入主线程进行操作
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.tag == atoi(dispatch_queue_get_label(queue))) {
                self.image = image;
            }
            
//            [activityIndicatorView removeFromSuperview];
//            [activityIndicatorView release];
                  });
        
        
    });
    dispatch_release(queue);
   
}

@end
