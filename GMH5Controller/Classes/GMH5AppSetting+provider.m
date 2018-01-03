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

- (void)setName:(NSString *)name {
    [self removeObjectForKey:kGMH5Setting_Name];
    [self setObject:name forKey:kGMH5Setting_Name];
}

- (NSString *)url {
    return [self objectForKey:kGMH5Setting_Url];
}

- (void)setUrl:(NSString *)url {
    [self removeObjectForKey:kGMH5Setting_Url];
    [self setObject:url forKey:kGMH5Setting_Url];
}

- (BOOL)navigationBarHidden {
    return [self objectForKey:kGMH5Setting_NavBarHidden]?[[self objectForKey:kGMH5Setting_NavBarHidden] boolValue]:NO;
}

- (void)setNavigationBarHidden:(BOOL)navigationBarHidden {
    [self setObject:@(navigationBarHidden) forKey:kGMH5Setting_NavBarHidden];
}

- (UIColor *)navBackgroundColor {
    id obj=[self objectForKey:kGMH5Setting_NavBgColor];
    if ([obj isKindOfClass:[NSString class]]) {
        return  [GMH5Tools colorWithHexString:[self objectForKey:kGMH5Setting_NavBgColor]];
    }
    return obj;
}

- (void)setNavBackgroundColor:(UIColor *)navBackgroundColor {
    [self removeObjectForKey:kGMH5Setting_NavBgColor];
    [self setObject:navBackgroundColor forKey:kGMH5Setting_NavBgColor];
}

- (UIColor *)titleColor {
    id obj=[self objectForKey:kGMH5Setting_TitleColor];
    if ([obj isKindOfClass:[NSString class]]) {
        return  [GMH5Tools colorWithHexString:[self objectForKey:kGMH5Setting_TitleColor]];
    }
    return obj;
}

- (void)setTitleColor:(UIColor *)titleColor {
    [self removeObjectForKey:kGMH5Setting_TitleColor];
    [self setObject:titleColor forKey:kGMH5Setting_TitleColor];
}

- (UIColor *)statusColor {
    id obj=[self objectForKey:kGMH5Setting_StatusColor];
    if ([obj isKindOfClass:[NSString class]]) {
        return [GMH5Tools colorWithHexString:[self objectForKey:kGMH5Setting_StatusColor]];
    }
    return obj;
}

- (void)setStatusColor:(UIColor *)statusColor {
    [self removeObjectForKey:kGMH5Setting_StatusColor];
    [self setObject:statusColor forKey:kGMH5Setting_StatusColor];
}

@end
