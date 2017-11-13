//
//  GMH5AppSetting+bridge.h
//  GMH5Controller
//
//  Created by 岳潇洋 on 2017/11/2.
//  Copyright © 2017年 岳潇洋. All rights reserved.
//

#import "GMH5AppSetting.h"

#define kGMH5Setting_BridgeName @"BridgeName" // set the name of js object.

@interface GMH5AppSetting (bridge)

@property(copy,nonatomic,readonly) NSString * bridgeName;

@end
