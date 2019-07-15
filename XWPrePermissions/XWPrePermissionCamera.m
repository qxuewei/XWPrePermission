//
//  XWPrePermissionCamera.m
//  XW
//
//  Created by 邱学伟 on 2019/7/12.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import "XWPrePermissionCamera.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@implementation XWPrePermissionCamera
+ (BOOL)authorized
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    return status == AVAuthorizationStatusAuthorized;
}

+ (void)authorizeCompletion:(void(^)(BOOL isAuthorized, BOOL isFirstTime))completion
{
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (status) {
        case AVAuthorizationStatusAuthorized:
        {
            completion ? completion(YES,NO) : nil;
        }
            break;
        case AVAuthorizationStatusDenied:
        case AVAuthorizationStatusRestricted:
        {
            completion ? completion(NO,NO) : nil;
        }
                break;
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion ? completion(granted,YES) : nil;
                });
            }];
        }
            break;
    }
}
@end
