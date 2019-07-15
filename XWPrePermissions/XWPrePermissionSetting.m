//
//  XWPrePermissionSetting.m
//  XW
//
//  Created by 邱学伟 on 2019/7/13.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import "XWPrePermissionSetting.h"
#import <UIKit/UIKit.h>

@implementation XWPrePermissionSetting

+ (void)showAlertToSettingWithTitle:(NSString *)title
                            message:(NSString *)message
                             cancel:(NSString *)cancel
                            setting:(NSString *)setting
                         completion:(void(^)(BOOL isCancel))completion {
    
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    //cancel
    UIAlertAction *action = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        if (completion) {
            completion(YES);
        }
    }];
    [alertController addAction:action];
    
    //ok
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:setting style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (completion) {
            completion(NO);
        }
        
        [self displayAppPrivacySettings];
    }];
    [alertController addAction:okAction];
    
    [[self currentTopViewController] presentViewController:alertController animated:YES completion:nil];
}

+ (void)displayAppPrivacySettings
{
    if (@available(iOS 8,*))
    {
        if (UIApplicationOpenSettingsURLString != NULL)
        {
            NSURL *appSettings = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            
            if (@available(iOS 10,*)) {
                [[UIApplication sharedApplication]openURL:appSettings options:@{} completionHandler:^(BOOL success) {
                }];
            }
            else
            {
                [[UIApplication sharedApplication]openURL:appSettings];
            }
        }
    }
}

+ (UIViewController*)currentTopViewController
{
    UIViewController *currentViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    while ([currentViewController presentedViewController])    currentViewController = [currentViewController presentedViewController];
    
    if ([currentViewController isKindOfClass:[UITabBarController class]]
        && ((UITabBarController*)currentViewController).selectedViewController != nil )
    {
        currentViewController = ((UITabBarController*)currentViewController).selectedViewController;
    }
    
    while ([currentViewController isKindOfClass:[UINavigationController class]]
           && [(UINavigationController*)currentViewController topViewController])
    {
        currentViewController = [(UINavigationController*)currentViewController topViewController];
    }
    
    return currentViewController;
}

@end
