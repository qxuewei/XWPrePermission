//
//  XWPrePermission.h
//  XW
//
//  Created by 邱学伟 on 2019/7/12.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///  isAuthorized : 是否已被授权   isFirstTime : 是否第一次请求该权限
typedef void(^XWPrePermissionAuthorizationCompletion)(BOOL isAuthorized, BOOL isFirstTime);

typedef NS_ENUM(NSUInteger, XWPrePermissionType) {
    XWPrePermissionTypeLocation,
    XWPrePermissionTypeCamera,
    XWPrePermissionTypePhotos,
    XWPrePermissionTypeMicrophone,
};

@interface XWPrePermission : NSObject

+ (BOOL)authorizedType:(XWPrePermissionType)type;

+ (void)authorizedType:(XWPrePermissionType)type completion:(XWPrePermissionAuthorizationCompletion)completion;

@end

NS_ASSUME_NONNULL_END
