//
//  XWPrePermissionMicrophone.m
//  XW
//
//  Created by 邱学伟 on 2019/7/12.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import "XWPrePermissionMicrophone.h"
#import <AVFoundation/AVFoundation.h>

@implementation XWPrePermissionMicrophone
+ (BOOL)authorized
{
    AVAudioSessionRecordPermission status = [[AVAudioSession sharedInstance] recordPermission];;
    return status == AVAudioSessionRecordPermissionGranted;
}

+ (void)authorizeCompletion:(void (^)(BOOL, BOOL))completion
{
    AVAudioSessionRecordPermission status = [[AVAudioSession sharedInstance] recordPermission];
    switch (status) {
        case AVAudioSessionRecordPermissionGranted:
        {            
            completion ? completion(YES, NO) : nil;
        }
            break;
        case AVAudioSessionRecordPermissionDenied:
        {
            completion ? completion(NO, NO) : nil;
        }
            break;
        case AVAudioSessionRecordPermissionUndetermined:
        {
            AVAudioSession *session = [[AVAudioSession alloc] init];
            NSError *error;
            [session setCategory:@"AVAudioSessionCategoryPlayAndRecord" error:&error];
            [session requestRecordPermission:^(BOOL granted) {
                if (completion) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completion ? completion(granted, YES) : nil;
                    });
                }
            }];
        }
            break;
    }
}
@end
