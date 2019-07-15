//
//  XWPrePermissionMicrophone.h
//  XW
//
//  Created by 邱学伟 on 2019/7/12.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWPrePermissionMicrophone : NSObject
+ (BOOL)authorized;
+ (void)authorizeCompletion:(void(^)(BOOL isAuthorized, BOOL isFirstTime))completion;
@end

NS_ASSUME_NONNULL_END
