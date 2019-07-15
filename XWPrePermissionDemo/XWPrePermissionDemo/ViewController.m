//
//  ViewController.m
//  XWPrePermissionDemo
//
//  Created by 邱学伟 on 2019/7/15.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import "ViewController.h"
#import "XWPrePermission.h"
#import "XWPrePermissionSetting.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"\n XWPrePermissionTypeLocation: (%d) \n XWPrePermissionTypeCamera: (%d) \n XWPrePermissionTypePhotos: (%d) \n XWPrePermissionTypeMicrophone: (%d) \n",[XWPrePermission authorizedType:XWPrePermissionTypeLocation],[XWPrePermission authorizedType:XWPrePermissionTypeCamera],[XWPrePermission authorizedType:XWPrePermissionTypePhotos],[XWPrePermission authorizedType:XWPrePermissionTypeMicrophone]);
    
    [XWPrePermission authorizedType:XWPrePermissionTypeLocation completion:^(BOOL isAuthorized, BOOL isFirstTime) {
        NSLog(@"\n\n XWPrePermissionTypeLocation: isAuthorized (%d) +++ isFirstTime (%d) \n\n",isAuthorized,isFirstTime);
    }];
    
    [XWPrePermission authorizedType:XWPrePermissionTypeCamera completion:^(BOOL isAuthorized, BOOL isFirstTime) {
        NSLog(@"\n\n XWPrePermissionTypeCamera: isAuthorized (%d) +++ isFirstTime (%d) \n\n",isAuthorized,isFirstTime);
    }];
    
    [XWPrePermission authorizedType:XWPrePermissionTypePhotos completion:^(BOOL isAuthorized, BOOL isFirstTime) {
        NSLog(@"\n\n XWPrePermissionTypePhotos: isAuthorized (%d) +++ isFirstTime (%d) \n\n",isAuthorized,isFirstTime);
    }];
    
    [XWPrePermission authorizedType:XWPrePermissionTypeMicrophone completion:^(BOOL isAuthorized, BOOL isFirstTime) {
        NSLog(@"\n\n XWPrePermissionTypeMicrophone: isAuthorized (%d) +++ isFirstTime (%d) \n\n",isAuthorized,isFirstTime);
    }];
    
    [XWPrePermission authorizedType:XWPrePermissionTypeLocation completion:^(BOOL isAuthorized, BOOL isFirstTime) {
        NSLog(@"\n\n XWPrePermissionTypeLocation: isAuthorized (%d) +++ isFirstTime (%d) \n\n",isAuthorized,isFirstTime);
        if (!isAuthorized && !isFirstTime) {
            [XWPrePermissionSetting showAlertToSettingWithTitle:@"提示" message:@"前往设置开启定位权限" cancel:@"不要🙅‍♀️" setting:@"(*^◎^*)好啊" completion:^(BOOL isCancel) {
                
            }];
        }
    }];
    
}


@end
