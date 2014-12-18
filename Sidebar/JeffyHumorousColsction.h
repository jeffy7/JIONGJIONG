//
//  JeffyHumorousColsction.h
//  Program
//
//  Created by lanou on 13-12-2.
//  Copyright (c) 2013年 je_ffy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JeffyHumorousColsction;
@protocol JeffyHumorousColsctionDelegate <NSObject>

- (void)requestDataSuccessful:(JeffyHumorousColsction *)humConnection;

@end

@interface JeffyHumorousColsction : NSObject

@property (nonatomic,retain)NSMutableData *receiveData;
@property (nonatomic,assign)id <JeffyHumorousColsctionDelegate> delegate;
@property (nonatomic,retain)NSURLConnection *connection;

//两种方法 实现亲请求数据
- (void)dataGetWithUrl:(NSString *)urlString;
- (void)dataPOSTWithUrl:(NSString *)urlStrig body:(NSData *)data;

- (void)cancelResquest;
@end
