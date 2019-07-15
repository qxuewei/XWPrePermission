//
//  XWPrePermissionPhotos.m
//  XW
//
//  Created by 邱学伟 on 2019/7/12.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import "XWPrePermissionPhotos.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation XWPrePermissionPhotos
+ (BOOL)authorized
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    return status == PHAuthorizationStatusAuthorized;
}

+ (void)authorizeCompletion:(void (^)(BOOL, BOOL))completion
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    switch (status) {
        case PHAuthorizationStatusAuthorized:
        {
            completion ? completion(YES, NO) : nil;
        }
            break;
        case PHAuthorizationStatusDenied:
        case PHAuthorizationStatusRestricted:
        {
            completion ? completion(NO, NO) : nil;
        }
            break;
            
        case PHAuthorizationStatusNotDetermined:
        {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion ? completion(status == PHAuthorizationStatusAuthorized,YES) : nil;
                });
            }];
        }
            break;
    }
}

@end
