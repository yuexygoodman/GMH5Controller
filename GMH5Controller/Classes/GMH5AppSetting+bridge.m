//
//  GMH5AppSetting+bridge.m
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/11/2.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import "GMH5AppSetting+bridge.h"

@implementation GMH5AppSetting (bridge)

- (NSString *)bridgeName {
    return [self objectForKey:kGMH5Setting_BridgeName];
}

@end
