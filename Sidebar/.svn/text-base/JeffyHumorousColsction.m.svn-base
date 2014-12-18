//
//  JeffyHumorousColsction.m
//  Program
//
//  Created by lanou on 13-12-2.
//  Copyright (c) 2013年 je_ffy. All rights reserved.
//

#import "JeffyHumorousColsction.h"

@implementation JeffyHumorousColsction


-(void)dealloc
{
    [_receiveData release];
    [_connection release];
    [super dealloc];
}
- (void)cancelResquest
{
    [_connection cancel];
    _connection = nil;
    _delegate = nil;

}
- (void)dataGetWithUrl:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:60];
    
    self.connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
}
- (void)dataPOSTWithUrl:(NSString *)urlStrig body:(NSData *)data
{
    //要用到时再写
    NSURL * url = [NSURL URLWithString:urlStrig];
    
	NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    
	[request setHTTPMethod:@"POST"];
	[request setHTTPBody:data];
    
	self.connection = [NSURLConnection connectionWithRequest:request delegate:self];}


#pragma mark ------------------------
#pragma mark 代理方法  实现接收数据
//回传数据的开始
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.receiveData = [NSMutableData data];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_receiveData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if ([self.delegate respondsToSelector:@selector(requestDataSuccessful:)]) {
        [self.delegate requestDataSuccessful:self];
    }

}






@end
