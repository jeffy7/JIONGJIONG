//
//  HLVideoFirst.h
//  HLPlayVideo
//
//  Created by HL on 12/10/13.
//  Copyright (c) 2013 Dream. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLVideoFirst : UIImage

+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;

+(UIImage *)movieFirstFrameToImage:(NSString *)moviePath;

+ (UIImage *)hlMovieFirstImage:(NSURL*)videoURL;

@end
