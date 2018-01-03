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

@end
