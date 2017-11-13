//
//  GMH5AppSetting+provider.m
//  GMH5Controller
//
//  Created by Good Man on 2017/11/3.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5AppSetting+provider.h"
#import "GMH5Tools.h"

@implementation GMH5AppSetting (provider)

- (NSString *)name {
    return [self objectForKey:kGMH5Setting_Name];
}

- (NSString *)url {
    return [self objectForKey:kGMH5Setting_Url];
}

- (BOOL)navigationBarHidden {
    return [self objectForKey:kGMH5Setting_NavBarHidden]?[[self objectForKey:kGMH5Setting_NavBarHidden] boolValue]:NO;
}

- (UIColor *)navBackgroundColor {
    return  [GMH5Tools colorWithHexString:[self objectForKey:kGMH5Setting_NavBgColor]];
}

- (UIColor *)titleColor {
    return  [GMH5Tools colorWithHexString:[self objectForKey:kGMH5Setting_TitleColor]];
}

- (UIColor *)statusColor {
    return [GMH5Tools colorWithHexString:[self objectForKey:kGMH5Setting_StatusColor]];
}

@end
