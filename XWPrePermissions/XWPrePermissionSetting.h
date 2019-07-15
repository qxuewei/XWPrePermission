//
//  XWPrePermissionSetting.h
//  XW
//
//  Created by 邱学伟 on 2019/7/13.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XWPrePermissionSetting : NSObject

+ (void)showAlertToSettingWithTitle:(NSString *)title
                            message:(NSString *)message
                             cancel:(NSString *)cancel
                            setting:(NSString *)setting
                         completion:(void(^)(BOOL isCancel))completion;

@end

NS_ASSUME_NONNULL_END
