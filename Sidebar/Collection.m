//
//  Collection.m
//  JIONGJIONG
//
//  Created by lanou on 13-12-4.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "Collection.h"

@implementation Collection


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_collectHum forKey:@"hum"];
    [aCoder encodeObject:_collectImage forKey:@"image"];
    [aCoder encodeObject:_userImage forKey:@"useIm"];
    [aCoder encodeObject:_userName forKey:@"name"];
    [aCoder encodeObject:_vedioURL forKey:@"vedio"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.collectHum = [aDecoder decodeObjectForKey:@"hum"];
        self.collectImage = [aDecoder decodeObjectForKey:@"image"];
        self.userImage = [aDecoder decodeObjectForKey:@"useIm"];
        self.userName = [aDecoder decodeObjectForKey:@"name"];
        self.vedioURL = [aDecoder decodeObjectForKey:@"vedio"];
    }
    return self;
}
@end
