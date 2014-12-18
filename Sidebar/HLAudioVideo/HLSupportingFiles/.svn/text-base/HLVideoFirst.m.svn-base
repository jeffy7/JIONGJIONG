//
//  HLVideoFirst.m
//  HLPlayVideo
//
//  Created by HL on 12/10/13.
//  Copyright (c) 2013 Dream. All rights reserved.
//

#import "HLVideoFirst.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVAsset.h>

static inline NSString * hlPicturePath(){
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
            stringByAppendingPathComponent:@"Picture"];
    
}

@implementation HLVideoFirst


+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[[AVURLAsset alloc] initWithURL:videoURL options:nil]autorelease];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[[AVAssetImageGenerator alloc] initWithAsset:asset]autorelease];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    UIImage *thumbnailImage = nil;
    if (thumbnailImageRef) {
        thumbnailImage = [UIImage imageWithCGImage:thumbnailImageRef];
        CGImageRelease(thumbnailImageRef);
    }
    
    return thumbnailImage;
}


+ (UIImage *)hlMovieFirstImage:(NSURL*)videoURL
{
    NSError * error = nil;
    
//    NSString *homePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSString * picturePath = [homePath stringByAppendingPathComponent:@"Picture"];
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:hlPicturePath()]) {
        [fileManager createDirectoryAtPath:hlPicturePath() withIntermediateDirectories:YES attributes:nil error:&error];
    }
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    NSString * date = [formater stringFromDate:[NSDate date]];
    [formater release];
    
    NSString *pictureName = [hlPicturePath() stringByAppendingFormat:@"/%@.png", date];
    
    if (![fileManager fileExistsAtPath:pictureName]) {
        NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoURL options:opts];
        AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
        generator.appliesPreferredTrackTransform = YES;
        //generator.maximumSize = CGSizeMake(, );
        CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
        UIImage *image = [UIImage imageWithCGImage:img];
        CGImageRelease(img);
        [UIImagePNGRepresentation(image) writeToFile:pictureName atomically:YES];
        return image;
    }else{
        return [UIImage imageWithContentsOfFile:pictureName];
    }
    
    return nil;
}

//获取视频第一帧

+(UIImage *)movieFirstFrameToImage:(NSString *)moviePath
{
    NSURL *videoURL = [NSURL fileURLWithPath:moviePath];
    NSError *error = nil;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *home = [NSHomeDirectory()stringByAppendingPathComponent:[NSString stringWithFormat:@"Documents"]]; //得到主目录
    NSString *filename = [NSString stringWithFormat:@"Picture"];
    NSString *filepath = home;
    filepath = [filepath stringByAppendingPathComponent:filename];
    if(![manager fileExistsAtPath:filepath])
        [manager createDirectoryAtPath:filepath withIntermediateDirectories:YES attributes:nil error:&error];
    NSString *path = nil; //[filepath stringByAppendingPathComponent:[Utility getFilename:videoURL]];
    if(![manager fileExistsAtPath:path])
    {
        NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO] forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
        AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoURL options:opts];
        AVAssetImageGenerator *generator = [AVAssetImageGenerator assetImageGeneratorWithAsset:urlAsset];
        generator.appliesPreferredTrackTransform = YES;
        //generator.maximumSize = CGSizeMake(, );
        CGImageRef img = [generator copyCGImageAtTime:CMTimeMake(10, 10) actualTime:NULL error:&error];
        UIImage *image = [UIImage imageWithCGImage:img];
        CGImageRelease(img);
        [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
        return image;
    }else{
        return [UIImage imageWithContentsOfFile:path];
    }
}


@end
