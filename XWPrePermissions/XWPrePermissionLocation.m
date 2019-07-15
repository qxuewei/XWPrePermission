//
//  XWPrePermissionLocation.m
//  XW
//
//  Created by 邱学伟 on 2019/7/12.
//  Copyright © 2019 邱学伟. All rights reserved.
//

#import "XWPrePermissionLocation.h"
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

@interface XWPrePermissionLocation ()<CLLocationManagerDelegate>
@property(nonatomic,strong) CLLocationManager *locationManager;
@property (nonatomic, copy) void(^p_completion)(BOOL isAuthorized, BOOL isFirstTime);
@end

@implementation XWPrePermissionLocation

+ (instancetype)share
{
    static XWPrePermissionLocation * _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[XWPrePermissionLocation alloc] init];
    });
    return _sharedInstance;
}

+ (BOOL)authorized
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    return (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse);
}

+ (void)authorizeCompletion:(void (^)(BOOL, BOOL))completion
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            completion ? completion(YES, NO) : nil;
        }
            break;
        case kCLAuthorizationStatusNotDetermined:
        {
            if (![self isServicesEnabled]) {
                completion ? completion(NO, NO) : nil;
            } else {
                [[XWPrePermissionLocation share] startUpdatingLocation:completion];
            }
        }
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {
            completion ? completion(NO, NO) : nil;
        }
            break;
    }
}

+ (BOOL)isServicesEnabled
{
    return [CLLocationManager locationServicesEnabled];
}

- (void)startUpdatingLocation:(void(^)(BOOL isAuthorized, BOOL isFirstTime))completion
{
    if (self.locationManager) {
        [[XWPrePermissionLocation share] stopUpdatingLocation];
    }
    self.p_completion = completion;
    self.locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        BOOL isHasAlwaysKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"] != nil;
        BOOL isHasWhenInUserKey = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"] != nil;
        if (isHasAlwaysKey) {
            [_locationManager requestAlwaysAuthorization];
        } else if (isHasWhenInUserKey) {
            [_locationManager requestWhenInUseAuthorization];
        } else {
            NSLog(@"请检查您 info.plist 的配置!!!!!");
        }
    }
    [_locationManager startUpdatingLocation];
    
}

- (void)stopUpdatingLocation
{
    if (self.locationManager) {
        [self.locationManager stopUpdatingLocation];
        self.locationManager = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            {
                
            }
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            [self stopUpdatingLocation];
            _p_completion ? _p_completion(YES, YES) : nil;
            _p_completion = nil;
        }
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
        {
            [self stopUpdatingLocation];
            _p_completion ? _p_completion(NO, YES) : nil;
            _p_completion = nil;
        }
            break;
    }
}

@end
