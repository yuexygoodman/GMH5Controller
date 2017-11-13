//
//  GMH5AppSetting+bridge.h
//  GMH5Controller
//
//  Created by Good Man on 2017/11/2.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5AppSetting.h"

#define kGMH5Setting_BridgeName @"BridgeName" // set the name of js object.

@interface GMH5AppSetting (bridge)

@property(copy,nonatomic,readonly) NSString * bridgeName;

@end
