//
//  XWPrePermission.m
//  XW
//
//  Created by 邱学伟 on 2019/7/12.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import "XWPrePermission.h"
#import <objc/runtime.h>
#import <objc/message.h>

#import "XWPrePermissionLocation.h"
#import "XWPrePermissionCamera.h"
#import "XWPrePermissionPhotos.h"
#import "XWPrePermissionMicrophone.h"

@implementation XWPrePermission


+ (BOOL)authorizedType:(XWPrePermissionType)type
{
    Class cls = [self classByType:type];
    if (cls) {
        SEL sel = NSSelectorFromString(@"authorized");
        return ( ( BOOL *(*)(id,SEL) )objc_msgSend )(cls, sel);
    }
    return NO;
}

+ (void)authorizedType:(XWPrePermissionType)type completion:(XWPrePermissionAuthorizationCompletion)completion
{
    Class cls = [self classByType:type];
    if (cls) {
        SEL sel = NSSelectorFromString(@"authorizeCompletion:");
        ( ( void *(*)(id,SEL,XWPrePermissionAuthorizationCompletion) )objc_msgSend )(cls, sel, completion);
    }
}

#pragma mark - private
+ (Class)classByType:(XWPrePermissionType)type
{
    NSString *classString = nil;
    switch (type) {
        case XWPrePermissionTypeLocation:
            classString = @"XWPrePermissionLocation";
            break;
        case XWPrePermissionTypeCamera:
            classString = @"XWPrePermissionCamera";
            break;
        case XWPrePermissionTypePhotos:
            classString = @"XWPrePermissionPhotos";
            break;
        case XWPrePermissionTypeMicrophone:
            classString = @"XWPrePermissionMicrophone";
            break;
        default:
            break;
    }
    if (classString) {
        return NSClassFromString(classString);
    } else {
        return nil;
    }
}

@end
