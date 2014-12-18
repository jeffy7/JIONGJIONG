//
//  VideoRecordViewController.m
//  JIONGJIONG
//
//  Created by dongzhejia on 13-12-19.
//  Copyright (c) 2013年 dongzhejia. All rights reserved.
//

#import "VideoRecordViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "HLVideoFirst.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface VideoRecordViewController ()
{
    NSURL * _hlAudioVideoURL;
    NSString * _mp4Quality;
    NSString * _mp4Path;
}
@end

static inline NSString * hlMoviesPath(){
    return [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
            stringByAppendingPathComponent:@"DZJPhotoes"];
    
}


@implementation VideoRecordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}


- (void)hlImageEcode:(UIImage *)image
{
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        data =UIImageJPEGRepresentation(image, 1.0);
    }
    UIImage *hlImage = [UIImage imageWithData:data];
    [self performSelectorOnMainThread:@selector(hldelegate:) withObject:hlImage waitUntilDone:YES];
}

- (void)hldelegate:(UIImage *)image
{
    
    if ([_HLdelegate respondsToSelector:@selector(hlImage:)]) {
        [_HLdelegate performSelector:@selector(hlImage:) withObject:image];
    }
}


-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if ( (NSString *)(info [UIImagePickerControllerMediaType]) == (NSString *)kUTTypeImage ) {
        //图片
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self performSelectorInBackground:@selector(hlImageEcode:) withObject:image];
}else{
        //视频
        
       _hlAudioVideoURL = info[UIImagePickerControllerMediaURL];
        [self videoTranscodingToMp4WithURL:_hlAudioVideoURL];
    }
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
}

- (void)videoTranscodingToMp4WithURL:(NSURL *)url
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:url options:nil];
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    if ([compatiblePresets containsObject:_mp4Quality])
        
    {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:_mp4Quality];
        
        
        _mp4Path = [[hlMoviesPath() stringByAppendingFormat:@"/%d.mp4", (int)[NSDate timeIntervalSinceReferenceDate ]] retain];
       
        
        exportSession.outputURL = [NSURL fileURLWithPath: _mp4Path];
        exportSession.shouldOptimizeForNetworkUse = YES;
        exportSession.outputFileType = AVFileTypeMPEG4;
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
        
            if ([exportSession status] == AVAssetExportSessionStatusCompleted) {
                
                [self performSelectorOnMainThread:@selector(hlFirstImageWith:) withObject:[NSURL fileURLWithPath:_mp4Path]  waitUntilDone:NO];
                
            }
            [exportSession release];
        }];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"AVAsset doesn't support mp4 quality"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void)hlFirstImageWith:(NSURL *) videoURL
{
    UIImage *image_new = [HLVideoFirst hlMovieFirstImage:videoURL];
    if ([_HLdelegate respondsToSelector:@selector(hlVideoWithMp4Path:andImage:)]) {
        [_HLdelegate performSelector:@selector(hlVideoWithMp4Path:andImage:) withObject:_mp4Path withObject:image_new];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:^{
}];
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    self.videoQuality = UIImagePickerControllerQualityTypeMedium;
    
    //        NSArray* availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    //        self.mediaTypes = @[availableMedia[0], availableMedia[1]];
    //设置拍摄质量
    self.videoQuality = UIImagePickerControllerQualityTypeMedium;
    self.allowsEditing = YES;
    self.delegate = self;
    
    _mp4Quality = AVAssetExportPresetMediumQuality;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:hlMoviesPath() isDirectory:&isDir] && isDir) {
        
    }else{
        [fileManager createDirectoryAtPath:hlMoviesPath() withIntermediateDirectories:YES attributes:Nil error:NULL];
        
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
