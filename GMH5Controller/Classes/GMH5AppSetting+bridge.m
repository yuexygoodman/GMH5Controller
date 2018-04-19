//
//  GMH5AppSetting+bridge.m
//  GMH5Controller
//
//  Created by Good Man on 2017/11/2.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5AppSetting+bridge.h"

@implementation GMH5AppSetting (bridge)

- (NSString *)bridgeName {
    return [self objectForKey:kGMH5Setting_BridgeName];
}

- (void)setBridgeName:(NSString *)bridgeName {
    [self removeObjectForKey:kGMH5Setting_BridgeName];
    [self setObject:bridgeName forKey:kGMH5Setting_BridgeName];
}

- (NSString *)startJS {
    return [self objectForKey:kGMH5Setting_StartJS];
}

- (void)setStartJS:(NSString *)startJS {
    [self removeObjectForKey:kGMH5Setting_StartJS];
    [self setObject:startJS forKey:kGMH5Setting_StartJS];
}

- (NSString *)endJS {
    return [self objectForKey:kGMH5Setting_EndJS];
}

- (void)setEndJS:(NSString *)endJS {
    [self removeObjectForKey:kGMH5Setting_EndJS];
    [self setObject:endJS forKey:kGMH5Setting_EndJS];
}

@end
