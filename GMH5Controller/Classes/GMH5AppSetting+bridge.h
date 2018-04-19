//
//  GMH5AppSetting+bridge.h
//  GMH5Controller
//
//  Created by Good Man on 2017/11/2.
//  Copyright © 2017年 Good Man. All rights reserved.
//

#import "GMH5AppSetting.h"

#define kGMH5Setting_BridgeName @"BridgeName" // set the name of js object.
#define kGMH5Setting_StartJS @"StartJS" // javascript that excuted at the beginning of document loading.
#define kGMH5Setting_EndJS @"EndJS" // javascript that excuted at the end of document loading.

@interface GMH5AppSetting (bridge)

@property(copy,nonatomic) NSString * bridgeName;

@property(copy,nonatomic) NSString * startJS;

@property(copy,nonatomic) NSString * endJS;

@end
